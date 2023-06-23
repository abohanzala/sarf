import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart' as get_storage;
import 'package:sarf/controllers/auth/data_collection_controller.dart';
import 'package:sarf/controllers/invoice/invoice_controller.dart';
import 'package:sarf/model/members/invoice_list_model.dart';
import 'package:sarf/src/widgets/loader.dart';

import '../../../resources/resources.dart';
import '../../utils/navigation_observer.dart';
import '../../widgets/custom_appbar.dart';
import 'invoice_details.dart';

class InvoiceListScreen extends StatefulWidget {
  final String memberId;
  const InvoiceListScreen({super.key, required this.memberId});

  @override
  State<InvoiceListScreen> createState() => _InvoiceListScreenState();
}

class _InvoiceListScreenState extends State<InvoiceListScreen>  with RouteAware {
  InvoiceController ctr = Get.find<InvoiceController>();
  TextEditingController searchValue = TextEditingController();
  Timer? searchOnStoppedTyping;
  Future<InvoiceList?>? membersList;
  String membersLenght = '';
  bool isSearch = false;

  _onChangeHandler(value ) {
        const duration = Duration(milliseconds:1000); // set the duration that you want call search() after that.
        if (searchOnStoppedTyping != null) {
            setState(() => searchOnStoppedTyping?.cancel()); // clear timer
        }
        setState(() => searchOnStoppedTyping =  Timer(duration, () => search(value)));
    }

    search(value) {
      // setState(() {
      //    membersLenght = '(0)';
      // });
      FocusScope.of(context).unfocus();
        //print('hello world from search . the value is $value');
        if(value.isEmpty){
          
            membersList = ctr.getInvoiceListMember('',widget.memberId);
            membersList?.then((value){
              setState(() {
                membersLenght = '(${value?.data?.length ?? 0})';
              });
                  
                });
          
        }

        
            membersList = ctr.getInvoiceListMember(searchValue.text,widget.memberId);
            membersList?.then((value){
              setState(() {
                membersLenght = '(${value?.data?.length ?? 0})';
              });
                
              });
          
        //print(ctr.mobile1.text);
        
    }
@override
void initState() {
   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    Helper.routeObserver.subscribe(this, ModalRoute.of(context)!);
  });
    loadMembers();
    super.initState();
  }
  @override
