import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../controllers/auth/register_controller.dart';
import '../../resources/resources.dart';
import '../utils/routes_name.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool english = true;
  bool arabic = false;
  String? countryName;
  TextEditingController phone = TextEditingController();
  FocusNode searchFieldNode = FocusNode();
  bool checkBox = false;
  RegisterController registerController = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
            backgroundColor: Color(0xFFF2F2F9),
            body: Stack(
              children: [
                buildBackGroundImage(),
                buildBackArrowContainer(),
              ],
            ),
          ),
          buildRegistrationCard(),
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
        onTap: () {
          Navigator.pop(context);
        },
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

  buildRegistrationCard() {
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
            buildRegisterText(),
            buildPhonefield(),
            buildNextButton(),
          ],
        ),
      ),
    );
  }

  buildRegisterText() {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Registration'.tr,
            style: TextStyle(
                fontFamily: 'bold', fontSize: 18, color: Color(0xFF9A9A9A)),
          )
        ],
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
            onChanged: (number) {
              phone.text = number.completeNumber;
              registerController.phone.text = phone.text;
              print(
                  'This is my phoneNumber===============${registerController.phone}');
            },
            initialCountryCode: 'SA',
            invalidNumberMessage: "Invalid mobile number".tr,
            onCountryChanged: (country) =>
                setState(() => countryName = country.code),
            decoration: InputDecoration(
              // focusedBorder: const OutlineInputBorder(
              //   borderSide:
              //       const BorderSide(color: Color(0xFF9A9A9A), width: 0.0),
              // ),
              label: Container(
                margin: EdgeInsets.symmetric(horizontal: 0),
                child: Text('Enter Mobile Number'.tr,
                    style: TextStyle(
                        color: Color(0xFF707070),
                        fontFamily: 'regular',
                        fontSize: 12)),
              ),
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
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
                  hintText: 'Enter Password'.tr,
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
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Forgot Password?',
            style: TextStyle(
                fontSize: 14, fontFamily: 'semibold', color: Color(0xFFFB7B57)),
          )
        ],
      ),
    );
  }

  buildNextButton() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 40),
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xFFFB7B57),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          print(
              'This is my phoneNumber===============${registerController.phone.text}');
          print(
              'This is my phoneNumber===============${registerController.phone.text}');
          if (registerController.phone.text.isEmpty ||
              registerController.phone.text == "+966") {
            Get.snackbar(
              'Alert',
              'Enter Mobile Number',
              snackPosition: SnackPosition.TOP,
              backgroundColor: R.colors.themeColor,
            );
          } else {
            registerController.register();
          }
        },
        child: Center(
          child: Text(
            'Next'.tr,
            style: TextStyle(
                color: Colors.white, fontSize: 13, fontFamily: 'medium'),
          ),
        ),
      ),
    );
  }

  buildDontHaveAnAccount() {
    return Container(
      margin: EdgeInsets.only(top: 50, left: 20),
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
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(
              'Register',
              style: TextStyle(
                  color: Color(0xFFFB7B57),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  fontFamily: 'medium'),
            ),
          )
        ],
      ),
    );
  }

  buildAgreeToTermsAndConditionsBox() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Row(
        children: <Widget>[
          Checkbox(
            checkColor: Colors.white,
            activeColor: Color(0xFF2C313E),
            value: this.checkBox,
            onChanged: (bool? value) {
              setState(() {
                this.checkBox = value!;
              });
            },
          ),
          Text(
            'I Accept'.tr,
            style: TextStyle(fontSize: 17, color: Colors.grey),
          ),
          InkWell(
            onTap: () {},
            child: Text(
              ' Terms & Conditions'.tr,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 17,
              ),
            ),
          ),
        ], //<Widget>[]
      ),
    );
  }
}
