import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../resources/resources.dart';


Container customAppBar(String title,bool back,bool braket,String? braketText) {

    return Container(
          padding: EdgeInsets.only(left: 16.w, top: 20.h),
          height: 100,
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
            //borderRadius: BorderRadius.circular(10),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                if(back) ...[
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
                ],
                
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if(braket) ...[
                  const SizedBox(width: 5,),
                  Text(braketText!,style:TextStyle(
                    color: R.colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),)
                ],
              ],
            ),
          ),
        );
  }

  Transform appbarSearch() {
    return Transform(
          transform: Matrix4.translationValues(0, -20, 0),
          child: Container(
            //margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: Container(
                                  height: 40,
                                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 0),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: R.colors.lightBlue2,
                                  border: Border.all(color: R.colors.lightBlue,width: 1) ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(bottom: 5),
                                      hintText: 'Search here',
                                      hintStyle: TextStyle(color: R.colors.grey),
                                      focusedBorder: InputBorder.none,
                                      border: InputBorder.none,
                  
                                    ),
                                  ),
                                ),),
                                const SizedBox(width: 10,),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: R.colors.lightBlue2,border: Border.all(color: R.colors.lightBlue,width: 1)),
                                  child: Center(child: Row(
                                    children: [
                                          Icon(
                                            Icons.qr_code,
                                            color: R.colors.blue,
                                            //size: 25.sp,
                                          ),
                                          const SizedBox(width: 5,),
                                          Text('SCAN',style: TextStyle(color: R.colors.blue,
                                          //fontSize: 25.sp
                                          ),)
                                    ],
                                  ),),
                                )
                ],
              ),
            ),
          ),
        );
  }