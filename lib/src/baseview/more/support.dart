import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sarf/controllers/support/support_controller.dart';
import 'package:sarf/src/baseview/more/single_support.dart';
import 'package:sarf/src/utils/routes_name.dart';

import '../../../resources/resources.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_textfield.dart';
import '../members/single_member_detail.dart';

class Support extends StatefulWidget {
  const Support({Key? key}) : super(key: key);

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  bool pending = true;
  bool success = false;
  SupportController ctr = Get.put<SupportController>(SupportController());

  @override
  void initState() {
    ctr.getSupport(ctr.supportStatus.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.lightGrey,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildBackGroundImage(),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ctr.isLoadingSupport.value == true
                  ? SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        //backgroundColor: AppColors.whiteClr,
                        color: R.colors.blue,
                      ),
                    )
                  : ctr.supportList.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text('No Data'.tr),
                        )
                      : Transform(
                        transform: Matrix4.translationValues(0, -30, 0),
                        child: ListView.builder(
                            itemCount: ctr.supportList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var singleData = ctr.supportList[index];
                              return Container(
                                width: Get.width,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: R.colors.white),
                                child: IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'ID'.tr,
                                            style: TextStyle(
                                                color: R.colors.grey,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            singleData.id.toString(),
                                            style: TextStyle(
                                                color: R.colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Type'.tr,
                                            style: TextStyle(
                                                color: R.colors.grey,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            singleData.type == "0"
                                                ? "Business".tr
                                                : "Personal".tr,
                                            style: TextStyle(
                                                color: R.colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      const Spacer(
                                        flex: 2,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Date'.tr,
                                            style: TextStyle(
                                                color: R.colors.grey,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            singleData.createdDate.toString(),
                                            style: TextStyle(
                                                color: R.colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Status'.tr,
                                            style: TextStyle(
                                                color: R.colors.grey,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            singleData.status == "0"
                                                ? "Pending".tr
                                                : "Success".tr,
                                            style:  TextStyle(
                                                color: singleData.status == "0" ? Color(0XFFF4BD05) : Color(0XFF2CC91F),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      VerticalDivider(
                                        color: R.colors.lightBlue4,
                                        thickness: 0.3,
                                      ),
                                      const Spacer(),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                              onTap: () =>
                                                  Get.to(() => SingleSupport(
                                                        title:
                                                            'Support ID  :  ${singleData.id.toString()}',
                                                        id: singleData.id
                                                            .toString(),
                                                        date: singleData
                                                            .createdDate
                                                            .toString(),
                                                      )),
                                              child: Icon(
                                                Icons.remove_red_eye,
                                                color: R.colors.themeColor,
                                              ))
                                        ],
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBackArrowAndSupportText() {
    return Positioned(
      top: 80,
      left: GetStorage().read("lang") == "en" ? 12 : null,
      right: GetStorage().read("lang") != "en" ? 12 : null,
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
                  color: const Color(0xFFFFFFFF)),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(R.images.arrowBlue)),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              'Support'.tr,
              style: TextStyle(
                  color: R.colors.white, fontFamily: 'bold', fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAddNewButton() {
    return Positioned(
      top: 80,
      //right: 12,
      left: GetStorage().read("lang") != "en" ? 12 : null,
      right: GetStorage().read("lang") == "en" ? 12 : null,
      child: Container(
        child: customButton(
          optionalNavigateIcon: false,
          margin: 0,
          width: MediaQuery.of(context).size.width / 3.5,
          titleTextAlign: TextAlign.center,
          title: 'Add New'.tr,
          color: R.colors.black,
          textColor: R.colors.white,
          height: 35,
          borderColour: R.colors.transparent,
          onPress: (() {
            Get.toNamed(RoutesName.newSupport);
          }),
        ),
      ),
    );
  }

  Widget buildBackGroundImage() {
    return Container(
      height: MediaQuery.of(context).size.height / 4.2,
      child: Stack(alignment: Alignment.topLeft, children: [
        Image.asset(
          R.images.backgroundImageChangePassword,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 5,
          fit: BoxFit.cover,
        ),
        buildBackArrowAndSupportText(),
        buildAddNewButton(),
        buildStatusCard()
      ]),
    );
  }

  Widget buildStatusCard() {
    return Positioned(
      right: 12,
      left: 12,
      top: 130,
      child: Container(
        //margin: EdgeInsets.only(left: 15, right: 15),
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: R.colors.white),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              buildPendingOption(),
              const SizedBox(
                width: 10,
              ),
              buildSuccessOption()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPendingOption() {
    return Expanded(
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          pending = true;
          success = false;
          ctr.supportStatus.value = '1';
          setState(() {});
          ctr.getSupport(ctr.supportStatus.value);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: pending ? R.colors.blue : Colors.transparent,
          ),
          height: 40,
          child: Center(
            child: Text(
              'Pending'.tr,
              style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'semibold',
                  color: pending ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSuccessOption() {
    return Expanded(
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          pending = false;
          success = true;
          ctr.supportStatus.value = '2';
          setState(() {});
          ctr.getSupport(ctr.supportStatus.value);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: success ? R.colors.blue : Colors.transparent,
          ),
          height: 40,
          child: Center(
            child: Text(
              'Success'.tr,
              style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'semibold,',
                  color: success ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
