import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../resources/resources.dart';
import '../utils/routes_name.dart';

Widget customTextField(
    {required String hintText,
    required TextEditingController controller,
    TextStyle? hintStyle,
    required Color color,
    required double height,
    double? hintTextSize,
    Icon? hysterik,
    required Color borderColour,
    TextAlign? textAlign}) {
  return Container(
    height: height,
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
        border: Border.all(color: borderColour)),
    child: Row(
      children: [
        Flexible(
          child: TextField(
            textAlign: textAlign ?? TextAlign.start,
            controller: controller,
            decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: hintTextSize),
              contentPadding: const EdgeInsets.only(left: 15, right: 15),
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: hintText.tr,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget customTitle({
  required String text,
  required Color color,
  required double size,
  fontFamily,
  required TextAlign textAlign,
}) {
  return Text(
    textAlign: textAlign,
    text,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontFamily: fontFamily,
    ),
  );
}

Widget customButton({
  required String title,
  required Color color,
  required Color textColor,
  required double height,
  required Color borderColour,
}) {
  return Container(
    margin: EdgeInsets.only(left: 15, right: 15, top: 20),
    height: height,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),
    child: InkWell(
      onTap: () {},
      child: Center(
        child: Text(
          title,
          style:
              TextStyle(color: textColor, fontSize: 13, fontFamily: 'medium'),
        ),
      ),
    ),
  );
}
