import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sarf/src/widgets/custom_textfield.dart';
import 'package:sms_autofill/sms_autofill.dart';
// import 'package:telephony/telephony.dart';
import '../../controllers/auth/otp_controller.dart';
import '../../controllers/auth/otp_forgot_password_controller.dart';
import '../../controllers/auth/register_controller.dart';
import '../../resources/resources.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with CodeAutoFill {
  TextEditingController otpControllerText = TextEditingController();
  RegisterController registerController = Get.find<RegisterController>();
  OtpController otpController = Get.find<OtpController>();
  OtpForgotPasswordController otpForgotPasswordController =
      Get.find<OtpForgotPasswordController>();
  Timer? timer;
  int start = 30;
// Telephony telephony = Telephony.instance;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            start--;
          });
        }
      },
    );
  }

  @override
  void codeUpdated() {
    // TODO: implement codeUpdated
  }

  @override
  void dispose() {
    timer?.cancel();
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  void initState() {
    otpController.otpControllerGet.clear();
    startTimer();
    super.initState();
  }

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
          buildOtpCard(),
        ],
      ),
    );
  }

  buildBackGroundImage() {
    return Image.asset(
      'assets/images/backgroundImage.png',
      width: MediaQuery.of(context).size.width,
      height: kIsWeb == true ? 200 : null,
      fit: BoxFit.fill,
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
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xFFFFFFFF)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/arrow.png'),
          ),
        ),
      ),
    );
  }

  buildOtpCard() {
    return Positioned(
      top: 230,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: kIsWeb == true
                  ? Get.width > 750
                      ? Get.width / 3
                      : 0
                  : 0),
          child: Column(
            children: [
              buildOtpText(),
              buildTimeText(),
              buildOtpTextField(),
              if (start == 0) buildResendLinkButton(),
              buildNextButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOtpTextField() {
    return Container(
        margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
        child: Container(
          margin: const EdgeInsets.only(
            top: 10,
          ),
          child: PinFieldAutoFill(
            decoration: BoxLooseDecoration(
              strokeColorBuilder:
                  PinListenColorBuilder(Colors.black, Colors.black26),
              bgColorBuilder: const FixedColorBuilder(Colors.white),
              strokeWidth: 2,
            ),
            autoFocus: true,
            cursor: Cursor(color: Colors.red, enabled: true, width: 1),
            currentCode: otpController.codeVal.value,
            codeLength: 4,
            controller: otpControllerText,
            onCodeChanged: (code) {
              print("onChange $code");
              otpController.codeVal.value = code.toString();
            },
            onCodeSubmitted: (code) {
              print("onSubmit $code");
              otpController.codeVal.value = code.toString();
            },
          ),
        ));
  }

  // PinFieldAutoFill(
  //                 currentCode: codeVal,
  //                 codeLength: 4,
  //                 onCodeChanged: ,
  //               )

  // Widget buildOtpTextField() {
  //   return Container(
  //     margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
  //     child: Container(
  //       margin: const EdgeInsets.only(
  //         top: 10,
  //       ),
  //       child: customTextField(
  //           isPasswordObscureText: false,
  //           hintText: "Enter OTP".tr,
  //           controller: otpControllerText,
  //           color: R.colors.lightGrey,
  //           height: 45,
  //           borderColour: R.colors.transparent),
  //     ),
  //   );
  // }

  buildOtpText() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: customTitle(
        textAlign: TextAlign.center,
        text: 'Enter OTP'.tr,
        color: R.colors.grey,
        size: 18,
        fontFamily: 'bold',
      ),
    );
  }

  Widget buildResendLinkButton() {
    return GestureDetector(
      onTap: () {
        otpController.otpListener();
        registerController.register(
            "${registerController.code}${registerController.phone.text}");
      },
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 10),
        child: Center(
          child: Text(
            'Resend'.tr,
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontFamily: 'semibold',
                fontSize: 14,
                color: R.colors.buttonColor),
          ),
        ),
      ),
    );
  }

  buildTimeText() {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: customTitle(
        textAlign: TextAlign.center,
        text: "00:${start < 10 ? "0$start" : start}",
        color: R.colors.grey,
        size: 18,
        fontFamily: 'bold',
      ),
    );
  }

  buildNextButton() {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFFB7B57),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          print(
              'This is my phoneNumber===============${otpControllerText.text.toString()}');
          otpController.otpControllerGet.text =
              otpControllerText.text.toString();
          print(
              'This is my phoneNumber===============${otpController.otpControllerGet}');

          if (otpControllerText.text.isEmpty) {
            Get.snackbar(
              'Alert'.tr,
              'Required Field'.tr,
              snackPosition: SnackPosition.TOP,
              backgroundColor: R.colors.themeColor,
            );
            return;
          }
          otpController.otp(otpController.otpControllerGet.text == "١٢٣٤"
              ? "1234"
              : otpController.otpControllerGet.text);
        },
        child: Center(
          child: Text(
            'Go'.tr,
            style: const TextStyle(
                color: Colors.white, fontSize: 13, fontFamily: 'medium'),
          ),
        ),
      ),
    );
  }
}
