// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:memo_quran/resources/resources.dart';

// class AppDecoration {
//   InputDecoration fieldDecoration(
//       {required String hintText, Widget? suffixIcon}) {
//     return InputDecoration(
//       contentPadding: EdgeInsets. fromLTRB(12, 0, 12, 0),
//       isDense: true,
//       hintText:hintText,
//       hintStyle: R.textStyle
//           .courier()
//           .copyWith(fontSize: 11.sp, color: R.colors.textBlue),
//       suffixIcon: suffixIcon,
//       focusedBorder: OutlineInputBorder(
//         borderSide: BorderSide(
//           color: R.colors.themeColor,
//         ),
//         borderRadius: const BorderRadius.all(Radius.circular(20)),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderSide: BorderSide(
//           color: R.colors.transparent,
//         ),
//         borderRadius: const BorderRadius.all(Radius.circular(20)),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderSide: BorderSide(
//           color: R.colors.red,
//         ),
//         borderRadius: const BorderRadius.all(Radius.circular(20)),
//       ),
//       focusedErrorBorder: OutlineInputBorder(
//         borderSide: BorderSide(
//           color: R.colors.red,
//         ),
//         borderRadius: const BorderRadius.all(Radius.circular(20)),
//       ),
//     );
//   }
//   BoxDecoration defaultShadow({double? radius, Color? shadowColor}) {
//     return BoxDecoration(
//         color: R.colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: shadowColor ?? R.colors.shadowColor.withOpacity(.5),
//             spreadRadius: 1,
//             offset: const Offset(1, 1),
//             blurRadius: 10,
//           )
//         ],
//         borderRadius: BorderRadius.all(Radius.circular(radius ?? 20)));
//   }
//   InputDecoration dropDownDecoration({Color? fillColor, String? hintText}) {
//     return InputDecoration(
//       // contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: ),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
//       isDense: true,
//       fillColor: fillColor ?? R.colors.white,
//       filled: true,
//       focusColor: R.colors.themeColor,
//       hintText: hintText ?? "Select",

//       hintStyle: R.textStyle.courier().copyWith(
//         fontSize: 10.sp,
//         color: R.colors.themeColor,
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: R.colors.transparent),
//         borderRadius: BorderRadius.circular(18),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: R.colors.themeColor),
//         borderRadius: BorderRadius.circular(18),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: R.colors.red),
//         borderRadius: BorderRadius.circular(18),
//       ),
//       focusedErrorBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: R.colors.red),
//         borderRadius: BorderRadius.circular(18),
//       ),
//     );
//   }
// }
