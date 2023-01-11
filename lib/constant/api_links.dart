class ApiLinks {
  // assets base path
  //static const String assetBasePath = "https://soaqna.said.com.sa/public/";

  // api path and links
  static const String base = 'https://sarfapp.sharpvisions.cloud/api';
  static const String registerUser = '$base/register';
  static const String loginUser = '$base/login';
  static const String register = '$base/register';
  static const String verify_otp = '$base/verify_otp';
  static const String membersList = '$base/member_list?language=';
  static const String cityList = '$base/cities_members?language=';
  static const String getHome = '$base/user';
  static const String addBudget = '$base/budget/add';
  static const String data_collection = '$base/data_collection?language=';
  static const String getSupportTypes = '$base/app_support/type?language=';
}
