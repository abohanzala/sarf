class ApiLinks {
  // assets base path
  //static const String assetBasePath = "https://soaqna.said.com.sa/public/";

  // api path and links
  static const String base = 'https://sarfapp.sharpvisions.cloud/api';
  static const String registerUser = '$base/register';
  static const String loginUser = '$base/login';
  static const String register = '$base/register';
  static const String verify_otp = '$base/verify_otp';
  static const String reset_password = '$base/reset_password';
  static const String membersList = '$base/member_list?language=';
  static const String cityList = '$base/cities_members?language=';
  static const String getHome = '$base/user';
  static const String addBudget = '$base/budget/add';
  static const String data_collection = '$base/data_collection?language=';
  static const String registration = '$base/user/registration';
  static const String getSupportTypes = '$base/app_support/type?language=';
  static const String forgotPassword = '$base/forget_password';
  static const String addSupport = '$base/app_support/add';
  static const String getSupport = '$base/app_support';
  static const String getSupportDetails = '$base/app_support/detail';
  static const String assetBasePath = 'https://sarfapp.sharpvisions.cloud/public/';
  static const String supportReply = '$base/app_support/reply';
  static const String budgetDelete = '$base/budget/destroy';
  static const String resetBudget = '$base/budget/reset';
}
