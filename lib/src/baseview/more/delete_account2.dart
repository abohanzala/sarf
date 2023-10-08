import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/common/delete_account_controller.dart';
import '../../../resources/resources.dart';

class DeleteAccount2 extends StatefulWidget {
  const DeleteAccount2({super.key});

  @override
  State<DeleteAccount2> createState() => _DeleteAccount2State();
}

class _DeleteAccount2State extends State<DeleteAccount2> {
  bool isChecked = false;
  DeleteAccountController deleteAccountController =
      Get.find<DeleteAccountController>();

  @override
  void initState() {
    deleteAccountController.passwordController.clear();
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Text(
                    //   'Enter Password'.tr,
                    //   style: TextStyle(
                    //     color: R.colors.grey.withOpacity(1),
                    //     fontSize: 14.sp,
                    //     fontWeight: FontWeight.w400,
                    //   ),
                    // ),
                    SizedBox(height: 15.h),
                    TextFormField(
                      controller: deleteAccountController.passwordController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        fillColor: R.colors.lightGrey,
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'Enter Password'.tr,
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
                      height: 30.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (deleteAccountController
                            .passwordController.text.isEmpty) {
                          Get.snackbar(
                            'Alert',
                            'Please Enter Password',
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: R.colors.themeColor,
                          );
                          return;
                        }

                        deleteAccountController.deleteAccount();
                        // Get.to(
                        //   () => DeleteAccount3(),
                        // );
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
                            'Confirm & Delete'.tr,
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