void dispose(){
  searchOnStoppedTyping?.cancel();
  super.dispose();
}  
loadMembers(){
  membersList = ctr.getInvoiceListMember('',widget.memberId);
  membersList?.then((value){
    if(mounted){
       setState(() {
      membersLenght = '(${value?.data?.length ?? 0})';
    });
    }
   
    
  });
}

 @override
  void didPopNext() {
    if(mounted){
      setState(() {
      isSearch = true;
    });
    }
    
    
    
    super.didPopNext();

    loadMembers();
    if(mounted){
       Future.delayed(Duration(seconds: 2),(){
      setState(() {
        isSearch = false;
      });
    });
    }
   

     
  }
  @override
  Widget build(BuildContext context) {
    //  print(get_storage.GetStorage().read("user_token"));
    return Scaffold(
      backgroundColor: R.colors.lightGrey,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(left: 16.w, top: 20.h, right: 16.w),
            height: 120.h,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  R.colors.blueGradient1,
                  R.colors.blueGradient2,
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(9),
                          height: 25.h,
                          width: 25.w,
                          decoration: BoxDecoration(
                            color: R.colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 15.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Row(
                        children: [
                          Text(
                            'Invoice List'.tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5,),
                          Text(
                            membersLenght,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 2.w),
                      // Text(
                      //   '(23)',
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 16.sp,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.bottomSheet(InvoiceBottomSheet()).then((value){
                            if(ctr.filter != 0){
                              setState(() {
                                membersList = ctr.getInvoiceListMember('',widget.memberId);
                              });
                            }
                          });
                        },
                        child: Image.asset(
                          'assets/images/data.png',
                          scale: 3,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Transform(
            transform: Matrix4.translationValues(0, -40.h, 0),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: TextFormField(
                   onTap: (){
                                      searchValue.selection = TextSelection.collapsed(offset: searchValue.text.length);
                                    },
                  controller: searchValue,
                  onChanged: _onChangeHandler,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: R.colors.blueGradient1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: R.colors.blueGradient1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Search here'.tr,
                    hintStyle: TextStyle(
                      color: R.colors.grey,
                      fontSize: 16.sp,
                    ),
                    fillColor: const Color(0xffEAF8FF),
                    filled: true,
                    border: InputBorder.none,
                  ),
                )),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Transform(
              transform: Matrix4.translationValues(0, -50.h, 0),
              child:  SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: budgetName(),
          ),
          const SizedBox(height: 10,),
                      if(isSearch)
                      Center(child: SizedBox(
                        height: 100,
                        width: 100,
                        child: CircularProgressIndicator(color: R.colors.blue,)),),
                      if(!isSearch)
                      FutureBuilder<InvoiceList?>(
                              future: membersList,
                              builder: (contaxt,snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child:SizedBox(height: 100,width: 100,child: CircularProgressIndicator(color: R.colors.blue),));
                }
                if(snapshot.hasData){
                      //ctr.filter != ''
                      List<Data?> data = [];
                      if(ctr.filter != 0){
                        data = snapshot.data!.data!.where((element) => element.expenseTypeId == ctr.filter).toList();
                      }else{
                        data = snapshot.data!.data!;
                      }
                       
                      if(data.isNotEmpty){
    
                       return ListView.builder(
                         shrinkWrap: true,
                      // reverse: true,
                      itemCount: data.length,
                      primary: false,
                        itemBuilder: (context,index){
                            var singleData = data[index];
                            var id = (data.length - 1 ) - index;
                            return GestureDetector(
                              onTap: (){
                                Get.to(() => InvoiceDetails(id: singleData!.id.toString(),invoiceNum: "${id + 1}",reverse: true,) );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: EdgeInsets.only(
                                    left: 20.w, right: 20.w, bottom: 20.h),
                                child: Container(
                                  padding: EdgeInsets.all(16.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              if(singleData?.viewed == 0 ) ...[
                                            Container(
                                                    width: 10,
                                                    height: 10,
                                                    decoration: const BoxDecoration(
                                                      color: Colors.red,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10,),
                                          ],
                                          Text(
                                            'Invoice ID'.tr,
                                            style: TextStyle(
                                              color: R.colors.grey,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                            ],
                                          ),
                                          
                                          Text(
                                            singleData?.createdDate ?? '',
                                            style: TextStyle(
                                              color: R.colors.grey,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        "${id + 1}"
                                        //  singleData!.id.toString()
                                        // "${index + 1}"
                                        ,
                                        style: TextStyle(
                                          color: R.colors.black,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      Text('Customer Name'.tr,
                                          style: TextStyle(
                                            color: R.colors.grey,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          )),
                                      SizedBox(height: 5.h),
                                      Text(
                                        singleData?.customer?.name ?? '',
                                        style: TextStyle(
                                          color: R.colors.black,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      
                                       SizedBox(height: 8.h),
                                      Text('Receiver Name'.tr,
                                          style: TextStyle(
                                            color: R.colors.grey,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          )),
                                      SizedBox(height: 5.h),
                                      Text(
                                        singleData?.user?.name ?? '',
                                        style: TextStyle(
                                          color: R.colors.black,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical: 10.w),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: R.colors.lightGrey,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              '${"Amount".tr} ${singleData?.amount}',
                                              style: TextStyle(
                                                color: R.colors.blueGradient1,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                      }
                }
                return  Center(child:Text('No Data'.tr));
                              }),
                    ],
                  ),
                  // child:  Column(
                  //     children: List.generate(8, (index) {
                  //       return Container(
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(10),
                  //         ),
                  //         margin: EdgeInsets.only(
                  //             left: 20.w, right: 20.w, bottom: 20.h),
                  //         child: Container(
                  //           padding: EdgeInsets.all(16.w),
                  //           decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             children: [
                  //               Row(
                  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                 children: [
                  //                   Text(
                  //                     'Invoice ID'.tr,
                  //                     style: TextStyle(
                  //                       color: R.colors.grey,
                  //                       fontSize: 16.sp,
                  //                       fontWeight: FontWeight.w600,
                  //                     ),
                  //                   ),
                  //                   Text(
                  //                     ' ${DateFormat('dd-MM-yyyy').format(DateTime.now())}',
                  //                     style: TextStyle(
                  //                       color: R.colors.grey,
                  //                       fontSize: 16.sp,
                  //                       fontWeight: FontWeight.w600,
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //               SizedBox(height: 5.h),
                  //               Text(
                  //                 '21',
                  //                 style: TextStyle(
                  //                   color: R.colors.black,
                  //                   fontSize: 18.sp,
                  //                   fontWeight: FontWeight.w600,
                  //                 ),
                  //               ),
                  //               SizedBox(height: 8.h),
                  //               Text('Customer Name'.tr,
                  //                   style: TextStyle(
                  //                     color: R.colors.grey,
                  //                     fontSize: 16.sp,
                  //                     fontWeight: FontWeight.w600,
                  //                   )),
                  //               SizedBox(height: 5.h),
                  //               Text(
                  //                 'John Doe',
                  //                 style: TextStyle(
                  //                   color: R.colors.black,
                  //                   fontSize: 18.sp,
                  //                   fontWeight: FontWeight.w600,
                  //                 ),
                  //               ),
                  //               SizedBox(height: 10.h),
                  //               Container(
                  //                 padding: EdgeInsets.symmetric(vertical: 10.w),
                  //                 width: double.infinity,
                  //                 decoration: BoxDecoration(
                  //                   color: R.colors.lightGrey,
                  //                   borderRadius: BorderRadius.circular(10),
                  //                 ),
                  //                 child: Align(
                  //                     alignment: Alignment.center,
                  //                     child: Text(
                  //                       'Amount'.tr,
                  //                       style: TextStyle(
                  //                         color: R.colors.blueGradient1,
                  //                         fontSize: 16.sp,
                  //                         fontWeight: FontWeight.bold,
                  //                       ),
                  //                     )),
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //       );
                  //     }),
                  //   ),
                  
                ),
              
            ),
          )
        ],
      ),
    );
  }
}

class InvoiceBottomSheet extends StatefulWidget {
  const InvoiceBottomSheet({super.key});

  @override
  State<InvoiceBottomSheet> createState() => _InvoiceBottomSheetState();
}

class _InvoiceBottomSheetState extends State<InvoiceBottomSheet> {
  InvoiceController ctr = Get.find<InvoiceController>();
  DataCollectionController dataCtr = Get.find<DataCollectionController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.only(
                top: 5.h,
              ),
              height: 7.h,
              width: 50.w,
              decoration: BoxDecoration(
                color: R.colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: ListView.builder(
              itemCount: dataCtr.types?.length,
              shrinkWrap: true,
              itemBuilder: ((context, index) {
                var singleData = dataCtr.types?[index];
              return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: (){
                           ctr.filter = singleData!.id!;
                           Get.back();
                        },
                        child: Text(
                          get_storage.GetStorage().read("lang") == "en" ? singleData?.expenseName ?? "" : singleData?.expenseNameAr ?? "" ,
                          style: TextStyle(
                            color: R.colors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Divider(
                        color: R.colors.grey,
                        thickness: 1,
                      )
                    ],
                  ));
            })),
          ),
        ],
      ),
    );
  }
}
