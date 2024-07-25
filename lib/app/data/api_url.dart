class BaseUrl {
  static const String _rootUrl = "https://.com/";
  final String _baseUrl = "${_rootUrl}api/";
  String get baseUrl => _baseUrl;
}

class RemoteUrls {
  static String userLogin = '${BaseUrl().baseUrl}user-login';
  static String userRegister = '${BaseUrl().baseUrl}user-registration';
  static String uploadImage = '${BaseUrl().baseUrl}file-upload';
  static String getCategory = '${BaseUrl().baseUrl}categories';
  static String getSubCategory = '${BaseUrl().baseUrl}sub-categories';
  static String getNotification = "${BaseUrl().baseUrl}get-notification";
  static String notificationAction =
      "${BaseUrl().baseUrl}request-accept-reject";
  static String notificationStatusChange =
      "${BaseUrl().baseUrl}update-notification-status";

  //authentication
  static String socialLogin = '${BaseUrl().baseUrl}login-with-type';

  ///............ Setting Pages ................
  static String getProfile = '${BaseUrl().baseUrl}user-profile';
  static String postUpdateProfile = '${BaseUrl().baseUrl}user-profile-update';
  static String forgotPassword = '${BaseUrl().baseUrl}password-reset';
  static String resetPassword = '${BaseUrl().baseUrl}update_user_password.php';
  static String changePin = '${BaseUrl().baseUrl}update-pin';
  static String sendOtp = '${BaseUrl().baseUrl}send-otp';
  static String sendEmail = '${BaseUrl().baseUrl}send-email';
  static String verifyOtp = '${BaseUrl().baseUrl}verify-otp';
  static String changePassword = '${BaseUrl().baseUrl}update-password';
  static String faqsUrl = '${BaseUrl().baseUrl}faq';
  static String systemFeatures = '${BaseUrl().baseUrl}system-features';
  static String helpUsImprove = '${BaseUrl().baseUrl}save-something-went-wrong';
  static String appContent = '${BaseUrl().baseUrl}app-content?';
  static String getReferCode = '${BaseUrl().baseUrl}get-reffer-code';
  static String deleteAccountUrl = '${BaseUrl().baseUrl}delete-user';
}
