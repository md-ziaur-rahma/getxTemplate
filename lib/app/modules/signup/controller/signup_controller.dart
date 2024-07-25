import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../core/app_text.dart';
import '../../../core/shared_preference.dart';
import '../../../core/utils.dart';
import '../../../routes/routes.dart';
import '../../signIn/controller/sign_in_controller.dart';
import '../../signIn/model/user_login_response_model.dart';
import '../../signIn/repo/auth_repository.dart';

class SignupController extends GetxController {
  final AuthRepository _authRepository;

  SignupController(this._authRepository);

  var isLoading = false.obs;
  var isConditionCheck = false.obs;

  Client client = Client();
  final signupKey = GlobalKey<FormState>();
  final signupComKey = GlobalKey<FormState>();

  int typeOfUser = 0;
  List<String> userType = ["Individual", "Company", "Agency"];

  UserLoginResponseModel? _user;
  UserLoginResponseModel? get user => _user;
  bool get isLoggedIn => _user != null && _user!.accessToken.isNotEmpty;


  void changeUserType(type) {
    typeOfUser = type;
    update();
  }

  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var firstNameController = TextEditingController();
  var middleNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var currencyController = "\$".obs;
  String? email;
  String? name;
  String? password;
  String? confirmPassword;

  List<Country> allCountry = countries;
  String countryDialCode = '';
  var countryLetterCode = "".obs;

  void changeCountryCode(String cc, String dc) {
    countryLetterCode.value = cc;
    countryDialCode = dc;
  }


  var selectedImage = "".obs;

  void chooseImage(){
    Utils.pickSingleImage().then((value){
      if(value != null){
        selectedImage(value);
      }
    });
  }


  var togglePassword = false.obs;
  var toggleConfirmPassword = false.obs;

  @override
  void onInit() {
     getRegion();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void validationSignupForm(BuildContext context){
    if(firstNameController.text.isEmpty){
      Utils.showSnackBar(message: "Username is required!");
      return;
    } else if(emailController.text.isEmpty) {
      Utils.showSnackBar(message: "Email is required!");
      return;
    }  else if(!GetUtils.isEmail(emailController.text)) {
      Utils.showSnackBar(message: "The email is incorrect!");
      return;
    } else if(passwordController.text.isEmpty) {
      Utils.showSnackBar(message: "Password is required!");
      return;
    } else if(passwordController.text != confirmPasswordController.text) {
      Utils.showSnackBar(message: "Password doesn't match!");
      return;
    }
    register();
  }


  void getRegion() async {
    final result = await _authRepository.getRegion();
    result.fold((error) {
      countryLetterCode.value = "US";
    }, (data) async {
      countryLetterCode.value = data.countryCode;
      print(" .............. ${countryLetterCode.value} ..............");
    });
  }


  void register() async {
    final body = <String, String>{};

    body.addAll({"firstName": firstNameController.text.trim()});
    body.addAll({"middleName": middleNameController.text.trim()});
    body.addAll({"lastName": lastNameController.text.trim()});
    body.addAll({"email": emailController.text.trim()});
    body.addAll({"mobile_number": phoneController.text.trim()});
    //todo change countryDialCode => countryLetterCode
    body.addAll({"country_code": countryLetterCode.value});
    body.addAll({"dial_code": countryDialCode});
    body.addAll({"password": passwordController.text.trim()});
    body.addAll({"productType": '1'});
    body.addAll({"dob": "2000-10-12"});
    body.addAll({"currency": currencyController.value});
     print(body);
    // return;
    isLoading.value = true;
    final result = await _authRepository.userRegister(body);

    result.fold((error) {
      if (error.statusCode == 503) {
        register();
        return;
      }
      isLoading.value = false;
      Utils.showSnackBar(message: error.message, title: "Error");
    }, (data) async {
      isLoading.value = false;

      login(emailController.text, passwordController.text);

      clearForm();
    });
  }

  void login(String email, String password) async {
    final body = <String, String>{};
    body.addAll({"email": email});
    body.addAll({"password": password});
    body.addAll({"deviceId": password});
    Utils.loadingDialog(Get.context!);
    final result = await _authRepository.login(body);

    result.fold((error) {
      if (error.statusCode == 503) {
        login(email, password);
        return;
      }
      Utils.closeDialog(Get.context!);
      Utils.showSnackBar(message: error.message, title: "Error");
    }, (data) async {
      Get.find<LoginController>().setUser(data);
      Get.find<LoginController>().setUserName(data.user.firstName, data.user.picture);
      Future.delayed(const Duration(seconds: 3)).then((value) {
        Utils.closeDialog(Get.context!);
        Get.offAllNamed(Routes.mainScreen);

      });
    });
  }

  void clearForm() {
    emailController.text = "";
    phoneController.text = "";
    firstNameController.text = "";
    middleNameController.text = "";
    lastNameController.text = "";
    userNameController.text = "";
    passwordController.text = "";
    confirmPasswordController.text = "";
    currencyController.value = "\$";
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


        if (credential.userIdentifier != null) {
          String token = credential.userIdentifier ?? "";
          String email = credential.email ?? "";
          String name =
              "${credential.familyName != null || credential.familyName != "" ? credential.familyName : ""} ${credential.givenName != null || credential.givenName != "" ? credential.givenName : ""}";
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
      // Utils.closeDialog(Get.context!);
      Get.offAndToNamed(Routes.mainScreen);
      // Future.delayed(const Duration(seconds: 2)).then((value) {
      //   Utils.closeDialog(Get.context!);
      //   Get.offAndToNamed(Routes.dashboard);
      // });
    });
  }

  void setUserName(String name, String image) {
    Get.find<LoginController>().setUserName(name, image);

  }



}
