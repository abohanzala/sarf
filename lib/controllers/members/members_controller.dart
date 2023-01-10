import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sarf/model/members/city_list_model.dart';

import '../../constant/api_links.dart';
import '../../model/members/members_list_model.dart';
import '../../resources/resources.dart';
import '../../services/app_exceptions.dart';
import '../../services/dio_client.dart';

class MembersController extends GetxController{

@override
void onInit(){
  //getMembersList();
  super.onInit();


}

  Future<MembersList?> getMembersList() async {
    //print("${ApiLinks.membersList}${GetStorage().read('lang')}");
   // openLoader();
    var response =
        await DioClient().get("${ApiLinks.membersList}${GetStorage().read('lang')}").catchError((error) {
      if (error is BadRequestException) {
        
        
       // print(error.toString());
      } else {

        //print(error.toString());
        
    if (error is BadRequestException) {
     // print(error.toString());
      
    } else if (error is FetchDataException) {
     // print(error.toString());
      
    } else if (error is ApiNotRespondingException) {
      //print(error.message.toString());
    }

      }
    }); 
    if (response['success'] == true) {
     
      debugPrint(response.toString());
        var membersList = MembersList.fromJson(response);
        //print(membersList.data?.first.expenseName);
        return membersList;
    } else {
      debugPrint('here');
    }
    return null;
  }

  Future<CityList?> getCityList() async {
   // print("${ApiLinks.cityList}${GetStorage().read('lang')}");
   // openLoader();
    var response =
        await DioClient().get("${ApiLinks.cityList}${GetStorage().read('lang')}").catchError((error) {
      if (error is BadRequestException) {
        
        
        debugPrint(error.toString());
      } else {

        debugPrint(error.toString());
        
    if (error is BadRequestException) {
      debugPrint(error.toString());
      
    } else if (error is FetchDataException) {
      debugPrint(error.toString());
      
    } else if (error is ApiNotRespondingException) {
      debugPrint(error.message.toString());
    }

      }
    }); 
    if (response['success'] == true) {
     
      debugPrint(response.toString());
        var cityList = CityList.fromJson(response);
        //print(membersList.data?.first.expenseName);
        return cityList;
    } else {
      debugPrint('here');
    }
    return null;
  }



}


