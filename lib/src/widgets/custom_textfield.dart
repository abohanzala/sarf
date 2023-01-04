import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../resources/resources.dart';

Widget customTextField(
    {required String  hintText,
    required TextEditingController controller,
    TextStyle? hintStyle,
    required Color color,
    required String height,
    required Color borderColour,
    TextAlign? textAlign}) {
  return Container(
    height: 50,
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
        border: Border.all(color: borderColour)),
    child: TextField(
      textAlign: textAlign ?? TextAlign.center,
      controller: controller,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 15, right: 15),
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: hintText?.tr,
          hintStyle: hintStyle),
    ),
  );
}
