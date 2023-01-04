import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sarf/resources/resources.dart';

import '../../resources/text_style.dart';
import '../widgets/custom_textfield.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController otp = TextEditingController();
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
      left: 30,
      child: InkWell(
        onTap: () {},
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
              'Change Password',
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
        decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            )),
        child: Column(
          children: [buildOtpText(), buildOtpField(), buildDivider()],
        ),
      ),
    );
  }

  Widget buildOtpText() {
    return Container(
        margin: EdgeInsets.only(top: 20, bottom: 20),
        child: const Text(
          'Enter OTP',
          style: TextStyle(
              fontSize: 12, fontFamily: 'medium', color: Color(0xFF9A9A9A)),
        ));
  }

  Widget buildDivider() {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 15.0, right: 15, left: 15),
      color: Color(0xFFEDEEEF),
      height: 1.0,
    );
  }

  Widget buildOtpField() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      child: customTextField(
          color: R.colors.lightGrey,
          height: 45.toString(),
          borderColour: R.colors.transparent,
          controller: otp,
          hintText: 'ex 1234',
          hintStyle: TextStyle(color: R.colors.black)),
    );
  }
}
