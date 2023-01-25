import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sarf/resources/resources.dart';
import 'package:sarf/src/Auth/otp.dart';
import '../../controllers/auth/change_password_controller.dart';
import '../../resources/text_style.dart';
import '../utils/routes_name.dart';
import '../widgets/custom_textfield.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  ChangePasswordController changePasswordController =
      Get.find<ChangePasswordController>();
  FocusNode otpFieldNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  String password = '';
  bool isPasswordObscureText = true;
  double bodyHeight = 0.0;

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
                buildBackArrowContainerAndChangePasswordText(),
              ],
            ),
          ),
          buildChangePasswordCard()
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
      buildBackArrowContainerAndChangePasswordText()
    ]);
  }

  Widget buildBackArrowContainerAndChangePasswordText() {
    return Positioned(
      top: 50,
      left: GetStorage().read('lang') == "en" ? 30 : null,
      right: GetStorage().read('lang') != "en" ? 30 : null,
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
              'Change Password'.tr,
              style: TextStyle(
                  color: R.colors.white, fontFamily: 'bold', fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  Widget buildChangePasswordCard() {
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
            buildOtpText(),
            buildOtpField(),
            buildDivider(),
            buildNewPasswordField(),
            buildConfirmNewPasswordField(),
            buildUpdateButton()
            //buildUpdateButton()
          ],
        ),
      ),
    );
  }

  // Widget buildUpdateButton() {
  //   return Container(
  //     margin: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
  //     height: 50,
  //     decoration: BoxDecoration(
  //       color: Color(0xFFFB7B57),
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     child: InkWell(
  //       onTap: () {
  //         Get.toNamed(RoutesName.OtpScreen);
  //       },
  //       child: Center(
  //         child: Text(
  //           'Update',
  //           style: TextStyle(
  //               color: Colors.white, fontSize: 13, fontFamily: 'medium'),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget buildOtpText() {
    return Container(
        margin: EdgeInsets.only(top: 20, bottom: 20),
        child: Text(
          'Enter OTP'.tr,
          style: TextStyle(
              fontSize: 12, fontFamily: 'medium', color: Color(0xFF9A9A9A)),
        ));
  }

  Widget buildDivider() {
    return Container(
      margin: EdgeInsets.only(top: 20.0, right: 15, left: 15),
      color: R.colors.lightGrey,
      height: 2.0,
    );
  }

  Widget buildOtpField() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      child: customTextField(
          hintTextSize: 12,
          color: R.colors.lightGrey,
          height: 45,
          borderColour: R.colors.transparent,
          controller: changePasswordController.otp,
          hintText: 'ex 1234'.tr,
          hintStyle: TextStyle(color: R.colors.black)),
    );
  }

  Widget buildNewPasswordField() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 20),
      child: Column(
        children: [
          Container(
              child: Row(
            children: [
              Text(
                'New Password'.tr,
                style: TextStyle(
                    fontFamily: 'medium', color: R.colors.grey, fontSize: 12),
              ),
            ],
          )),
          Container(
            margin: EdgeInsets.only(
              top: 10,
            ),
            child: customTextField(
                hintTextSize: 12,
                hintText: 'Password'.tr,
                controller: changePasswordController.newPassword,
                color: R.colors.lightGrey,
                height: 45,
                borderColour: R.colors.transparent),
          )
        ],
      ),
    );
  }

  Widget buildConfirmNewPasswordField() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 20),
      child: Column(
        children: [
          Container(
              child: Row(
            children: [
              Text(
                'Confirm New Password'.tr,
                style: TextStyle(
                    fontFamily: 'medium', color: R.colors.grey, fontSize: 12),
              ),
            ],
          )),
          Container(
            margin: EdgeInsets.only(
              top: 10,
            ),
            child: customTextField(
                hintTextSize: 12,
                hintText: 'Password'.tr,
                controller: changePasswordController.confirmNewPassword,
                color: R.colors.lightGrey,
                height: 45,
                borderColour: R.colors.transparent),
          )
        ],
      ),
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
            if (changePasswordController.otp.text.isEmpty) {
              Get.snackbar(
                'Alert'.tr,
                'Required Field'.tr,
                snackPosition: SnackPosition.TOP,
                backgroundColor: R.colors.themeColor,
              );
              return;
            } else if (changePasswordController.newPassword.text.isEmpty) {
              Get.snackbar(
                'Alert'.tr,
                'Required Field'.tr,
                snackPosition: SnackPosition.TOP,
                backgroundColor: R.colors.themeColor,
              );
              return;
            } else if (changePasswordController
                .confirmNewPassword.text.isEmpty) {
              Get.snackbar(
                'Alert'.tr,
                'Required Field'.tr,
                snackPosition: SnackPosition.TOP,
                backgroundColor: R.colors.themeColor,
              );
              return;
            }
            changePasswordController.changePassword();
          }),
          title: 'Update'.tr,
          color: R.colors.buttonColor,
          height: 45,
          borderColour: R.colors.transparent,
          textColor: R.colors.white),
    );
  }
}
