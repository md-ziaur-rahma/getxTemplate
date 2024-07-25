import 'dart:convert';

class UserProfileModel {
  final int id;
  final String firstName;
  final String middleName;
  final String lastName;
  final String dob;
  final String password;
  final String email;
  final String emailVerifiedAt;
  final String number;
  final String dialCode;
  final String countryCode;
  final int status;
  final int activeStatus;
  final String picture;
  final dynamic coverPic;
  final dynamic pronunciation;
  final String referCode;
  final String bio;
  final String aboutMe;
  final String usedReferCode;
  final String referBalance;
  final String totalUsedMyCode;
  final int productType;
  final String uuid;
  final int pin;
  final String gender;
  final String currency;
  final String fcmToken;
  final String createdAt;
  final String updatedAt;
  List<ManageDevice> manageDevices;
  String get fullName =>
      firstName +
      ((firstName.isNotEmpty && middleName.isNotEmpty) ? " " : "") +
      (middleName) +
      (((firstName.isNotEmpty || middleName.isNotEmpty) && lastName.isNotEmpty)
          ? " "
          : "") +
      (lastName);

  UserProfileModel({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.dob,
    required this.password,
    required this.email,
    required this.emailVerifiedAt,
    required this.number,
    required this.dialCode,
    required this.countryCode,
    required this.status,
    required this.activeStatus,
    required this.picture,
    required this.coverPic,
    required this.pronunciation,
    required this.referCode,
    required this.bio,
    required this.aboutMe,
    required this.usedReferCode,
    required this.referBalance,
    required this.totalUsedMyCode,
    required this.productType,
    required this.uuid,
    required this.pin,
    required this.gender,
    required this.currency,
    required this.fcmToken,
    required this.createdAt,
    required this.updatedAt,
    required this.manageDevices,
  });

  UserProfileModel copyWith({
    int? id,
    String? firstName,
    String? middleName,
    String? lastName,
    String? dob,
    String? password,
    String? email,
    String? emailVerifiedAt,
    String? number,
    String? dialCode,
    String? countryCode,
    int? status,
    int? activeStatus,
    String? picture,
    dynamic coverPic,
    dynamic pronunciation,
    String? referCode,
    String? bio,
    String? aboutMe,
    String? usedReferCode,
    String? referBalance,
    String? totalUsedMyCode,
    int? productType,
    String? uuid,
    int? pin,
    String? gender,
    String? currency,
    String? fcmToken,
    String? createdAt,
    String? updatedAt,
    List<ManageDevice>? manageDevices,
  }) =>
      UserProfileModel(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        middleName: middleName ?? this.middleName,
        lastName: lastName ?? this.lastName,
        dob: dob ?? this.dob,
        password: password ?? this.password,
        email: email ?? this.email,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        number: number ?? this.number,
        dialCode: dialCode ?? this.dialCode,
        countryCode: countryCode ?? this.countryCode,
        status: status ?? this.status,
        activeStatus: activeStatus ?? this.activeStatus,
        picture: picture ?? this.picture,
        coverPic: coverPic ?? this.coverPic,
        pronunciation: pronunciation ?? this.pronunciation,
        referCode: referCode ?? this.referCode,
        bio: bio ?? this.bio,
        aboutMe: aboutMe ?? this.aboutMe,
        usedReferCode: usedReferCode ?? this.usedReferCode,
        referBalance: referBalance ?? this.referBalance,
        totalUsedMyCode: totalUsedMyCode ?? this.totalUsedMyCode,
        productType: productType ?? this.productType,
        uuid: uuid ?? this.uuid,
        pin: pin ?? this.pin,
        gender: gender ?? this.gender,
        currency: currency ?? this.currency,
        fcmToken: fcmToken ?? this.fcmToken,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        manageDevices: manageDevices ?? this.manageDevices,
      );

  factory UserProfileModel.fromRawJson(String str) =>
      UserProfileModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        id: json["id"] ?? 0,
        firstName: json["first_name"] ?? '',
        middleName: json["middle_name"] ?? '',
        lastName: json["last_name"] ?? '',
        dob: json["dob"] ?? '',
        password: json["password"] ?? '',
        email: json["email"] ?? '',
        emailVerifiedAt: json["email_verified_at"] ?? '',
        number: json["mobile_number"] ?? '',
        dialCode: json["dial_code"] ?? '',
        countryCode: json["country_code"] ?? '',
        status: json["status"] ?? 0,
        activeStatus: json["active_status"] ?? 0,
        picture: json["picture"] ?? "",
        coverPic: json["coverpic"] ?? "",
        pronunciation: json["pronunciation"] ?? '',
        referCode: json['my_reffer_code'] ?? "",
        bio: json['bio'] ?? "",
        aboutMe: json['about'] ?? "",
        usedReferCode: json['used_reffer_code'] ?? "",
        referBalance: json['referrel_balance'] == null
            ? "0.0"
            : json['referrel_balance'].toString(),
        totalUsedMyCode: json['total_used_reffer_code'] == null
            ? "0"
            : json['total_used_reffer_code'].toString(),
        productType: json["product_type"] ?? 0,
        uuid: json["uuid"] ?? '',
        pin: json["pin"] ?? 0,
        gender: json["gender"] ?? "",
        currency: json["currency"] ?? "\$",
        fcmToken: json["fcm_token"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        manageDevices: json["manage_devices"] == null ||
                json["manage_devices"] == []
            ? []
            : List<ManageDevice>.from(
                json["manage_devices"].map((x) => ManageDevice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "dob": dob,
        "password": password,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "mobile_number": number,
        "dial_code": dialCode,
        "country_code": countryCode,
        "status": status,
        "active_status": activeStatus,
        "picture": picture,
        "coverpic": coverPic,
        "pronunciation": pronunciation,
        "my_reffer_code": referCode,
        "bio": bio,
        "about": aboutMe,
        "used_reffer_code": usedReferCode,
        "referrel_balance": referBalance,
        "total_used_reffer_code": totalUsedMyCode,
        "product_type": productType,
        "uuid": uuid,
        "pin": pin,
        "gender": gender,
        "currency": currency,
        "fcm_token": fcmToken,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "manage_devices":
            List<dynamic>.from(manageDevices.map((x) => x.toJson())),
      };
}

class ManageDevice {
  int id;
  int userId;
  int deviceId;
  String createdAt;
  String updatedAt;
  String fcmToken;

  ManageDevice({
    required this.id,
    required this.userId,
    required this.deviceId,
    required this.createdAt,
    required this.updatedAt,
    required this.fcmToken,
  });

  ManageDevice copyWith({
    int? id,
    int? userId,
    int? deviceId,
    String? createdAt,
    String? updatedAt,
    String? fcmToken,
  }) =>
      ManageDevice(
          id: id ?? this.id,
          userId: userId ?? this.userId,
          deviceId: deviceId ?? this.deviceId,
          createdAt: createdAt ?? this.createdAt,
          updatedAt: updatedAt ?? this.updatedAt,
          fcmToken: fcmToken ?? this.fcmToken);

  factory ManageDevice.fromJson(Map<String, dynamic> json) => ManageDevice(
        id: json["id"] ?? 0,
        userId: json["user_id"] ?? 0,
        deviceId: json["device_id"] ?? 0,
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        fcmToken: json["fcm_token"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "device_id": deviceId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "fcm_token": fcmToken,
      };
}
