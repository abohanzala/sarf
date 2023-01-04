import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'resources.dart';

class AppTextStyle {
  TextStyle proBld({
    Color? color,
    double? fs,
    FontWeight? fw,
    double? letterSpacing,
    double? height,
  }) {
    return TextStyle(
      fontFamily: 'ProximaNovaExtrabold',
      fontSize: fs ?? 10.sp,
      color: color ?? R.colors.black,
      fontWeight: fw ?? FontWeight.w400,
      letterSpacing: letterSpacing ?? .8,
      height: height ?? 1,
    );
  }

  TextStyle courier({
    Color? color,
    double? fs,
    FontWeight? fw,
    double? letterSpacing,
    double? height,

  }) {
    return TextStyle(
      fontFamily: 'CourierNew',
      fontSize: fs ?? 10.sp,
      color: color ?? R.colors.black,
      fontWeight: fw ?? FontWeight.w400,
      letterSpacing: letterSpacing ?? .8,
      height: height ?? 1,

    );
  }


}
