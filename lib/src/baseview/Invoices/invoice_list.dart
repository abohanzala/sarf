import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../resources/resources.dart';

class InvoiceListScreen extends StatefulWidget {
  const InvoiceListScreen({super.key});

  @override
  State<InvoiceListScreen> createState() => _InvoiceListScreenState();
}

class _InvoiceListScreenState extends State<InvoiceListScreen> {
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
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        'Invoice List',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        '(23)',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.bottomSheet(InvoiceBottomSheet());
                        },
                        child: Image.asset(
                          'assets/images/data.png',
                          scale: 3,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Transform(
            transform: Matrix4.translationValues(0, -40.h, 0),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: R.colors.blueGradient1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: R.colors.blueGradient1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Search Here',
                    hintStyle: TextStyle(
                      color: R.colors.grey,
                      fontSize: 16.sp,
                    ),
                    fillColor: const Color(0xffEAF8FF),
                    filled: true,
                    border: InputBorder.none,
                  ),
                )),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Transform(
              transform: Matrix4.translationValues(0, -25.h, 0),
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(8, (index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.only(
                          left: 20.w, right: 20.w, bottom: 20.h),
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Invoice ID',
                                  style: TextStyle(
                                    color: R.colors.grey,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  ' ${DateFormat('dd-MM-yyyy').format(DateTime.now())}',
                                  style: TextStyle(
                                    color: R.colors.grey,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              '21',
                              style: TextStyle(
                                color: R.colors.black,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text('Customer Name',
                                style: TextStyle(
                                  color: R.colors.grey,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                )),
                            SizedBox(height: 5.h),
                            Text(
                              'John Doe',
                              style: TextStyle(
                                color: R.colors.black,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10.w),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: R.colors.lightGrey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Amount : 0000',
                                    style: TextStyle(
                                      color: R.colors.blueGradient1,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class InvoiceBottomSheet extends StatefulWidget {
  const InvoiceBottomSheet({super.key});

  @override
  State<InvoiceBottomSheet> createState() => _InvoiceBottomSheetState();
}

class _InvoiceBottomSheetState extends State<InvoiceBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.only(
                top: 5.h,
              ),
              height: 7.h,
              width: 50.w,
              decoration: BoxDecoration(
                color: R.colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: ListView.builder(itemBuilder: ((context, index) {
              return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Type 1',
                        style: TextStyle(
                          color: R.colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Divider(
                        color: R.colors.grey,
                        thickness: 1,
                      )
                    ],
                  ));
            })),
          ),
        ],
      ),
    );
  }
}
