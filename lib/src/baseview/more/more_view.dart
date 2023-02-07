
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sarf/resources/dummy.dart';
import 'package:sarf/services/dio_client.dart';
import 'package:sarf/src/Auth/change_profile.dart';
import 'package:sarf/src/utils/routes_name.dart';
import 'package:sarf/src/widgets/custom_textfield.dart';
import '../../../constant/api_links.dart';
import '../../../controllers/common/profile_controller.dart';
import '../../../resources/resources.dart';
import '../base_controller.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

Future logout() async {
  // openLoader();

  var response =
      await DioClient().get(ApiLinks.logout).catchError((error) async {
    //debugPrint(error.toString());
    await GetStorage().remove('user_token');
    await GetStorage().remove('userId');
    await GetStorage().remove(
      'name',
    );
    await GetStorage().remove(
      'username',
    );
    await GetStorage().remove(
      'email',
    );
    await GetStorage().remove(
      'firebase_email',
    );
    await GetStorage().remove(
      'mobile',
    );
    await GetStorage().remove(
      'photo',
    );
    await GetStorage().remove(
      'status',
    );
    MyBottomNavigationController ctr =
        Get.put<MyBottomNavigationController>(MyBottomNavigationController());
    ctr.tabIndex.value = 0;
    Get.offAllNamed(RoutesName.LogIn)?.then((value) {
      MyBottomNavigationController ctr =
          Get.put<MyBottomNavigationController>(MyBottomNavigationController());
      ctr.tabIndex.value = 0;
    });
  });
  // print(response);

  await GetStorage().remove('user_token');
  await GetStorage().remove('userId');
  await GetStorage().remove(
    'name',
  );
  await GetStorage().remove(
    'username',
  );
  await GetStorage().remove(
    'email',
  );
  await GetStorage().remove(
    'firebase_email',
  );
  await GetStorage().remove(
    'mobile',
  );
  await GetStorage().remove(
    'photo',
  );
  await GetStorage().remove(
    'status',
  );
  MyBottomNavigationController ctr =
      Get.put<MyBottomNavigationController>(MyBottomNavigationController());
  ctr.tabIndex.value = 0;
  Get.offAllNamed(RoutesName.LogIn)?.then((value) {});
}

class _MoreScreenState extends State<MoreScreen> {
  ProfileController profileController = Get.find<ProfileController>();
  bool isLoading = true;

  @override
// ignore: must_call_super
  initState() {
    // ignore: avoid_print
    getData();
    print("initState Called");
  }

