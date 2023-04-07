import 'dart:async';
import 'dart:io';
import 'package:document_scanner_flutter/configs/configs.dart';
import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:sarf/constant/api_links.dart';
import 'package:sarf/controllers/invoice/invoice_controller.dart';
import 'package:sarf/resources/resources.dart';
import 'package:sarf/src/baseview/members/qr_code_scanner.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:scan/scan.dart';

import '../../../controllers/viewers/viewers_controller.dart';
import '../../utils/navigation_observer.dart';
import '../../widgets/custom_appbar.dart';

class AddNewUserScreen extends StatefulWidget {
  const AddNewUserScreen({super.key});

  @override
  State<AddNewUserScreen> createState() => _AddNewUserScreenState();
}

class _AddNewUserScreenState extends State<AddNewUserScreen> with RouteAware  {

  ViewersController ctr = Get.find<ViewersController>();
  var registerFormKey = GlobalKey<FormState>();
  
  

  

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.lightGrey,
      body: Stack(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(left: GetStorage().read("lang") == 'en'?  16.w : 0, top: 20.h,right: GetStorage().read("lang") == 'en'? 0:16.w ),
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
              // borderRadius: BorderRadius.circular(10),
            ),
            child: Align(
              alignment: GetStorage().read('lang') == 'en' ? Alignment.centerLeft : Alignment.centerRight,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back() ,
                    child: Container(
                      height: 30,
                      width: 30,
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: R.colors.white,
                      ),
                      child: Icon(Icons.arrow_back_ios,color: R.colors.black,size: 20,),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Text(
                    'Add User'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: SingleChildScrollView(
              child: Column(
                children: [
                 
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
                    padding:  EdgeInsets.only(left: 12.w,right: 12.w,top: 15.h,bottom: 20),
                    child: Form(
                      key: registerFormKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                            // mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: budgetName(),
          ),
          const SizedBox(height: 10,),
                                // TextFormField(
                                //                     validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return "Required Field".tr;
                                //   }
                                //   return null;
                                // },
                                //   controller: ctr.name,                  
                                //   decoration: InputDecoration(
                                //     fillColor: R.colors.lightGrey,
                                //     filled: true,
                                //     labelText: 'Enter User Name'.tr,
                                //     labelStyle: TextStyle(
                                //       color: R.colors.grey,
                                //       fontSize: 14.sp,
                                //     ),
                                //     enabledBorder: OutlineInputBorder(
                                //       borderSide: BorderSide.none,
                                //       borderRadius: BorderRadius.circular(4),
                                //     ),
                                //     focusedBorder: OutlineInputBorder(
                                //       borderSide: BorderSide(
                                //         color: R.colors.grey,
                                //       ),
                                //       borderRadius: BorderRadius.circular(4),
                                //     ),
                                //   ),
                                // ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                IntlPhoneField(
            countries: ["SA"],
            // controller: ctr.phone,
            showDropdownIcon: false,
            flagsButtonPadding: EdgeInsets.only(left: 10),
            onChanged: (number) {
              ctr.phone.text = "966${number.number}";
              
            },
            invalidNumberMessage: 'Invalid mobile number'.tr,
            initialCountryCode: 'SA',
            onCountryChanged: (country) {},
            decoration: InputDecoration(
              border: InputBorder.none,
              // hintText: 'Enter Mobile Number'.tr,
              label: Container(
                margin: EdgeInsets.symmetric(horizontal: 0),
                child: Text('Enter Mobile Number'.tr,
                    style: TextStyle(
                        color: Color(0xFF707070),
                        fontFamily: 'regular',
                        fontSize: 12)),
              ),
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(5.0),
              // ),
              filled: true,
             fillColor: R.colors.lightGrey,
            ),
          ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                TextFormField(
                                   validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Required Field".tr;
                                      }
                                      return null;
                                    },
                                  // controller: ctr.note3,
                                  // maxLines: 7,
                                  controller: ctr.password,
                                  decoration: InputDecoration(
                                    fillColor: R.colors.lightGrey,
                                    filled: true,
                                    labelText: 'Password'.tr,
                                    labelStyle: TextStyle(
                                      color: R.colors.grey,
                                      fontSize: 14.sp,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: R.colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                                
                                                         
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          if (registerFormKey.currentState!.validate()) {
                                                  
                                                  ctr.postNewCustomInvoice(ctr.phone.text, ctr.password.text);
                                                  
                                                  }
                                                                                
                                        },
                                        child: Container(
                                          height: 50.h,
                                          decoration: BoxDecoration(
                                            color: R.colors.themeColor,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Save'.tr,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                      ],
                                    ),
                                
                             
                    )
                            ,
                          ),
                      
                      
        ]),
                  ),
                  
                 
      )],
              ),
            );
            
  }
}
