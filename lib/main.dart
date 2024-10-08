import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sarf/controllers/invoice/invoice_controller.dart';
import 'package:sarf/controllers/support/support_controller.dart';
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
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAq3hlDIS1Uk2bUaNxAfQqg4JqiKm3m8yo",
            appId: "1:560332227952:web:620ae66c34ede2cf13bbb5",
            messagingSenderId: "560332227952",
            projectId: "sarfapp-202c5"));
  } else {
    await Firebase.initializeApp(
        // options: DefaultFirebaseOptions.currentPlatform,
        );
  }

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
  Get.put<SupportController>(SupportController());

  if (await GetStorage().read('lang') == null) {
    await GetStorage().write('lang', 'ar');
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
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
          // builder: BotToastInit(),
          builder: (context, myWidget) {
            myWidget = BotToastInit()(context, myWidget);
            myWidget = EasyLoading.init()(context, myWidget);
            return myWidget;
          },
          // navigatorObservers: [BotToastNavigatorObserver()],
          debugShowCheckedModeBanner: false,
          title: 'Sarf',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          navigatorObservers: [Helper.routeObserver],
          initialRoute: GetStorage().read('user_token') == null
              ? RoutesName.LogIn
              : RoutesName.base,
          onGenerateRoute: Routes.generateRoute,
          locale: GetStorage().read('lang') == 'ar'
              ? const Locale('ar', 'SA')
              : const Locale('en', 'US'),
          translations: LocaleString(),
          fallbackLocale: const Locale('en', 'US'),
          //         localizationsDelegates: const [
          //               MonthYearPickerLocalizations.delegate,
          // ],
        );
      },
    );
  }
}
