import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sarf/resources/resources.dart';

class SimpleInvoice extends StatefulWidget {
  const SimpleInvoice({super.key});

  @override
  State<SimpleInvoice> createState() => _SimpleInvoiceState();
}

class _SimpleInvoiceState extends State<SimpleInvoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.lightGrey,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(left: 16.w, top: 20.h),
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
              child: Text(
                'Simple Invoice',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
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
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
              child: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.qr_code,
                          color: R.colors.blue,
                          size: 25.sp,
                        ),
                        fillColor: R.colors.lightGrey,
                        filled: true,
                        labelText: 'Mobile Number',
                        labelStyle: TextStyle(
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
                    Text(
                      'NAME',
                      style: TextStyle(
                        color: R.colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        fillColor: R.colors.lightGrey,
                        filled: true,
                        labelText: 'Amount',
                        labelStyle: TextStyle(
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
                    TextFormField(
                      maxLines: 7,
                      decoration: InputDecoration(
                        fillColor: R.colors.lightGrey,
                        filled: true,
                        labelText: 'Description',
                        labelStyle: TextStyle(
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
                    Flexible(
                      fit: FlexFit.loose,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 12.h),
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: R.colors.grey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.asset(
                                    'assets/images/attach.png',
                                    height: 25.h,
                                    width: 25.w,
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 12.h),
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: R.colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      Icons.qr_code_scanner_rounded,
                                      size: 28.sp,
                                      color: R.colors.white,
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Expanded(
                            flex: 9,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(3, (index) {
                                  return Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 10.w, top: 12.h, right: 5.w),
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: R.colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Image.asset(
                                          'assets/images/attach.png',
                                          height: 25.h,
                                          width: 25.w,
                                        ),
                                      ),
                                      Positioned(
                                        top: 3,
                                        right: 0,
                                        child: Container(
                                          height: 20.h,
                                          width: 20.w,
                                          padding: const EdgeInsets.all(5),
                                          decoration: const BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.close,
                                              size: 13.sp,
                                              color: R.colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                }),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: R.colors.themeColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'Send Invoice',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
