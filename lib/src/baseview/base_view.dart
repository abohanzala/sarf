// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sarf/resources/resources.dart';

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
          items: [
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/arrow.png',color: bNavCon.tabIndex.value == 0 ? R.colors.bgGrey : Colors.green ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_vert),
              label: 'More',
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

