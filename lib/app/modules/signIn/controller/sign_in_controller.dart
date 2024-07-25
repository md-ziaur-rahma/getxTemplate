import 'dart:developer';
import 'dart:io';
import 'package:getx/app/core/contants.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../core/app_text.dart';
import '../../../core/shared_preference.dart';
import '../../../core/utils.dart';
import '../../../data/error/failure.dart';
import '../../../data/local_database.dart';
import '../../../routes/routes.dart';
import '../model/user_login_response_model.dart';
import '../repo/auth_repository.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository;

  LoginController(this._authRepository);

  var isLoading = false.obs;
  final obscureText = true.obs;

  var emailController = TextEditingController(text: "");
  var passwordController = TextEditingController(text: "");
  String? email;
  String? password;

  var toggle = false.obs;

  Client client = Client();
  final loginKey = GlobalKey<FormState>();

  UserLoginResponseModel? _user;
  UserLoginResponseModel? get user => _user;
  bool get isLoggedIn => _user != null && _user!.accessToken.isNotEmpty;

  var userName = "".obs;
  var userImage = "".obs;

  //for push notification
  var isNotificationActive = true.obs;

  //currency text
  var currencyText = "Tk".obs;

  //purchase data
  var isMakingPurchase = false.obs;

  @override
  void onInit() {
    final result = _authRepository.getCashedUserInfo();
    checkNotificationActive();
    checkCurrencyText();
    result.fold(
      (l) => _user = null,
      (r) {
        _user = r;
      },
    );
    super.onInit();
  }

  void validationForm(BuildContext context){
    if(emailController.text.isEmpty){
      Utils.showSnackBar(message: "Email is required");
      return;
    } else if(passwordController.text.isEmpty) {
      Utils.showSnackBar(message: "Password is required");
      return;
    }
    Get.offAllNamed(Routes.mainScreen);
    return;
    login(email: emailController.text.trim(), password: passwordController.text.trim());
  }


  void cacheUserData() {
    //_authRepository.saveCashedUserInfo(_user!)
  }

  void cacheUserWithData(UserLoginResponseModel userData) {
    //_authRepository.saveCashedUserInfo(userData);
  }

  // Future<Either<Failure, bool>> userLogout() async {
  //   final result = _authRepository.userLogout();
  //   _user = null;
  //   return result;
  // }

  Future checkNotificationActive() async {
    isNotificationActive.value =
        await _authRepository.checkIsNotificationActive();
  }

  Future setNotificationActivity(bool data) async {
    await _authRepository.setNotificationActive(data);
    isNotificationActive.value = data;
  }

  Future checkCurrencyText() async {
    currencyText.value = await MySharedPreference.getCurrencyText();
    Constants.currencySymbol = currencyText.value;
  }

  Future setCurrencyText(String text) async {
    await MySharedPreference.setCurrencyText(text);
    currencyText.value = text;
    Constants.currencySymbol = currencyText.value;
  }

  setUser(UserLoginResponseModel userInfo) {
    _user = userInfo;
  }

  void setUserInfo(UserLoginResponseModel userInfo) {
    _user = userInfo;
    Get.find<LocalDataSource>().cacheUserResponse(userInfo);
  }


  void login({required String email, required String password}) async {
    String deviceId = await Utils.getDeviceId();

    final body = <String, String>{};
    body.addAll({"email": email});
    body.addAll({"password": password});
    body.addAll({"deviceId": deviceId});
    isLoading.value = true;
    final result = await _authRepository.login(body);

    result.fold((error) {
      if (error.statusCode == 503) {
        login(email: email, password: password);
      } else {
        isLoading.value = false;
        Utils.showSnackBar(message: error.message, title: "Error");
      }
    }, (data) async {
      _user = data;
      setUserName(data.user.firstName, data.user.picture);
      Get.offAndToNamed(Routes.mainScreen);
    });
  }

  Future onGoogleTap() async {
    isLoading.value = true;
    Utils.loadingDialog(Get.context!);
    try {
      final result = await _authRepository.googleLogin();
      result.fold((l) {
        Utils.closeDialog(Get.context!);
        Utils.showSnackBar(message: l.message);
        isLoading.value = false;
      }, (r) {
        isLoading.value = false;
        Utils.closeDialog(Get.context!);
        String email = r.email;
        String userName = r.displayName ?? "";
        String photoUrl = r.photoUrl ?? "";
        socialLogin(email, userName, photoUrl, 'Google', false, "");
        setUserName(userName, photoUrl);
      });
    } on Exception catch (e) {
      debugPrint("Google login problem ${e.toString()}");
      Utils.closeDialog(Get.context!);
      isLoading.value = false;
    }
  }

  Future onAppleLoginTap() async {
    try {
      if (await SignInWithApple.isAvailable()) {
        isLoading.value = true;
        AuthorizationCredentialAppleID credential =
        await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );

        log(credential.toString());

        if (credential.userIdentifier != null) {
          String token = credential.userIdentifier ?? "";
          String email = credential.email ?? "";
          String name =
              "${credential.familyName != null || credential.familyName != "" ? credential.familyName : ""} ${credential.givenName != null || credential.givenName != "" ? credential.givenName : ""}";
          setUserName(name, "");
          if (email != "") {
            Map<String,String> appleData = await MySharedPreference.getAppleEmailData();
            String emailData = appleData[MySharedPreference.appleEmailKey]??"";
            if(emailData != "") {
              String nameData = appleData[MySharedPreference.appleUserName]??"";
              String tokenData = appleData[MySharedPreference.appleAuthId]??"";
              socialLogin(emailData, nameData, "", 'Apple', true, tokenData);
            } else {
              MySharedPreference.setAppLeData(email, token, name);
              socialLogin(email, name, "", 'Apple', true, token);
            }
          } else {
            MySharedPreference.setAppLeData(email, token, name);
            socialLogin(email, name, "", 'Apple', true, token);
          }
        } else {
          Utils.showSnackBar(message: "Unable to get credential from Apple!");
          isLoading.value = false;
        }
      }
    } on Exception catch (e) {
      debugPrint("Apple login problem ${e.toString()}");
      isLoading.value = false;
    }
  }

  Future socialLogin(String email, String userName, String photoUrl,
      String type, bool isApple, String appleId) async {
    String deviceId = await Utils.getDeviceId();


    final body = <String, String>{};
    body.addAll({"email": email});
    body.addAll({"password": "12345678"});
    body.addAll({"user_name": userName});
    body.addAll({"profile_photo": photoUrl});
    if (isApple) {
      body.addAll({"apple_id": appleId});
    }
    body.addAll({"type": type});
    body.addAll({"deviceId": deviceId});
    Utils.loadingDialog(Get.context!);
    final result = await _authRepository.socialLogin(body);
    isLoading.value = false;
    result.fold((error) {
      Utils.closeDialog(Get.context!);
      if (error.statusCode == 503) {
        socialLogin(email, userName, photoUrl, type, isApple, appleId);
      } else if (error.statusCode == 500) {
        Utils.showSnackBar(message: AppText().serverBusy);
      } else {
        Utils.showSnackBar(message: error.message, title: AppText().error);
      }
    }, (data) async {
      _user = data;
      setUserName(data.user.firstName, data.user.picture);
      isLoading.value = false;
      // Utils.closeDialog(Get.context!);
      Get.offAndToNamed(Routes.mainScreen);
      // Future.delayed(const Duration(seconds: 2)).then((value) {
      //   Utils.closeDialog(Get.context!);
      //   Get.offAndToNamed(Routes.dashboard);
      // });
    });
  }

  void setUserName(String name, String image) {
    userName.value = name;
    userImage.value = image;
  }

  Future<String?> uploadFile(String filePath) async {
    File file;
    try {
    file =  await Utils.compressFile(File(filePath));
    } on Exception catch (e) {
     file = File(filePath);
    }
    return await _authRepository.uploadFile(file.path, "${_user?.user.id}");
  }

  Future<Either<Failure, bool>> userLogout() async {
    final result = _authRepository.userLogout();
    _user = null;
    return result;
  }
}
