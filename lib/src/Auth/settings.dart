import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../resources/resources.dart';
import '../widgets/custom_textfield.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();
  bool english = true;
  bool arabic = false;
  String? countryName;
  TextEditingController phone = TextEditingController();
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
                buildBackArrowContainerAndSettingsText(),
              ],
            ),
          ),
          buildSettingsOptionsCard()
        ],
      ),
    );
  }

  Widget buildBackGroundImage() {
    return Stack(alignment: Alignment.topLeft, children: [
      Image.asset(
        R.images.backgroundImageChangePassword,
        width: MediaQuery.of(context).size.width,
      ),
      buildBackArrowContainerAndSettingsText(),
    ]);
  }

  Widget buildBackArrowContainerAndSettingsText() {
    return Positioned(
      top: 50,
      left: 30,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFFFFFFFF)),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(R.images.arrowBlue)),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              'Settings',
              style: TextStyle(
                  color: R.colors.white, fontFamily: 'bold', fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSettingsOptionsCard() {
    return Positioned(
      top: 100,
      right: 20,
      left: 20,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            )),
        child: Column(
          children: [
            buildLanguageTextAndLanguageOptions(),
            buildDivider(),
            buildChangeProfileTextAndIcon(),
            buildDivider(),
            buildChangePrivacyPolicyTextAndIcon()
            //buildUpdateButton()
          ],
        ),
      ),
    );
  }

  Widget buildDivider() {
    return Container(
      margin: EdgeInsets.only(
        top: 10.0,
        bottom: 10,
        left: 30,
      ),
      color: R.colors.lightGrey,
      height: 2.0,
    );
  }

  Widget buildUpdateButton() {
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 20, left: 15, right: 15),
      child: customButton(
          margin: 20,
          width: MediaQuery.of(context).size.width,
          titleTextAlign: TextAlign.center,
          onPress: (() {
            //   Get.toNamed('otp_screen');
          }),
          title: 'Update',
          color: R.colors.buttonColor,
          height: 45,
          borderColour: R.colors.transparent,
          textColor: R.colors.white),
    );
  }

  buildChangePrivacyPolicyTextAndIcon() {
    return InkWell(
      onTap: () {
        openChangePasswordDialog();
      },
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
        child: Row(
          children: [buildChangePasswordIcon(), buildChangePasswordText()],
        ),
      ),
    );
  }

  buildChangeProfileTextAndIcon() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
      child: Row(
        children: [
          buildProfileIcon(),
          buildProfileText(),
        ],
      ),
    );
  }

  buildLanguageTextAndLanguageOptions() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
      child: Row(
        children: [
          buildLanguageIcon(),
          buildLanguageText(),
          buildLanguageCard()
        ],
      ),
    );
  }

  Widget buildChangePasswordIcon() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Image.asset(
        R.images.privacyPolicyIconForSettings,
        height: 15,
        width: 15,
      ),
    );
  }

  Widget buildProfileIcon() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Image.asset(
        R.images.profile,
        height: 15,
        width: 15,
      ),
    );
  }

  Widget buildLanguageIcon() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Image.asset(
        R.images.languageIcon,
        height: 15,
        width: 15,
      ),
    );
  }

  buildChangePasswordText() {
    return Expanded(
      child: Text(
        'Change Password',
        style: TextStyle(
            color: R.colors.black, fontFamily: 'medium', fontSize: 14),
      ),
    );
  }

  buildProfileText() {
    return Expanded(
      child: Text(
        'Profile',
        style: TextStyle(
            color: R.colors.black, fontFamily: 'medium', fontSize: 14),
      ),
    );
  }

  buildLanguageText() {
    return Expanded(
      child: Text(
        'Language',
        style: TextStyle(
            color: R.colors.black, fontFamily: 'medium', fontSize: 14),
      ),
    );
  }

  buildLanguageCard() {
    return Container(
      height: 25,
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

  void openChangePasswordDialog() {
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
                        buildChangePasswordext(),
                        buildNewPasswordField(),
                        buildConfirmNewPasswordField(),
                        buildUpdateButton()
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

  Widget buildChangePasswordext() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Text(
        'Change Password',
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
          Padding(
            padding: EdgeInsets.all(10),
            child: Image.asset(
              R.images.cross,
              height: 30,
            ),
          )
        ],
      ),
    );
  }

  Widget buildNewPasswordField() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 20),
      child: customTextField(
          hintTextSize: 12,
          color: Colors.grey[300]!,
          height: 45,
          borderColour: R.colors.transparent,
          controller: newPassword,
          hintText: 'Enter New Password',
          hintStyle: TextStyle(color: R.colors.black)),
    );
  }

  Widget buildConfirmNewPasswordField() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 20),
      child: customTextField(
          hintTextSize: 12,
          color: Colors.grey[300]!,
          height: 45,
          borderColour: R.colors.transparent,
          controller: confirmNewPassword,
          hintText: 'Confirm New Password',
          hintStyle: TextStyle(color: R.colors.black)),
    );
  }
}
