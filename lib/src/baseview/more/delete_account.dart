import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sarf/src/baseview/more/delete_account2.dart';

import '../../../controllers/common/delete_account_controller.dart';
import '../../../resources/resources.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  bool isChecked = false;
  DeleteAccountController deleteAccountController =
      Get.find<DeleteAccountController>();


  @override
  void initState() {
    deleteAccountController.reasonForDeletingAccountController.clear();
    super.initState();
  }    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.lightGrey,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(left: 16.w, top: 20.h, right: 16.w),
            height: 120.h,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  R.colors.blueGradient1,
                  R.colors.blueGradient2,
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(9),
                    height: 25.h,
                    width: 25.w,
                    decoration: BoxDecoration(
                      color: R.colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 15.sp,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  'Delete my account'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Transform(
            transform: Matrix4.translationValues(0, -40.h, 0),
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Reason for deleting the account'.tr,
                      style: TextStyle(
                        color: R.colors.grey.withOpacity(1),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    TextFormField(
                      controller: deleteAccountController
                          .reasonForDeletingAccountController,
                      maxLines: 10,
                      decoration: InputDecoration(
                        fillColor: R.colors.lightGrey,
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'Type here'.tr,
                        hintStyle: TextStyle(
                          color: R.colors.grey,
                          fontSize: 14.sp,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: R.colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(
                                    color: R.colors.grey,
                                    width: 0.3,
                                  )),
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              }),
                        ),
                        SizedBox(
                          width: 7.w,
                        ),
                        Text(
                          'I accept the terms & conditions'.tr,
                          style: TextStyle(
                            color: R.colors.grey,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (deleteAccountController
                            .reasonForDeletingAccountController.text.isEmpty) {
                          Get.snackbar(
                            'Alert'.tr,
                            'Reason for deleting the account'.tr,
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: R.colors.themeColor,
                          );
                          return;
                        }
                        if (isChecked == false) {
                          Get.snackbar(
                            'Alert'.tr,
                            'Please Accept Terms And Conditions'.tr,
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: R.colors.themeColor,
                          );
                          return;
                        }

                        Get.to(DeleteAccount2());
                      },
                      child: Container(
                        height: 40.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: R.colors.themeColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Next'.tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
