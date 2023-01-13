import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/common/about_controller.dart';
import '../../controllers/common/profile_controller.dart';
import '../../resources/resources.dart';
import '../widgets/custom_textfield.dart';

class ChangeProfile extends StatefulWidget {
  const ChangeProfile({Key? key}) : super(key: key);

  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  ProfileController profileController = Get.find<ProfileController>();

  @override
  // ignore: must_call_super
  initState() {
    // ignore: avoid_print
    profileController.getProfile();

    print("initState Called");
  }

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
                buildBackArrowContainerAndChangeProfileText(),
              ],
            ),
          ),
          buildProfileCard()
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
      buildBackArrowContainerAndChangeProfileText(),
    ]);
  }

  Widget buildBackArrowContainerAndChangeProfileText() {
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
              'Change Profile'.tr,
              style: TextStyle(
                  color: R.colors.white, fontFamily: 'bold', fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  Widget buildProfileCard() {
    return Positioned(
      top: 100,
      right: 20,
      left: 20,
      child: Container(
        height: MediaQuery.of(context).size.height - 100,
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
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                buildNameField(),
                buildSelectCityDropDown(),
                buildUserNameField(),
                buildWhatsappField(),
                buildTwitterField(),
                buildInstaField(),
                buildContactNoField(),
                buildEmailField(),
                buildLocationButton(),
                buildUploadImage(),
                buildUpdateButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUploadImage() {
    return InkWell(
      onTap: () {
        openPopUpOptions('In Process Development');
      },
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    100,
                  ),
                  color: R.colors.blue),
              child: Center(
                child: Text(
                  'LOGO',
                  style: TextStyle(
                      fontFamily: 'regular', color: Colors.white, fontSize: 12),
                ),
              ),
            ),
            Image.asset(
              R.images.cross,
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget buildLocationButton() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      height: 50,
      decoration: BoxDecoration(
        color: R.colors.lightGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          //   Get.toNamed(RoutesName.RegistrationDetails);
        },
        child: Row(
          children: [
            Container(
                margin: const EdgeInsets.only(left: 10),
                child: const Icon(
                  Icons.pin_drop,
                  size: 20,
                  color: Colors.blue,
                )),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                profileController.locationController.text.tr,
                style: TextStyle(
                    color: R.colors.black, fontSize: 13, fontFamily: 'medium'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSelectCityDropDown() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 45,
      decoration: BoxDecoration(
        color: R.colors.lightGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          openPopUpOptions('No Crockery Available');
        },
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                'Crockery'.tr,
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
          title: 'Update'.tr,
          color: R.colors.buttonColor,
          height: 45,
          borderColour: R.colors.transparent,
          textColor: R.colors.white),
    );
  }

  Widget buildNameField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: customTextField(
          hintTextSize: 12,
          hintText: 'Full Name *',
          controller: profileController.nameController,
          color: R.colors.lightGrey,
          height: 45,
          borderColour: R.colors.transparent),
    );
  }

  Widget buildUserNameField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: customTextField(
          hintTextSize: 12,
          hintText: 'bdscdscb',
          controller: profileController.userNameController,
          color: R.colors.lightGrey,
          height: 45,
          borderColour: R.colors.transparent),
    );
  }

  Widget buildEmailField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: customTextField(
          hintTextSize: 12,
          hintText: '213412',
          controller: profileController.emailController,
          color: R.colors.lightGrey,
          height: 45,
          borderColour: R.colors.transparent),
    );
  }

  Widget buildInstaField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: customTextField(
          hintTextSize: 12,
          hintText: '@d cn',
          controller: profileController.instaController,
          color: R.colors.lightGrey,
          height: 45,
          borderColour: R.colors.transparent),
    );
  }

  Widget buildWhatsappField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: customTextField(
          hintTextSize: 12,
          hintText: '@dscd',
          controller: profileController.whatsappController,
          color: R.colors.lightGrey,
          height: 45,
          borderColour: R.colors.transparent),
    );
  }

  Widget buildWebsiteField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: customTextField(
          hintTextSize: 12,
          hintText: '@dsjnc',
          controller: profileController.websiteController,
          color: R.colors.lightGrey,
          height: 45,
          borderColour: R.colors.transparent),
    );
  }

  Widget buildContactNoField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: customTextField(
          hintTextSize: 12,
          hintText: '+923313',
          controller: profileController.contactController,
          color: R.colors.lightGrey,
          height: 45,
          borderColour: R.colors.transparent),
    );
  }

  Widget buildTwitterField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: customTextField(
          hintTextSize: 12,
          hintText: '@adcsdc',
          controller: profileController.twitterController,
          color: R.colors.lightGrey,
          height: 45,
          borderColour: R.colors.transparent),
    );
  }

  Widget buildLocationField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: customTextField(
          hintTextSize: 12,
          hintText: 'e.g oloasjxdjdn dhx',
          controller: profileController.locationController,
          color: R.colors.lightGrey,
          height: 45,
          borderColour: R.colors.transparent),
    );
  }

  void openPopUpOptions(String message) {
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
                height: MediaQuery.of(context).size.height / 2,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          message,
                          style: TextStyle(
                              fontFamily: 'regular', color: R.colors.grey),
                        )
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
}
