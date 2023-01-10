import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sarf/resources/images.dart';
import 'package:sarf/src/Auth/registration.dart';
import 'package:sarf/src/utils/routes_name.dart';
import 'package:sarf/src/widgets/custom_textfield.dart';

import '../../resources/resources.dart';

class RegistrationDetails extends StatefulWidget {
  const RegistrationDetails({Key? key}) : super(key: key);

  @override
  State<RegistrationDetails> createState() => _RegistrationDetailsState();
}

class _RegistrationDetailsState extends State<RegistrationDetails> {
  TextEditingController companyNameController = TextEditingController();
  FocusNode searchFieldNode = FocusNode();
  bool business = true;
  bool personal = false;
  bool onlineBusiness = true;
  bool offlineBusiness = false;
  bool checkBox = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
            backgroundColor: const Color(0xFFF2F2F9),
            body: Stack(
              children: [
                buildBackGroundImage(),
                buildBackArrowContainer(),
              ],
            ),
          ),
          buildRegistrationDetailsCard()
        ],
      ),
    );
  }

  buildBackGroundImage() {
    return Image.asset(
      'assets/images/backgroundImage.png',
      width: MediaQuery.of(context).size.width,
    );
  }

  buildBackArrowContainer() {
    return Positioned(
      top: 50,
      left: 30,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Color(0xFFFFFFFF)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/arrow.png'),
          ),
        ),
      ),
    );
  }

  buildRegistrationDetailsCard() {
    return Positioned(
      top: 230,
      child: Container(
        height: MediaQuery.of(context).size.height - 250,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: SingleChildScrollView(
          child: Column(
            children: [buildRegistrationDetailsText(), buildForm()],
          ),
        ),
      ),
    );
  }

  Widget buildRegistrationDetailsText() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Center(
        child: Text(
          'Registration Details'.tr,
          style:
              TextStyle(color: R.colors.grey, fontFamily: 'bold', fontSize: 18),
        ),
      ),
    );
  }

  Widget buildForm() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: Column(
        children: [
          buildUserTypeText(),
          buildUserTypeOptions(),
          buildPasswordField(),
          business ? buildCompanyNameField() : buildFullNameField(),
          buildSelectCityDropDown(),
          business ? buildTypeDropDown() : Container(),
          business ? buildInstagramField() : Container(),
          business ? buildTwitterField() : Container(),
          business ? buildContactNoField() : Container(),
          business ? buildWhatsappField() : Container(),
          business ? buildBusinessTypeText() : Container(),
          business ? buildBusinessTypeOptions() : Container(),
          business ? buildWebsiteField() : Container(),
          offlineBusiness ? buildLocationButton() : Container(),
          business ? buildUploadImage() : Container(),
          buildAgreeToTermsAndConditionsBox(),
          buildSubmitButton()
        ],
      ),
    );
  }

  buildAgreeToTermsAndConditionsBox() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Row(
        children: <Widget>[
          Checkbox(
            checkColor: Colors.white,
            activeColor: Color(0xFF2C313E),
            value: this.checkBox,
            onChanged: (bool? value) {
              setState(() {
                this.checkBox = value!;
              });
            },
          ),
          Text(
            'I Accept'.tr,
            style: TextStyle(fontSize: 17, color: Colors.grey),
          ),
          InkWell(
            onTap: () {},
            child: Text(
              ' Terms & Conditions'.tr,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 17,
              ),
            ),
          ),
        ], //<Widget>[]
      ),
    );
  }

  Widget buildPasswordField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Color(0xFFEAEEF2)),
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.only(left: 20, right: 10, top: 3),
              child: Image.asset('assets/images/passwordIcon.png',
                  height: 15, color: Color(0xFF9A9A9A).withOpacity(0.8))),
          Expanded(
            child: TextField(
              focusNode: searchFieldNode,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: 'Enter Password'.tr,
                  hintStyle: TextStyle(
                      fontSize: 10,
                      fontFamily: 'medium',
                      color: Color(0xFF9A9A9A).withOpacity(0.8)),
                  border: InputBorder.none),
            ),
          )
        ],
      ),
    );
  }

  Widget buildUploadImage() {
    return InkWell(
      onTap: () {
        openPopUpOptions('In Process Development'.tr);
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  100,
                ),
                color: R.colors.grey),
            child: Center(
              child: Text(
                'Upload Image'.tr,
                style: TextStyle(
                    fontFamily: 'regular', color: Colors.white, fontSize: 10),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              '(Optional)'.tr,
              style: TextStyle(
                  fontFamily: 'regular', color: Colors.grey, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSubmitButton() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xFFFB7B57),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          //  Get.toNamed(RoutesName.RegistrationDetails);
        },
        child: Center(
          child: Text(
            'Submit'.tr,
            style: TextStyle(
                color: Colors.white, fontSize: 13, fontFamily: 'medium'),
          ),
        ),
      ),
    );
  }

  Widget buildUserTypeText() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Text(
            'User Type'.tr,
            style: TextStyle(
                color: R.colors.grey, fontSize: 12, fontFamily: 'medium'),
          )
        ],
      ),
    );
  }

  Widget buildBusinessText() {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Text(
            'Business'.tr,
            style: TextStyle(
                color: R.colors.grey, fontSize: 12, fontFamily: 'medium'),
          )
        ],
      ),
    );
  }

  Widget buildOnlineBusinessText() {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Text(
            'Online'.tr,
            style: TextStyle(
                color: R.colors.grey, fontSize: 12, fontFamily: 'medium'),
          )
        ],
      ),
    );
  }

  Widget buildOfflineBusinessText() {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Text(
            'Offline'.tr,
            style: TextStyle(
                color: R.colors.grey, fontSize: 12, fontFamily: 'medium'),
          )
        ],
      ),
    );
  }

  Widget buildBusinessTypeOptions() {
    return Container(
      margin: EdgeInsets.only(
        top: 12,
      ),
      child: Row(
        children: [buildOnlineBusinessButton(), buildOfflineBusinessButton()],
      ),
    );
  }

  Widget buildOnlineBusinessButton() {
    return InkWell(
      onTap: () {
        onlineBusiness = true;
        offlineBusiness = false;
        setState(() {});
      },
      child: Container(
        //   margin: EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Container(
                decoration: BoxDecoration(
                    border: Border.all(color: R.colors.black),
                    borderRadius: BorderRadius.circular(100),
                    color: R.colors.transparent),
                height: 20,
                width: 20,
                child: onlineBusiness
                    ? Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: R.colors.black),
                        ),
                      )
                    : Container()),
            buildOnlineBusinessText(),
          ],
        ),
      ),
    );
  }

  Widget buildOfflineBusinessButton() {
    return InkWell(
      onTap: () {
        onlineBusiness = false;
        offlineBusiness = true;
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.only(left: 20),
        child: Row(
          children: [
            Container(
                decoration: BoxDecoration(
                    border: Border.all(color: R.colors.black),
                    borderRadius: BorderRadius.circular(100),
                    color: R.colors.transparent),
                height: 20,
                width: 20,
                child: offlineBusiness
                    ? Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: R.colors.black),
                        ),
                      )
                    : Container()),
            buildOfflineBusinessText(),
          ],
        ),
      ),
    );
  }

  Widget buildUserTypeOptions() {
    return Container(
      margin: EdgeInsets.only(
        top: 12,
      ),
      child: Row(
        children: [buildBusinessButton(), buildPersonalButton()],
      ),
    );
  }

  Widget buildBusinessButton() {
    return InkWell(
      onTap: () {
        business = true;
        personal = false;
        setState(() {});
      },
      child: Container(
        //   margin: EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Container(
                decoration: BoxDecoration(
                    border: Border.all(color: R.colors.black),
                    borderRadius: BorderRadius.circular(100),
                    color: R.colors.transparent),
                height: 20,
                width: 20,
                child: business
                    ? Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: R.colors.black),
                        ),
                      )
                    : Container()),
            buildBusinessText(),
          ],
        ),
      ),
    );
  }

  Widget buildPersonalText() {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Text(
        'Personal'.tr,
        style: TextStyle(
            fontSize: 14, fontFamily: 'regular', color: Color(0xFF9A9A9A)),
      ),
    );
  }

  Widget buildBusinessTypeText() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Text(
            'Business'.tr,
            style: TextStyle(
                fontSize: 14, fontFamily: 'regular', color: Color(0xFF9A9A9A)),
          ),
        ],
      ),
    );
  }

  Widget buildPersonalButton() {
    return InkWell(
      onTap: () {
        business = false;
        personal = true;
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.only(left: 20),
        child: Row(
          children: [
            Container(
                decoration: BoxDecoration(
                    border: Border.all(color: R.colors.black),
                    borderRadius: BorderRadius.circular(100),
                    color: R.colors.transparent),
                height: 20,
                width: 20,
                child: personal
                    ? Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: R.colors.black),
                        ),
                      )
                    : Container()),
            buildPersonalText(),
          ],
        ),
      ),
    );
  }

  Widget buildCompanyNameField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: customTextField(
          makeCompulsoryField: true,
          hintTextSize: 12,
          hintText: 'Company Name'.tr,
          controller: companyNameController,
          color: R.colors.lightGrey,
          height: 45,
          borderColour: R.colors.transparent),
    );
  }

  Widget buildFullNameField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: customTextField(
          hintTextSize: 12,
          hintText: 'Full Name'.tr,
          controller: companyNameController,
          color: R.colors.lightGrey,
          height: 45,
          borderColour: R.colors.transparent),
    );
  }

  Widget buildInstagramField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: customTextField(
          hintTextSize: 12,
          hintText: 'Instagram Link (Optional)'.tr,
          controller: companyNameController,
          color: R.colors.lightGrey,
          height: 45,
          borderColour: R.colors.transparent),
    );
  }

  Widget buildWebsiteField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: customTextField(
          hintTextSize: 12,
          hintText: 'Website (Optional)'.tr,
          controller: companyNameController,
          color: R.colors.lightGrey,
          height: 45,
          borderColour: R.colors.transparent),
    );
  }

  Widget buildContactNoField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: customTextField(
          hintTextSize: 12,
          hintText: 'Contact No (Optional)',
          controller: companyNameController,
          color: R.colors.lightGrey,
          height: 45,
          borderColour: R.colors.transparent),
    );
  }

  Widget buildWhatsappField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: customTextField(
          hintTextSize: 12,
          hintText: 'Whatsapp (Optional)',
          controller: companyNameController,
          color: R.colors.lightGrey,
          height: 45,
          borderColour: R.colors.transparent),
    );
  }

  Widget buildTwitterField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: customTextField(
          hintTextSize: 12,
          hintText: 'Twitter Link (Optional)'.tr,
          controller: companyNameController,
          color: R.colors.lightGrey,
          height: 45,
          borderColour: R.colors.transparent),
    );
  }

  void openPopUpOptions(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Material(
          type: MaterialType.transparency,
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.pop(context);
            },
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          message,
                          style: TextStyle(
                              fontFamily: 'regular', color: R.colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildSelectCityDropDown() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 45,
      decoration: BoxDecoration(
        color: R.colors.lightGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          openPopUpOptions('No Cities Available');
        },
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                'Select City'.tr,
                style: TextStyle(
                    fontSize: 12, fontFamily: 'medium', color: R.colors.grey),
              )),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTypeDropDown() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 45,
      decoration: BoxDecoration(
        color: R.colors.lightGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          openPopUpOptions('No Types Available');
        },
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                'Type'.tr,
                style: TextStyle(
                    fontSize: 12, fontFamily: 'medium', color: R.colors.grey),
              )),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLocationButton() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      height: 50,
      decoration: BoxDecoration(
        color: R.colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          //   Get.toNamed(RoutesName.RegistrationDetails);
        },
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.pin_drop,
                  size: 20,
                  color: Colors.white,
                )),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                'Location'.tr,
                style: TextStyle(
                    color: Colors.white, fontSize: 13, fontFamily: 'medium'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
