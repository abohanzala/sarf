import 'package:flutter/material.dart';

import 'package:sarf/src/Auth/LoginScreen.dart';
import 'package:sarf/src/Auth/change_password.dart';
import 'package:sarf/src/baseview/Invoices/invoice_details.dart';
import 'package:sarf/src/baseview/home/home_view.dart';
import 'package:sarf/src/baseview/members/cites_list_view.dart';
import 'package:sarf/src/baseview/members/members_list_view.dart';
import 'package:sarf/src/baseview/more/alerts_view.dart';
import 'package:sarf/src/baseview/more/delete_account.dart';
import 'package:sarf/src/baseview/more/new_support.dart';
import 'package:sarf/src/baseview/more/single_support.dart';
import 'package:sarf/src/utils/routes_name.dart';
import '../Auth/about.dart';
import '../Auth/change_profile.dart';
import '../Auth/otp.dart';
import '../Auth/otp_Forgot_Password.dart';
import '../Auth/privacy_policy.dart';
import '../Auth/registration_details.dart';
import '../Auth/settings.dart';
import '../Auth/termsAndConditions.dart';
import '../baseview/base_view.dart';
import '../baseview/more/support.dart';

class Routes {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.base:
        return MaterialPageRoute(
            builder: (BuildContext context) => const BaseView());
      case RoutesName.LogIn:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());
      case RoutesName.ChangePassword:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ChangePassword());
      case RoutesName.homeView:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
      case RoutesName.OtpScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const OtpScreen());
      case RoutesName.RegistrationDetails:
        return MaterialPageRoute(
            builder: (BuildContext context) => const RegistrationDetails());
      case RoutesName.cityList:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CityListScreen());
      case RoutesName.membersList:
        return MaterialPageRoute(
            builder: (BuildContext context) => const MembersListScreen());
      // case RoutesName.Splash:
      case RoutesName.Support:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Support());
      case RoutesName.newSupport:
        return MaterialPageRoute(
            builder: (BuildContext context) => const NewSupportScreen());
      case RoutesName.Settings:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Settings());
      case RoutesName.ChangeProfile:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ChangeProfile());
      case RoutesName.About:
        return MaterialPageRoute(
            builder: (BuildContext context) => const About());
      case RoutesName.TermsAndConditions:
        return MaterialPageRoute(
            builder: (BuildContext context) => const TermsAndConditions());
      case RoutesName.PrivacyPolicy:
        return MaterialPageRoute(
            builder: (BuildContext context) => const PrivacyPolicy());

      case RoutesName.alerts:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                const AlertsScreen()); // case RoutesName.Splash:

      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const SplashScreen());
      case RoutesName.deleteAccount:
        return MaterialPageRoute(
            builder: (BuildContext context) => const DeleteAccount());
      case RoutesName.OtpScreenForgotPassword:
        return MaterialPageRoute(
            builder: (BuildContext context) => OtpForgotPasswordScreen());
      // case RoutesName.SignIn:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const Signin());
      // case RoutesName.PhoneVerificaion:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const PhoneVerification());
      // case RoutesName.TestingScreen:
      // return MaterialPageRoute(builder: (BuildContext context)=>  TestingScreen());
      // case RoutesName.Verb:
      //   return MaterialPageRoute(builder: (BuildContext context)=> const VerbsScreen());
      // case RoutesName.Worship:
      //   return MaterialPageRoute(builder: (BuildContext context)=> const WorshipScreen());
      // case RoutesName.Bodily:
      //   return MaterialPageRoute(builder: (BuildContext context)=> const BodilyScreen());
      // case RoutesName.Name:
      //   return MaterialPageRoute(builder: (BuildContext context)=> const NameScreen());
      // case RoutesName.Place:
      //   return MaterialPageRoute(builder: (BuildContext context)=> const PlaceScreen());
      // case RoutesName.Faith:
      //   return MaterialPageRoute(builder: (BuildContext context)=> const FaithScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No Route Defined'),
            ),
          );
        });
    }
  }
}
