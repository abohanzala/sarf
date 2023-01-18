import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../controllers/common/about_controller.dart';
import '../../resources/dummy.dart';
import '../../resources/resources.dart';
import '../widgets/custom_textfield.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  AboutController aboutController = Get.find<AboutController>();
  bool english = true;
  bool arabic = false;
  var selectedLanguage = 'English'.obs;

  @override
  initState() {
    // ignore: avoid_print
    aboutController.about();
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
                      child: GetBuilder<AboutController>(
                          builder: (AboutController) {
                        return Obx(() => HtmlWidget(selectedLanguage.value ==
                                'English'
                            ? aboutController.userInfo?.data!.title!.en ?? ''
                            : aboutController.userInfo?.data!.title!.ar ?? ''));
                      }),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                GetBuilder<AboutController>(builder: (AboutController) {
                  return Obx(() => HtmlWidget(
                      selectedLanguage.value == 'English'
                          ? aboutController.userInfo?.data!.content!.en ?? ''
                          : aboutController.userInfo?.data!.content!.ar ?? ''));
                }),
              ],
            ),
          ),
        ),
      ),
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
              'About'.tr,
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

  void openChangeLanguageDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
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
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 3,
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
                              Text(
                                'Select Language',
                                style: TextStyle(
                                    fontFamily: 'bold',
                                    fontSize: 20,
                                    color: R.colors.black),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                onTap: () {
                                  english = true;
                                  arabic = false;
                                  selectedLanguage.value = 'English';

                                  Get.back();
                                  setState(() {});
                                },
                                child: Container(
                                    margin:
                                        EdgeInsets.only(left: 15, right: 15),
                                    decoration: BoxDecoration(
                                        color: english
                                            ? R.colors.buttonColor
                                            : R.colors.transparent,
                                        border:
                                            Border.all(color: R.colors.grey)),
                                    height: 45,
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: Text(
                                        'English',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: english
                                                ? R.colors.black
                                                : R.colors.buttonColor),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  english = false;
                                  arabic = true;
                                  selectedLanguage.value = 'Arabic';
                                  Get.back();
                                  setState(() {});
                                },
                                child: Container(
                                    margin:
                                        EdgeInsets.only(left: 15, right: 15),
                                    decoration: BoxDecoration(
                                        color: arabic
                                            ? R.colors.buttonColor
                                            : R.colors.transparent,
                                        border:
                                            Border.all(color: R.colors.grey)),
                                    height: 45,
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: Text(
                                        'Arabic',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: arabic
                                                ? R.colors.black
                                                : R.colors.buttonColor),
                                      ),
                                    )),
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
        });
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
            onTap: () {
              openChangeLanguageDialog();
            },
            child: Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: [
                  Expanded(
                      child: Obx(() => Text(
                            selectedLanguage.value,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'medium',
                                color: R.colors.black),
                          ))),
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
}
