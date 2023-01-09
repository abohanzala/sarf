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
    bool? hysterik,
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

Container customButton({
  bool? optionalNavigateIcon,
  required double margin,
  required double width,
  required String title,
  required Color color,
  required Color textColor,
  required double height,
  required Color borderColour,
  required Function()? onPress,
  required TextAlign? titleTextAlign,
}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),
    child: InkWell(
      onTap: onPress,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: margin),
              child: Text(
                textAlign: titleTextAlign,
                title,
                style: TextStyle(
                    color: textColor, fontSize: 13, fontFamily: 'medium'),
              ),
            ),
          ),
          optionalNavigateIcon == true
              ? Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                    color: R.colors.white,
                  ),
                )
              : Container()
        ],
      ),
    ),
  );
}
