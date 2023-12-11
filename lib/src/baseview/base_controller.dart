// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sarf/src/baseview/Invoices/invoice_list.dart';
import 'package:sarf/src/baseview/Send/simple_invoice.dart';
import 'package:sarf/src/baseview/home/home_view.dart';
import 'package:sarf/src/baseview/members/members_view.dart';
import 'package:sarf/src/baseview/more/more_view.dart';

import 'Invoices/invoice_members.dart';
// import 'package:warid_container_admin/app/modules/More/views/more_view.dart';
// import 'package:warid_container_admin/app/modules/Orders/controllers/orders_controller.dart';
// import 'package:warid_container_admin/app/modules/Orders/views/orders_view.dart';
// import 'package:warid_container_admin/app/modules/home/controllers/home_controller.dart';
// import 'package:warid_container_admin/app/modules/home/views/home_view.dart';

class MyBottomNavigationController extends GetxController {
  var tabIndex = 0.obs;
  final currentPage = 0.obs;
  // final homeCon = Get.put(HomeController());
  // final orderCon = Get.put(OrdersController());
  void changeTabIndex(int index) {
    if (GetStorage().read("user_type") == 3 && (index == 1 || index == 2)) {
      print("here1");
      Get.snackbar("Error".tr, "You do not have access".tr);
      return;
    }
    if (GetStorage().read("accountType") == 2 && (index == 0)) {
      print("here2");
      Get.snackbar("Error".tr, "You do not have access".tr);
      return;
    }
    tabIndex.value = index;
  }

  List<Widget> listWidgets = [
    const HomeScreen(),
    const MembersScreen(),
    const SimpleInvoice(),
    // const InvoiceListScreen(),
    const InvoiceMembersListScreen(),
    const MoreScreen()
  ];

  @override
  // ignore: unnecessary_overrides
  void onInit() {
    tabIndex.value = 0;
    super.onInit();
    // currentPage == 1
    //     ? tabIndex.value = 1
    //     : currentPage == 2
    //         ? tabIndex.value = 2
    //         : currentPage == 3
    //             ? tabIndex.value = 3
    //             : tabIndex.value = 0;
  }

  @override
  void onClose() {}
  // void increment() => count.value++;
}
