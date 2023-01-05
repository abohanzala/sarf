import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sarf/resources/images.dart';
import 'package:sarf/src/Auth/registration.dart';
import 'package:sarf/src/utils/routes_name.dart';

import '../../resources/resources.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool english = true;
  bool arabic = false;
  String? countryName;
  TextEditingController phone = TextEditingController();
  FocusNode searchFieldNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
            backgroundColor: const Color(0xFFF2F2F9),
            body: Stack(
              children: [
                buildBackGroundImage(),
                buildBackArrowContainer(),
              ],
            ),
          ),
          buildLoginCard(),
        ],
      ),
    );
  }

  buildBackGroundImage() {
    return Image.asset(
      'assets/images/backgroundImage.png',
      width: MediaQuery.of(context).size.width,
    );
  }

  buildBackArrowContainer() {
    return Positioned(
      top: 50,
      left: 30,
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Color(0xFFFFFFFF)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/arrow.png'),
          ),
        ),
      ),
    );
  }

  buildLoginCard() {
    return Positioned(
      top: 250,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          children: [
            buildLoginTextAndLanguageOptions(),
            buildPhonefield(),
            buildPasswordField(),
            buildForgotPassword(),
            buildNextButton(),
            buildDontHaveAnAccount()
          ],
        ),
      ),
    );
  }

  buildLoginTextAndLanguageOptions() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
      child: Row(
        children: [buildLoginText(), buildLanguageCard()],
      ),
    );
  }

  buildLoginText() {
    return Expanded(
      child: Text(
        'Login',
        style: TextStyle(
            color: Color(0xFF9A9A9A), fontFamily: 'bold', fontSize: 18),
      ),
    );
  }

  buildLanguageCard() {
    return Container(
      height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)),
      child: Row(
        children: [buildEnglishOption(), buildArabicOption()],
      ),
    );
  }

  buildEnglishOption() {
    return Material(
        child: InkWell(
      onTap: () {
        english = true;
        arabic = false;
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: english ? Color(0xFFFB7B57) : Colors.transparent,
        ),
        margin: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
        width: 50,
        height: 30,
        child: Center(
          child: Text(
            'Eng',
            style: TextStyle(
                fontSize: 10,
                fontFamily: 'semibold',
                color: english ? Colors.white : Colors.black),
          ),
        ),
      ),
    ));
  }

  buildArabicOption() {
    return Material(
      child: InkWell(
        onTap: () {
          english = false;
          arabic = true;
          setState(() {});
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: arabic ? Color(0xFFFB7B57) : Colors.transparent,
          ),
          margin: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
          width: 50,
          height: 30,
          child: Center(
            child: Text(
              "العربية",
              style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'semibold,',
                  color: arabic ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  buildPhonefield() {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: IntlPhoneField(
            showDropdownIcon: false,
            flagsButtonPadding: EdgeInsets.only(left: 10),
            onChanged: (number) => phone.text = number.completeNumber,
            initialCountryCode: 'SA',
            onCountryChanged: (country) =>
                setState(() => countryName = country.code),
            decoration: InputDecoration(
              border: InputBorder.none,
              label: Container(
                margin: EdgeInsets.symmetric(horizontal: 0),
                child: Text(' Enter Mobile Number',
                    style: TextStyle(
                        color: Color(0xFF707070),
                        fontFamily: 'regular',
                        fontSize: 12)),
              ),
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(5.0),
              // ),
              filled: true,
              //  fillColor: const Color(0xffF0F0F0)
            ),
          ),
        ))
      ],
    );
  }

  buildPasswordField() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Color(0xFFEAEEF2)),
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.only(left: 20, right: 10, top: 3),
              child: Image.asset('assets/images/passwordIcon.png',
                  height: 15, color: Color(0xFF9A9A9A).withOpacity(0.8))),
          Expanded(
            child: TextField(
              focusNode: searchFieldNode,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: 'Enter Password',
                  hintStyle: TextStyle(
                      fontSize: 10,
                      fontFamily: 'medium',
                      color: Color(0xFF9A9A9A).withOpacity(0.8)),
                  border: InputBorder.none),
            ),
          )
        ],
      ),
    );
  }

  buildForgotPassword() {
    return InkWell(
      onTap: () {
        openForgotPasswordDialog();
      },
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Forgot Password?',
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'semibold',
                  color: Color(0xFFFB7B57)),
            )
          ],
        ),
      ),
    );
  }

  buildNextButton() {
    return
      Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 20),
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xFFFB7B57),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed(RoutesName.Base);
        },
        child: Center(
          child: Text(
            'Next',
            style: TextStyle(
                color: Colors.white, fontSize: 13, fontFamily: 'medium'),
          ),
        ),
      ),
    );
  }

  buildDontHaveAnAccount() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              'Dont Have An Account',
              style: TextStyle(
                  color: Colors.black, fontSize: 13, fontFamily: 'medium'),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext) => Registration()));
            },
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                'Register',
                style: TextStyle(
                    color: Color(0xFFFB7B57),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    fontFamily: 'medium'),
              ),
            ),
          )
        ],
      ),
    );
  }

  void openForgotPasswordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Material(
          type: MaterialType.transparency,
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.pop(context);
            },
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height - 100,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0)),
                    ),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 15,
                        ),
                        buildCrossIcon(),
                        buildForgotPasswordText(),
                        buildPhonefield(),
                        buildGetCodeButton()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildForgotPasswordText() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Text(
        'Forgot Password',
        style:
            TextStyle(fontSize: 16, fontFamily: 'bold', color: R.colors.black),
      ),
    );
  }

  Widget buildCrossIcon() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Stack(
        children: [
          Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: R.colors.buttonColor),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Image.asset(R.images.cross),
              ))
        ],
      ),
    );
  }

  buildGetCodeButton() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 20),
      height: 50,
      decoration: BoxDecoration(
        color: R.colors.buttonColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed('change_password');
        },
        child: Center(
          child: Text(
            'Get Code',
            style: TextStyle(
                color: Colors.white, fontSize: 13, fontFamily: 'medium'),
          ),
        ),
      ),
    );
  }
}
