import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sarf/resources/resources.dart';

import '../../resources/images.dart';
import 'base_controller.dart';

//import '../controllers/my_bottom_navigation_controller.dart';
class BaseView extends StatefulWidget {
  const BaseView({super.key});

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
 var bNavCon = Get.put<MyBottomNavigationController>(MyBottomNavigationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => bNavCon.listWidgets[bNavCon.tabIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: bNavCon.changeTabIndex,
          currentIndex: bNavCon.tabIndex.value,
           selectedItemColor: R.colors.themeColor,
           unselectedItemColor: R.colors.grey,
           showUnselectedLabels: true,
           selectedFontSize: 14,
           unselectedFontSize: 14,
           type: BottomNavigationBarType.fixed,
           elevation: 5,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(R.images.bottomReceive,color: bNavCon.tabIndex.value == 0 ? R.colors.themeColor : R.colors.grey,width: 24,height: 24, ),
              label: 'Receive'.tr,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(R.images.bottomMembers,color: bNavCon.tabIndex.value == 1 ? R.colors.themeColor : R.colors.grey,width: 24,height: 24, ),
              label: 'Members'.tr,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(R.images.bottomsend,color: bNavCon.tabIndex.value == 2 ? R.colors.themeColor : R.colors.grey,width: 24,height: 24, ),
              label: 'Send'.tr,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(R.images.bottominvoice,color: bNavCon.tabIndex.value == 3 ? R.colors.themeColor : R.colors.grey,width: 24,height: 24, ),
              label: 'Invoices'.tr,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(R.images.bottommore,color: bNavCon.tabIndex.value == 4 ? R.colors.themeColor : R.colors.grey,width: 24,height: 24, ),
              label: 'More'.tr,
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(CupertinoIcons.person),
            //   label: ')Account',
            // ),
          ],
        ),
      ),
    );
  }
}

