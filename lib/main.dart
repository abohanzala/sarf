import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sarf/controllers/invoice/invoice_controller.dart';
import 'package:sarf/firebase_options.dart';
import 'package:sarf/src/utils/navigation_observer.dart';
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
import 'controllers/common/change_profile_controller.dart';
import 'controllers/common/delete_account_controller.dart';
import 'controllers/common/privacy_policy_controller.dart';
import 'controllers/common/profile_controller.dart';
import 'controllers/common/terms_and_conditions_controller.dart';
import 'locale/locale_strings.dart';
import 'src/utils/routes.dart';
import 'src/utils/routes_name.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put<LoginController>(LoginController());
  Get.put<RegisterController>(RegisterController());
  Get.put<OtpController>(OtpController());
  Get.put<DataCollectionController>(DataCollectionController());
  Get.put<RegistrationController>(RegistrationController());
  Get.put<ForgotPasswordController>(ForgotPasswordController());
  Get.put<OtpForgotPasswordController>(OtpForgotPasswordController());
  Get.put<ChangePasswordController>(ChangePasswordController());
  Get.put<InvoiceController>(InvoiceController());
  Get.put<ResetPasswordController>(ResetPasswordController());
  Get.put<TermsAndConditionsController>(TermsAndConditionsController());
  Get.put<PrivacyController>(PrivacyController());
  Get.put<AboutController>(AboutController());
  Get.put<ProfileController>(ProfileController());
  Get.put<DeleteAccountController>(DeleteAccountController());
  Get.put<ChangeProfileController>(ChangeProfileController());
  GetStorage().write('lang', 'ar');
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
          // navigatorObservers: [BotToastNavigatorObserver()],
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          navigatorObservers: [Helper.routeObserver],
          initialRoute: GetStorage().read('user_token') == null
              ? RoutesName.LogIn
              : RoutesName.base,
          onGenerateRoute: Routes.generateRoute,
          locale: const Locale('ar', 'SA'),
          translations: LocaleString(),
          fallbackLocale: const Locale('en', 'US'),
        );
      },
    );
  }
}
