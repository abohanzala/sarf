import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sarf/src/Auth/LoginScreen.dart';

import '../../../resources/resources.dart';

class DeleteAccount3 extends StatefulWidget {
  const DeleteAccount3({super.key});

  @override
  State<DeleteAccount3> createState() => _DeleteAccount3State();
}

class _DeleteAccount3State extends State<DeleteAccount3> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: R.colors.transparent,
        body: Container(
          height: double.infinity,
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
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 300.h,
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                padding: EdgeInsets.symmetric(vertical: 20.h),
                decoration: BoxDecoration(
                  color: R.colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        width: double.infinity,
                        color: R.colors.lightGrey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/infopic.png',
                              scale: 3,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'Account Delete'.tr,
                              style: TextStyle(
                                color: R.colors.black,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              'Your account has been deleted successfully'.tr,
                              style: TextStyle(
                                color: R.colors.black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.offAll(LoginScreen());
                      },
                      child: Container(
                        height: 40.h,
                        margin: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: R.colors.themeColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Go to Login'.tr,
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
                ),
              ),
            ],
          ),
        ));
  }
}
