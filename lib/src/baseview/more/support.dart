import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../resources/resources.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_textfield.dart';
import '../members/single_member_detail.dart';

class Support extends StatefulWidget {
  const Support({Key? key}) : super(key: key);

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  bool pending = true;
  bool success = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.lightGrey,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildBackGroundImage(),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget buildBackArrowAndSupportText() {
    return Positioned(
      top: 80,
      left: 30,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFFFFFFFF)),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(R.images.arrowBlue)),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              'Support',
              style: TextStyle(
                  color: R.colors.white, fontFamily: 'bold', fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAddNewButton() {
    return Positioned(
      top: 80,
      right: 30,
      child: Container(
        child: customButton(
          optionalNavigateIcon: false,
          margin: 0,
          width: MediaQuery.of(context).size.width / 3.5,
          titleTextAlign: TextAlign.center,
          title: 'Add New',
          color: R.colors.black,
          textColor: R.colors.white,
          height: 30,
          borderColour: R.colors.transparent,
          onPress: (() {
            Navigator.pop(context);
          }),
        ),
      ),
    );
  }

  Widget buildBackGroundImage() {
    return Container(
      height: MediaQuery.of(context).size.height / 3.5,
      child: Stack(alignment: Alignment.topLeft, children: [
        Image.asset(
          R.images.backgroundImageChangePassword,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 5,
          fit: BoxFit.cover,
        ),
        buildBackArrowAndSupportText(),
        buildAddNewButton(),
        buildStatusCard()
      ]),
    );
  }

  Widget buildStatusCard() {
    return Positioned(
      top: 130,
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15),
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: R.colors.white),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              buildPendingOption(),
              SizedBox(
                width: 10,
              ),
              buildSuccessOption()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPendingOption() {
    return Expanded(
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          pending = true;
          success = false;
          setState(() {});
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: pending ? R.colors.blue : Colors.transparent,
          ),
          height: 40,
          child: Center(
            child: Text(
              'Pending',
              style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'semibold',
                  color: pending ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSuccessOption() {
    return Expanded(
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          pending = false;
          success = true;
          setState(() {});
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: success ? R.colors.blue : Colors.transparent,
          ),
          height: 40,
          child: Center(
            child: Text(
              'Success',
              style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'semibold,',
                  color: success ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