  Future getData() async {
    await profileController.getProfile().then((value) => setState(() {
          isLoading = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? Center(child: CircularProgressIndicator())
          : Column(
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
      margin: EdgeInsets.only(left: GetStorage().read('lang') == "en"? 20 : 0,right:GetStorage().read('lang') != "en"? 20 : 0),
      child: Text(
        'Rate'.tr,
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
        margin: EdgeInsets.only(left: GetStorage().read('lang') == "en"? 20 : 0,right:GetStorage().read('lang') != "en"? 20 : 0),
        child: Text(
          'Delete Account'.tr,
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
      margin: EdgeInsets.only(left: GetStorage().read('lang') == "en"? 20 : 0,right:GetStorage().read('lang') != "en"? 20 : 0),
      child: Text(
        'About'.tr,
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
      margin: EdgeInsets.only(left: GetStorage().read('lang') == "en"? 20 : 0,right:GetStorage().read('lang') != "en"? 20 : 0),
      child: Text(
        'Share'.tr,
        style: TextStyle(fontSize: 14, fontFamily: 'medium'),
      ),
    );
  }

  Widget buildPrivacyPolicyText() {
    return Container(
      margin: EdgeInsets.only(left: GetStorage().read('lang') == "en"? 20 : 0,right:GetStorage().read('lang') != "en"? 20 : 0),
      child: Text(
        'Privacy Policy'.tr,
        style: TextStyle(fontSize: 14, fontFamily: 'medium'),
      ),
    );
  }

  Widget buildHelpAndSupportText() {
    return Container(
      margin: EdgeInsets.only(left: GetStorage().read('lang') == "en"? 20 : 0,right:GetStorage().read('lang') != "en"? 20 : 0),
      child: Text(
        'Support'.tr,
        style: TextStyle(fontSize: 14, fontFamily: 'medium'),
      ),
    );
  }

  Widget buildTermsAndConditionsText() {
    return Container(
      margin: EdgeInsets.only(left: GetStorage().read('lang') == "en"? 20 : 0,right:GetStorage().read('lang') != "en"? 20 : 0 ),
      child: Text(
        'Terms & Conditions'.tr,
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
        title: 'Subscribe'.tr,
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
        right: GetStorage().read('lang') == 'en' ?  30 : null,
        //left: GetStorage().read('lang') == 'en' ?  0 : 30 ,
        left: GetStorage().read('lang') != 'en' ?  30 : null,
        
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
      left: GetStorage().read('lang') == 'en' ?  30 : 0 ,
      right: GetStorage().read('lang') == 'en' ?  0 : 30,
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
                profileController.profileModel!.user!.name!.tr,
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
    );
  }

  Widget buildLogoutIconAndText() {
    return GestureDetector(
      onTap: () {
        Get.dialog(Dialog(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: R.colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Are you sure you want to logout".tr),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                          logout();
                        },
                        child: Container(
                          // width: Get.width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: R.colors.themeColor),
                          child: Center(
                              child: Text(
                            'Logout'.tr,
                            style: TextStyle(color: R.colors.white),
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          // width: Get.width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: R.colors.blue),
                          child: Center(
                              child: Text(
                            'Back'.tr,
                            style: TextStyle(color: R.colors.white),
                          )),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
      },
      child: Container(
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
              'Logout'.tr,
              style: TextStyle(fontFamily: 'semibold', fontSize: 12),
            )
          ],
        ),
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
          color: R.colors.white,
        ),
        child: profileController.profileModel!.user!.photo != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  ApiLinks.assetBasePath +
                      profileController.profileModel!.user!.photo!,
                  fit: BoxFit.cover,
                ),
              )
            : Container());
  }

  Widget buildViewProfileLinkButton() {
    return InkWell(
      onTap: (){
        Get.bottomSheet(Container(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          decoration: BoxDecoration(
            color: R.colors.white,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   GestureDetector(
                    onTap: (){
                      Get.toNamed(RoutesName.RegistrationDetails);
                    },
                    child: Text('Add new account'.tr,style: TextStyle(color: R.colors.themeColor,fontSize: 14,decoration: TextDecoration.underline),)),
                   GestureDetector(
                    onTap: (){
                      Get.toNamed(RoutesName.LogIn);
                    },
                    child: Text('Existing account'.tr,style: TextStyle(color: R.colors.themeColor,fontSize: 14,decoration: TextDecoration.underline),)),
                 ],
               ),
               const SizedBox(height: 10,),
              Divider(color: R.colors.lightGrey,thickness: 0.5,),
              const SizedBox(height: 10,),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: R.colors.grey,
                      ),
                      const SizedBox(width: 10,),
                      Text('Account Name',style: TextStyle(fontSize: 14,color: R.colors.black,fontWeight: FontWeight.w500),)
                    ],
                  ),
                );
                
              }),
               
            ],),
          ),
        ));
      },
      child: Text(
        'View Profile'.tr,
        style: TextStyle(
            decoration: TextDecoration.underline,
            fontFamily: 'medium',
            fontSize: 14,
            color: R.colors.white),
      ),
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
                //height: MediaQuery.of(context).size.height,
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
          //height: MediaQuery.of(context).size.height / 3,
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
        'Subscription'.tr,
        style: TextStyle(fontFamily: 'bold', fontSize: 18),
      ),
    );
  }

  Widget buildSubScriptionMessageDetail() {
    return Container(
      // height: 50,
      margin: EdgeInsets.only(top: 20, left: 15, right: 15,bottom: 20),
      child: Text(
        DummyData.longText,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'medium', fontSize: 12, color: R.colors.grey),
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
                title: 'Subscribe Now'.tr,
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
              title: 'Skip'.tr,
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
