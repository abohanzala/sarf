import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sarf/controllers/members/members_controller.dart';
import 'package:sarf/model/members/city_list_model.dart';
import 'package:sarf/src/baseview/members/qr_code_scanner.dart';
import 'package:sarf/src/utils/routes_name.dart';

import '../../../resources/resources.dart';
import '../../widgets/custom_appbar.dart';

class CityListScreen extends StatefulWidget {
  const CityListScreen({super.key});

  @override
  State<CityListScreen> createState() => _CityListScreenState();
}

class _CityListScreenState extends State<CityListScreen> {
  MembersController ctr = Get.find<MembersController>();
  TextEditingController searchValue = TextEditingController();
  Timer? searchOnStoppedTyping;
  Future<CityList?>? cityList;
  String cityLenght = '';

  _onChangeHandler(value ) {
        const duration = Duration(milliseconds:1000); // set the duration that you want call search() after that.
        if (searchOnStoppedTyping != null) {
            setState(() => searchOnStoppedTyping?.cancel()); // clear timer
        }
        setState(() => searchOnStoppedTyping =  Timer(duration, () => search(value)));
    }

    search(value) {
      FocusScope.of(context).unfocus();
        //print('hello world from search . the value is $value');
        if(value.isEmpty){
          
            cityList = ctr.getCityList(ctr.selectExpanseTypeID, '');
            cityList?.then((value){
              setState(() {
                cityLenght = '(${value?.data?.length ?? 0})';
              });
            });
          
        }
        
          cityList = ctr.getCityList(ctr.selectExpanseTypeID, searchValue.text);
          cityList?.then((value){
              setState(() {
                cityLenght = '(${value?.data?.length ?? 0})';
              });
            });
        
        //print(ctr.mobile1.text);
        
    }
@override
void initState() {
    loadMembers();
    super.initState();
  }
@override
void dispose(){
  searchOnStoppedTyping?.cancel();
  super.dispose();
}  
loadMembers(){
  cityList = ctr.getCityList(ctr.selectExpanseTypeID, '');
  cityList?.then((value){
              setState(() {
                cityLenght = '(${value?.data?.length ?? 0})';
              });
            });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.lightGrey,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          customAppBar('Cites'.tr,true,true,cityLenght,false,(){}),
         // appbarSearch(),
         Transform(
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
                                  child:
                                  TextFormField(
                                    controller: searchValue,
                                    onChanged: _onChangeHandler,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(bottom: 5),
                                      hintText: 'Search here'.tr,
                                      hintStyle: TextStyle(color: R.colors.grey),
                                      focusedBorder: InputBorder.none,
                                      border: InputBorder.none,
                  
                                    ),
                                  ),
                                ),),
                                const SizedBox(width: 10,),
                                GestureDetector(
                                   onTap: (){
                                    Get.to(() => const QRScannerScreen(invoice: false,));
                                  },
                                  child: Container(
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
                                            Text('SCAN'.tr,style: TextStyle(color: R.colors.blue,
                                            //fontSize: 25.sp
                                            ),)
                                      ],
                                    ),),
                                  ),
                                )
                ],
              ),
            ),
          ),
        ),
         // const SizedBox(height: 10,),
          Expanded(child: 
          Transform(
            transform: Matrix4.translationValues(0, -15, 0),
            child: Column(
              children: [
                Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: budgetName(),
          ),
          const SizedBox(height: 10,),
                Expanded(
                  child: FutureBuilder<CityList?>(
                    future: cityList,
                    builder: (contaxt,snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(child:SizedBox(height: 100,width: 100,child: CircularProgressIndicator(color: R.colors.blue),));
                      }
                      if(snapshot.hasData){
                        
                        List<SingleCity?> data = snapshot.data!.data!.toList();
                        if(data.isNotEmpty){
                         return GridView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                              childAspectRatio: 1.8,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 10,
                              
                            ),
                            itemCount: data.length,
                             itemBuilder: (context,index){
                              var singleCity = data[index];
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: GestureDetector(
                                  onTap: (){
                                    ctr.selectCityID = singleCity.id.toString();
                                    Get.toNamed(RoutesName.membersList);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                    decoration: const BoxDecoration(
                                     // borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                     // border: Border(left: BorderSide(color: R.colors.lightBlue3,width: 5)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('City'.tr,style: TextStyle(color: R.colors.grey,fontSize: 12),),
                                        const SizedBox(height: 5,),
                                        Text("${GetStorage().read('lang') == 'en' ? singleCity?.name?.en ?? '' : singleCity?.name?.ar ?? ''} ",style: TextStyle(color: R.colors.black,fontSize: 16),),
                                        const SizedBox(height: 5,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.groups,color: R.colors.themeColor,),
                                                const SizedBox(width: 5,),
                                                Text(singleCity!.membersCount.toString(),style: TextStyle(color: R.colors.themeColor,fontSize: 14),),
                                                const SizedBox(width: 2,),
                                                Text('Members'.tr,style: TextStyle(color: R.colors.themeColor,fontSize: 14),),
                                              ],
                                            ),
                                            Icon(Icons.arrow_forward_ios,color: R.colors.black,size: 15,),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                      });
                        }
                      }
                      return Center(child:Text('No Data'.tr));
                    }),
                ),
              ],
            ),
          )
          
          
          
              
              ),
        ],
      ),
    );
  }

  
  
}

