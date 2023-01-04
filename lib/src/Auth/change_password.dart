import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sarf/resources/resources.dart';

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
      margin: EdgeInsets.only(top: 5.0, bottom: 15.0, right: 15, left: 15),
      color: Color(0xFFEDEEEF),
      height: 1.0,
    );
  }

  Widget buildOtpField() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Color(0xFFEAEEF2)),
      child: TextField(
        textAlign: TextAlign.center,
        focusNode: otpFieldNode,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'example 1234',
            hintStyle: TextStyle(
                fontSize: 10,
                fontFamily: 'medium',
                color: Color(0xFF9A9A9A).withOpacity(0.8)),
            border: InputBorder.none),
      ),
    );
  }

  Widget buildPasswordField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: getHeightAccordingToScreen(2.5),
          ),
          Row(
            children: <Widget>[
              Text(
                'Passsword',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontFamily: 'bold',
                ),
              ),
              Text(
                '*',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 15,
                  fontFamily: 'bold',
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              FocusScope.of(context).requestFocus(passwordNode);
            },
            child: Container(
              height: getHeightAccordingToScreen(7.5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white),
              //padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: TextField(
                      //controller: controller,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (value) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      focusNode: passwordNode,
                      keyboardType: TextInputType.text,
                      obscureText: isPasswordObscureText,
                      decoration: InputDecoration(
                        hintText: '••••••••',
                        hintStyle: TextStyle(
                          fontSize: 13.0,
                          fontFamily: 'medium',
                          color: Color(0xFFA3A3A3),
                        ),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        contentPadding: EdgeInsets.all(0.0),
                      ),
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'medium',
                        color: Color(0xFF666666),
                      ),
                      maxLines: 1,
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {},
                    child: Container(
                      height: 37,
                      width: 37,
                      padding: EdgeInsets.all(12),
                      child: Image.asset(
                        isPasswordObscureText
                            ? 'assets/images/closeeye.png'
                            : 'assets/images/openeye.png',
                        color: Color(0xFF999999),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  double getHeightAccordingToScreen(double height) {
    return (height / 100) * bodyHeight;
  }
}
