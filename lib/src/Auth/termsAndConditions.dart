import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../controllers/common/terms_and_conditions_controller.dart';
import '../../resources/dummy.dart';
import '../../resources/resources.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/loader.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  TermsAndConditionsController termsAndConditionsController =
      Get.find<TermsAndConditionsController>();

  @override
  // ignore: must_call_super
  initState() {
    // ignore: avoid_print
    termsAndConditionsController.terms();
    print("initState Called");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          buildBackGroundImage(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(0),
              children: [buildProfileCard()],
            ),
          )
        ],
      ),
    );
  }

  Widget buildProfileCard() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: MediaQuery.of(context).size.height - 200,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            )),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                color: R.colors.white, borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        child: HtmlWidget(termsAndConditionsController
                                .userInfo!.data!.title!.ar ??
                            '')),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                HtmlWidget(
                    termsAndConditionsController.userInfo!.data!.content!.ar ??
                        '')
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUpdateButton() {
    return Container(
      margin: EdgeInsets.only(
        top: 30,
        bottom: 20,
      ),
      child: customButton(
          margin: 20,
          width: MediaQuery.of(context).size.width,
          titleTextAlign: TextAlign.center,
          onPress: (() {
            //Get.toNamed('otp_screen');
          }),
          title: 'Update',
          color: R.colors.buttonColor,
          height: 45,
          borderColour: R.colors.transparent,
          textColor: R.colors.white),
    );
  }

  Widget buildBackArrowContainerAndChangeProfileText() {
    return Positioned(
      top: 50,
      left: 20,
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
              'Terms & Conditions'.tr,
              style: TextStyle(
                  color: R.colors.white, fontFamily: 'bold', fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  Widget buildBackGroundImage() {
    return Stack(alignment: Alignment.topLeft, children: [
      Image.asset(
        R.images.backgroundImageChangePassword,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 5,
        fit: BoxFit.cover,
      ),
      // buildOptions(),
      buildBackArrowContainerAndChangeProfileText(),
      Positioned(
        top: 100,
        left: 20,
        child: Column(
          children: [
            buildNotificationAndSettingsIcon(),
          ],
        ),
      )
    ]);
  }

  Widget buildOptions() {
    return Positioned(
      top: 70,
      left: 30,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Row(
          children: [
            buildImage(),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name',
                  style: TextStyle(
                      color: R.colors.white, fontFamily: 'bold', fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                buildViewProfileLinkButton()
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLogoutIconAndText() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Image.asset(
            R.images.logoutIcon,
            height: 20,
            width: 20,
          ),
          SizedBox(
            width: 10,
          ),
          Text('Logout', style: TextStyle(fontFamily: 'semibold', fontSize: 12))
        ],
      ),
    );
  }

  Widget buildNotificationAndSettingsIcon() {
    return Row(
      children: [
        Container(
          height: 45,
          width: MediaQuery.of(context).size.width / 1.5,
          decoration: BoxDecoration(
            color: R.colors.lightGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    'English',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'medium',
                        color: R.colors.black),
                  )),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Image.asset(
          R.images.shareIcon,
          height: 20,
          width: 20,
          color: R.colors.white,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'Share'.tr,
          style: TextStyle(fontSize: 15, color: R.colors.white),
        )
      ],
    );
  }

  Widget buildImage() {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            100,
          ),
          color: R.colors.white),
    );
  }

  Widget buildViewProfileLinkButton() {
    return Text(
      'View Profile',
      style: TextStyle(
          decoration: TextDecoration.underline,
          fontFamily: 'medium',
          fontSize: 14,
          color: R.colors.white),
    );
  }

  Widget buildSelectCityDropDown() {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: R.colors.lightGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                'Crockery',
                style: TextStyle(
                    fontSize: 12, fontFamily: 'medium', color: R.colors.black),
              )),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLanguageOptionWithShare() {
    return Row(
      children: [buildSelectCityDropDown()],
    );
  }
}
