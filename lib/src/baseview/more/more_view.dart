import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sarf/resources/dummy.dart';
import 'package:sarf/src/utils/routes_name.dart';
import 'package:sarf/src/widgets/custom_textfield.dart';

import '../../../resources/resources.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildBackGroundImage(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(0),
              children: [buildMoreDetails()],
            ),
          )
        ],
      ),
    );
  }

  Widget buildMoreDetails() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildSubscribeButton(),
              buildHelpAndSupportOption(),
              buildDivider(),
              buildTermsAndConditionsOption(),
              buildDivider(),
              buildPrivacyPolicyOption(),
              buildDivider(),
              buildShareOption(),
              buildDivider(),
              buildRateOption(),
              buildDivider(),
              buildAboutOption(),
              buildDivider(),
              buildDeleteAccountOption()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTermsAndConditionsOption() {
    return InkWell(
      onTap: () {
        Get.toNamed('terms_and_conditions');
      },
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          children: [
            buildTermsAndConditionsImage(),
            buildTermsAndConditionsText()
          ],
        ),
      ),
    );
  }

  Widget buildTermsAndConditionsImage() {
    return Image.asset(
      R.images.termsAndConditionsIcon,
      height: 20,
      width: 20,
    );
  }

  Widget buildHelpAndSupportOption() {
    return InkWell(
      onTap: () {
        Get.toNamed('Support');
      },
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: Row(
          children: [
            buildHelpAndSupportImage(),
            buildHelpAndSupportText(),
          ],
        ),
      ),
    );
  }

  Widget buildPrivacyPolicyOption() {
    return InkWell(
      onTap: () {
        Get.toNamed('privacy_policy');
      },
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          children: [
            buildPrivacyPolicyImage(),
            buildPrivacyPolicyText(),
          ],
        ),
      ),
    );
  }

  Widget buildShareOption() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          buildShareImage(),
          buildShareText(),
        ],
      ),
    );
  }

  Widget buildRateOption() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          buildRateImage(),
          buildRateText(),
        ],
      ),
    );
  }

  Widget buildAboutOption() {
    return InkWell(
      onTap: () {
        Get.toNamed('about');
      },
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          children: [
            buildAboutImage(),
            buildAboutText(),
          ],
        ),
      ),
    );
  }

  Widget buildDeleteAccountOption() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          buildDeleteAccountImage(),
          buildDeleteAccountText(),
        ],
      ),
    );
  }

  Widget buildRateText() {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: Text(
        'Rate',
        style: TextStyle(fontSize: 14, fontFamily: 'medium'),
      ),
    );
  }

  Widget buildDivider() {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 20),
      color: R.colors.lightGrey,
      height: 2.0,
    );
  }

  Widget buildPrivacyPolicyImage() {
    return Image.asset(
      R.images.privacyPolicyIcon,
      height: 20,
      width: 20,
    );
  }

  Widget buildHelpAndSupportImage() {
    return Image.asset(
      R.images.helpAndSupportIcon,
      height: 20,
      width: 20,
    );
  }

  Widget buildDeleteAccountImage() {
    return Image.asset(
      R.images.deleteIcon,
      height: 20,
      width: 20,
    );
  }

  Widget buildDeleteAccountText() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RoutesName.deleteAccount);
      },
      child: Container(
        margin: EdgeInsets.only(left: 20),
        child: Text(
          'Delete Account',
          style: TextStyle(fontSize: 14, fontFamily: 'medium'),
        ),
      ),
    );
  }

  Widget buildAboutImage() {
    return Image.asset(
      R.images.aboutIcon,
      height: 20,
      width: 20,
    );
  }

  Widget buildAboutText() {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: Text(
        'About',
        style: TextStyle(fontSize: 14, fontFamily: 'medium'),
      ),
    );
  }

  Widget buildRateImage() {
    return Image.asset(
      R.images.rateIcon,
      height: 20,
      width: 20,
    );
  }

  Widget buildShareImage() {
    return Image.asset(
      R.images.shareIcon,
      height: 20,
      width: 20,
    );
  }

  Widget buildShareText() {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: Text(
        'Share',
        style: TextStyle(fontSize: 14, fontFamily: 'medium'),
      ),
    );
  }

  Widget buildPrivacyPolicyText() {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: Text(
        'Privacy Policy',
        style: TextStyle(fontSize: 14, fontFamily: 'medium'),
      ),
    );
  }

  Widget buildHelpAndSupportText() {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: Text(
        'Support',
        style: TextStyle(fontSize: 14, fontFamily: 'medium'),
      ),
    );
  }

  Widget buildTermsAndConditionsText() {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: Text(
        'Terms & Conditions',
        style: TextStyle(fontSize: 14, fontFamily: 'medium'),
      ),
    );
  }

  Widget buildSubscribeButton() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: customButton(
        margin: 20,
        width: MediaQuery.of(context).size.width,
        titleTextAlign: TextAlign.start,
        title: 'Subscribe',
        color: R.colors.blue,
        textColor: R.colors.white,
        height: 45,
        borderColour: R.colors.transparent,
        onPress: (() {
          openSubscriptionDialog();
        }),
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
      buildOptions(),
      Positioned(
        top: 80,
        right: 30,
        child: Column(
          children: [
            buildNotificationAndSettingsIcon(),
            buildLogoutIconAndText()
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
          Text(
            'Logout',
            style: TextStyle(fontFamily: 'semibold', fontSize: 12),
          )
        ],
      ),
    );
  }

  Widget buildNotificationAndSettingsIcon() {
    return Row(
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            GestureDetector(
              onTap: () => Get.toNamed(RoutesName.alerts),
              child: Image.asset(
                R.images.notificationIcon,
                height: 20,
                width: 20,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: R.colors.buttonColor,
              ),
              height: 10,
              width: 10,
            )
          ],
        ),
        SizedBox(
          width: 20,
        ),
        InkWell(
          onTap: () {
            Get.toNamed('settings');
          },
          child: Image.asset(
            R.images.settingsIcon,
            height: 20,
            width: 20,
          ),
        ),
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

  void openSubscriptionDialog() {
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
                    height: MediaQuery.of(context).size.height / 2,
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
                        buildSubscriptionCard(),
                        buildSubscribeAndNotNowButtonsInPoPup()
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

  Widget buildSubscriptionCard() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              buildSubscriptionImage(),
              buildSubScriptionTextHeading(),
              buildSubScriptionMessageDetail()
            ],
          ),
        ));
  }

  Widget buildSubscriptionImage() {
    return Container(
        margin: EdgeInsets.only(top: 30),
        child: Image.asset(
          R.images.subscriptionImage,
          height: 90,
        ));
  }

  Widget buildSubScriptionTextHeading() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Text(
        'Subscription',
        style: TextStyle(fontFamily: 'bold', fontSize: 18),
      ),
    );
  }

  Widget buildSubScriptionMessageDetail() {
    return SingleChildScrollView(
      child: Container(
        height: 50,
        margin: EdgeInsets.only(top: 20, left: 15, right: 15),
        child: Text(
          DummyData.longText,
          style: TextStyle(
              fontFamily: 'medium', fontSize: 12, color: R.colors.grey),
        ),
      ),
    );
  }

  Widget buildSubscribeAndNotNowButtonsInPoPup() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: customButton(
                margin: 0,
                width: MediaQuery.of(context).size.width,
                titleTextAlign: TextAlign.center,
                title: 'Subscribe Now',
                color: R.colors.buttonColor,
                textColor: R.colors.white,
                height: 45,
                borderColour: R.colors.transparent,
                onPress: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: customButton(
              optionalNavigateIcon: false,
              margin: 0,
              width: MediaQuery.of(context).size.width / 3,
              titleTextAlign: TextAlign.center,
              title: 'Skip',
              color: Colors.grey[300]!,
              textColor: R.colors.black,
              height: 45,
              borderColour: R.colors.transparent,
              onPress: (() {
                Navigator.pop(context);
              }),
            ),
          ),
        ],
      ),
    );
  }
}
