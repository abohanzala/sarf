import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../resources/resources.dart';


openLoader(){
  Get.dialog(
    Center(
    child: SizedBox(
      width: 50,
      height: 50,
      child: CircularProgressIndicator(
        //backgroundColor: AppColors.whiteClr,
        color: R.colors.blue,
      ),
    ),
  ),barrierDismissible: false);
}