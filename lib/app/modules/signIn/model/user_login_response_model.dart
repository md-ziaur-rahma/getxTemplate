import 'dart:convert';

import 'user_profile_model.dart';

class UserLoginResponseModel {
  final int status;
  final bool success;
  final String message;
  final String accessToken;
  final UserProfileModel user;

  UserLoginResponseModel({
    required this.status,
    required this.success,
    required this.message,
    required this.accessToken,
    required this.user,
  });

  UserLoginResponseModel copyWith({
    int? status,
    bool? success,
    String? message,
    String? accessToken,
    UserProfileModel? user,
  }) =>
      UserLoginResponseModel(
        status: status ?? this.status,
        success: success ?? this.success,
        message: message ?? this.message,
        accessToken: accessToken ?? this.accessToken,
        user: user ?? this.user,
      );

  factory UserLoginResponseModel.fromRawJson(String str) =>
      UserLoginResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserLoginResponseModel.fromJson(Map<String, dynamic> json) => UserLoginResponseModel(
        status: json["status"] ?? 0,
        success: json["success"] ?? false,
        message: json["message"] ?? '',
        accessToken: json["authorisation"] == null
            ? json["token"] ?? ""
            : json["authorisation"]["token"] ?? "",
        user: UserProfileModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "message": message,
        "token": accessToken,
        "user": user.toJson(),
      };
}
