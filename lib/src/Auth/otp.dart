import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sarf/resources/images.dart';
import 'package:sarf/src/Auth/registration.dart';
import 'package:sarf/src/utils/routes_name.dart';
import 'package:sarf/src/widgets/custom_textfield.dart';
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

class _OtpScreenState extends State<OtpScreen> {
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
void dispose() {
  timer?.cancel();
  super.dispose();
}
@override
void initState() {
    otpController.otpControllerGet.clear();
    startTimer();
//     telephony.listenIncomingSms(
//     onNewMessage: (SmsMessage message) {
//         print(message.address); //+977981******67, sender nubmer
//         print(message.body); //Your OTP code is 34567
//         print(message.date); //1659690242000, timestamp
        
//         String sms = message.body.toString(); //get the message

//         if(message.address == "+977981******67"){
//               //verify SMS is sent for OTP with sender number
//               String otpcode = sms.replaceAll(new RegExp(r'[^0-9]'),'');
//               //prase code from the OTP sms
//               // otpbox.set(otpcode.split("")); 
//               //split otp code to list of number
//               //and populate to otb boxes

//               setState(() {
//                   //refresh UI
//               });

//         }else{
//             print("Normal message.");
//         }
//     },
//     listenInBackground: false,
// );
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
        child: Column(
          children: [
            buildOtpText(),
            buildTimeText(),
            buildOtpTextField(),
            if(start == 0)
            buildResendLinkButton(),
            buildNextButton(),
          ],
        ),
      ),
    );
  }

  Widget buildOtpTextField() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 20),
      child: Container(
        margin: EdgeInsets.only(
          top: 10,
        ),
        child: customTextField(
          isPasswordObscureText: false,
            hintText: "Enter OTP".tr,
            controller: otpControllerText,
            color: R.colors.lightGrey,
            height: 45,
            borderColour: R.colors.transparent),
      ),
    );
  }

  buildOtpText() {
    return Container(
      margin: EdgeInsets.only(top: 20),
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
      onTap: (){
        registerController.register("${registerController.code}${registerController.phone.text}");
      },
      child: Container(
        margin: EdgeInsets.only(top: 30, bottom: 10),
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
      margin: EdgeInsets.only(top: 5),
      child: customTitle(
        textAlign: TextAlign.center,
        text: "00:${  start < 10 ? "0$start" : start  }",
        color: R.colors.grey,
        size: 18,
        fontFamily: 'bold',
      ),
    );
  }

  buildNextButton() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 20),
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xFFFB7B57),
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
          otpController.otp(otpController.otpControllerGet.text == "١٢٣٤" ? "1234": otpController.otpControllerGet.text );
        },
        child: Center(
          child: Text(
            'Go'.tr,
            style: TextStyle(
                color: Colors.white, fontSize: 13, fontFamily: 'medium'),
          ),
        ),
      ),
    );
  }
}
