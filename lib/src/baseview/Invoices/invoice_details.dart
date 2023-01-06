import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../resources/resources.dart';
import '../../utils/routes_name.dart';
import '../../widgets/custom_appbar.dart';

class InvoiceDetails extends StatefulWidget {
  const InvoiceDetails({super.key});

  @override
  State<InvoiceDetails> createState() => _InvoiceDetailsState();
}

class _InvoiceDetailsState extends State<InvoiceDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.lightGrey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          customAppBar('Invoice',true,false,'',true),
          //appbarSearch(),
          //const SizedBox(height: 10,),
         Transform(
          transform: Matrix4.translationValues(0, -10, 0),
           child: Container(
                  width: Get.width,
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: R.colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Invoice No',style: TextStyle(color: R.colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                          Text('12-04-2021',style: TextStyle(color: R.colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                        ],
                      ),
                      const SizedBox(height: 5,),
                      Text('00',style: TextStyle(color: R.colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                      const SizedBox(height: 10,),
                      Text('Customer Name',style: TextStyle(color: R.colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                       const SizedBox(height: 5,),
                      Text('Zeeshan',style: TextStyle(color: R.colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                      const SizedBox(height: 10,),
                      Text('Description',style: TextStyle(color: R.colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                       const SizedBox(height: 5,),
                      Text('Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Ut arcu libero, pulvinar non massa sed.',style: TextStyle(color: R.colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                      const SizedBox(height: 10,),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: R.colors.lightGrey,
                           ),
                           child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Net Total',style: TextStyle(color: R.colors.themeColor,fontSize: 14,fontWeight: FontWeight.w500),),
                              Text('\$0.00',style: TextStyle(color: R.colors.themeColor,fontSize: 14,fontWeight: FontWeight.w500),),
                            ],
                           ),
                      ),
                    ],
                  ),
                ),
         ),
         const SizedBox(height: 10,),
         Expanded(child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
           padding: const EdgeInsets.symmetric(horizontal: 12),
           child: Text('Received Attachments',style: TextStyle(color: R.colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
         ),
         const SizedBox(height: 8,),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 12),
           child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: R.colors.grey
               ),
           ),
         ),
         const SizedBox(height: 10,), 
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 12),
           child: Divider(
            color: R.colors.lightBlue4,
            thickness: 0.1,
           ),
         ),
         const SizedBox(height: 10,), 
          Padding(
           padding: const EdgeInsets.symmetric(horizontal: 12),
           child: Text('Sent Attachments',style: TextStyle(color: R.colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
         ),
         const SizedBox(height: 8,),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 12),
           child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: R.colors.grey
               ),
           ),
         ),
         const SizedBox(height: 10,),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 12),
           child: Text('Attach',style: TextStyle(color: R.colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
         ),
         const SizedBox(height: 5,),

         Padding(padding: const EdgeInsets.symmetric(horizontal: 12),
         child: Container(
          width: Get.width,
          padding: const EdgeInsets.symmetric(vertical: 0),
          height: 70,
           child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                              Container(
                                
                                      height: 60,
                                      width: 60,
                                      margin: const EdgeInsets.only(right: 10,top: 1),
                                      padding: const EdgeInsets.all(18),
                                      decoration: BoxDecoration(
                                        color: R.colors.grey,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Image.asset(
                                        'assets/images/attach.png',
                                        
                                      ),
                                  ),
                                  const SizedBox(width: 5,),
           
                                  Expanded(
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: 6,
                                      itemBuilder: (context,index){
                                       return Stack(
                                      //alignment: Alignment.topRight,
                                      children: [
                                        Container(
                                          
                                          width: 60,
                                          height: 60,
                                          margin: const EdgeInsets.only(right: 10,top: 5),
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: R.colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 5,
                                          child: Container(
                                            height: 20,
                                            width: 20,
                                            //padding: const EdgeInsets.all(5),
                                            decoration: const BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Icon(
                                                Icons.close,
                                                size: 12,
                                                color: R.colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                    
                                    }),
                                  ),
            ],
           ),
         ),
         ),
        SizedBox(
          height: 20,
        ),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 12),
        child: InkWell(
                onTap: (){

                },
                child: Container(
                  width: Get.width,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: R.colors.themeColor),
                  child: Center(
                      child: Text(
                    'Send',
                    style: TextStyle(color: R.colors.white),
                  )),
                ),
              ),
        ),
            ],
          ),
         )),
         

        ],
      ),
    );
  }
}