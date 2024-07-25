import 'package:getx/app/data/api_url.dart';
import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../data/error/exception.dart';
import '../../../data/error/failure.dart';
import '../../../data/local_database.dart';
import '../../../data/remote_database.dart';
import '../../signup/model/region_model.dart';
import '../model/user_login_response_model.dart';

abstract class AuthRepository {
  Either<Failure, UserLoginResponseModel> getCashedUserInfo();
  Future<Either<Failure, GoogleSignInAccount>> googleLogin();
  Future<Either<Failure, UserLoginResponseModel>> socialLogin(
      Map<String, dynamic> body);

  Future<String?> uploadFile(String filePath, String userId);

  //for local notification
  Future<bool> checkIsNotificationActive();
  Future<void> setNotificationActive(bool data);

  Either<Failure, bool> cachedLanguage(String language);
  Future<String> getCachedLanguage();

  Either<Failure, bool> userLogout();

  Future<Either<Failure, RegionModel>> getRegion();
  Either<Failure, bool> saveRegionData(RegionModel regionModel);

  Future<Either<Failure, String>> userRegister(Map<String, dynamic> body);
  Future<Either<Failure, UserLoginResponseModel>> login(
      Map<String, dynamic> body);
}

class AuthRepositoryImpl extends AuthRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Either<Failure, UserLoginResponseModel> getCashedUserInfo() {
    try {
      final result = localDataSource.getUserResponseModel();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserLoginResponseModel>> socialLogin(
      Map<String, dynamic> body) async {
    try {
      final responseResult = await remoteDataSource.postRequest(
          url: RemoteUrls.socialLogin, body: body, isHeaderAvailable: false);
      var result = UserLoginResponseModel.fromJson(responseResult);
      localDataSource.cacheUserResponse(result);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, GoogleSignInAccount>> googleLogin() async {
    try {
      final GoogleSignIn googleSignIn =
          GoogleSignIn(signInOption: SignInOption.standard, scopes: [
        'email',
      ]);
      var result = await googleSignIn.signIn();
      if (result != null && result.displayName != null) {
        return Right(result);
      } else {
        return const Left(ServerFailure("Failed to login with google", 201));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<String?> uploadFile(String filePath, String userId) async {
    var result = await remoteDataSource.uploadFile(filePath, userId);
    if (result != "error") {
      return result;
    }
    return null;
  }

  @override
  Future<bool> checkIsNotificationActive() async {
    bool result = await localDataSource.checkIsNotificationActive();
    return result;
  }

  @override
  Future setNotificationActive(bool data) async {
    await localDataSource.setNotificationActive(data);
  }

  @override
  Either<Failure, bool> cachedLanguage(String language) {
    try {
      localDataSource.saveLanguage(language);
      return const Right(true);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<String> getCachedLanguage() {
    try {
      final result = localDataSource.getLanguage();
      return result;
    } catch (e) {
      return Future.value('English');
    }
  }

  @override
  Either<Failure, bool> userLogout() {
    try {
      localDataSource.userLogout();
      return const Right(true);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, RegionModel>> getRegion() async {
    try {
      final isCached = localDataSource.isCachedRegionData();
      if (isCached) {
        final result = localDataSource.getRegionData();
        return Right(result);
      }
      final result = await remoteDataSource.getRegion();
      localDataSource.saveRegionData(result);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  //Region
  @override
  Either<Failure, bool> saveRegionData(RegionModel regionModel) {
    try {
      localDataSource.saveRegionData(regionModel);
      return const Right(true);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> userRegister(
      Map<String, dynamic> body) async {
    try {
      //final result = await remoteDataSource.userRegister(body);
      print('dsfaf');
      final responseResult = await remoteDataSource.postRequest(
          body: body, url: RemoteUrls.userRegister, isHeaderAvailable: false);
      //Get.snackbar('Message', responseResult["message"]);
      print('dsfafdd');
      var result = responseResult["message"];
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, UserLoginResponseModel>> login(
      Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.signIn(body);
      localDataSource.cacheUserResponse(result);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
