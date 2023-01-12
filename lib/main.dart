import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sarf/src/Auth/otp_Forgot_Password.dart';
import 'controllers/auth/change_password_controller.dart';
import 'controllers/auth/data_collection_controller.dart';
import 'controllers/auth/forgot_password_controller.dart';
import 'controllers/auth/login_controller.dart';
import 'controllers/auth/otp_controller.dart';
import 'controllers/auth/otp_forgot_password_controller.dart';
import 'controllers/auth/register_controller.dart';
import 'controllers/auth/registration_controller.dart';
import 'controllers/auth/reset_password_controller.dart';
import 'controllers/common/about_controller.dart';
import 'controllers/common/privacy_policy_controller.dart';
import 'controllers/common/terms_and_conditions_controller.dart';
import 'locale/locale_strings.dart';
import 'src/utils/routes.dart';
import 'src/utils/routes_name.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put<LoginController>(LoginController());
  Get.put<RegisterController>(RegisterController());
  Get.put<OtpController>(OtpController());
  Get.put<DataCollectionController>(DataCollectionController());
  Get.put<RegistrationController>(RegistrationController());
  Get.put<ForgotPasswordController>(ForgotPasswordController());
  Get.put<OtpForgotPasswordController>(OtpForgotPasswordController());
  Get.put<ChangePasswordController>(ChangePasswordController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          builder: BotToastInit(),
          navigatorObservers: [BotToastNavigatorObserver()],
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: GetStorage().read('user_token') == null ?  RoutesName.LogIn : RoutesName.base,
          onGenerateRoute: Routes.generateRoute,
          locale: const Locale('en', 'US'),
          translations: LocaleString(),
          fallbackLocale: const Locale('en', 'US'),
        );
      },
    );
  }
}
