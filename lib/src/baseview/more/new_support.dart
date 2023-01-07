import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/resources.dart';
import '../../widgets/custom_appbar.dart';

class NewSupportScreen extends StatefulWidget {
  const NewSupportScreen({super.key});

  @override
  State<NewSupportScreen> createState() => _NewSupportScreenState();
}

class _NewSupportScreenState extends State<NewSupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.lightGrey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          customAppBar('Add New Support',true,false,'',false),
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
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text('Invoice No',style: TextStyle(color: R.colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                      //     Text('12-04-2021',style: TextStyle(color: R.colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                      //   ],
                      // ),
                      Container(
                          margin: const EdgeInsets.only(top: 10),
                          height: 45,
                          decoration: BoxDecoration(
                            color: R.colors.lightGrey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () {
                              //openPopUpOptions('No Types Available');
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    'Select type',
                                    style: TextStyle(
                                        fontSize: 14, color: R.colors.grey),
                                  )),
                                  const Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16,),
                        Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: R.colors.lightGrey),
                                child: TextFormField(
                                  maxLines: 10,
                                  decoration: InputDecoration(
                                    hintText: 'Message here',
                                    hintStyle: TextStyle(color: R.colors.grey),
                                    focusedBorder: InputBorder.none,
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16,),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: R.colors.blue,
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: R.colors.lightBlue,
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: Icon(Icons.camera_alt,color: R.colors.white,size: 20,),
                                        ),
                                        const SizedBox(width: 5,),
                                        Text(
                                          'Camera',
                                          style: TextStyle(
                                              fontSize: 14, color: R.colors.white),
                                        )

                                      ],
                                    ),
                                    const SizedBox(width: 16,),
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: R.colors.lightBlue,
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: Icon(Icons.camera,color: R.colors.white,size: 20,),
                                        ),
                                        const SizedBox(width: 5,),
                                        Text(
                                          'Gallery',
                                          style: TextStyle(
                                              fontSize: 14, color: R.colors.white),
                                        )

                                      ],
                                    ),
                                  ],
                                ),

                              ),
                              const SizedBox(height: 20,),

                              Container(
                                width: Get.width,
                                padding: const EdgeInsets.symmetric(vertical: 0),
                                height: 80,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                                    
                                
                                                        Expanded(
                                                          child: ListView.builder(
                                                            scrollDirection: Axis.horizontal,
                                                            shrinkWrap: true,
                                                            itemCount: 2,
                                                            itemBuilder: (context,index){
                                                            return Stack(
                                                            //alignment: Alignment.topRight,
                                                            children: [
                                                              Container(
                                                                
                                                                width: 80,
                                                                height: 80,
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
                              const SizedBox(height: 25,),
                              InkWell(
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
                                      'Submit',
                                      style: TextStyle(color: R.colors.white),
                                    )),
                                  ),
                                ),
                                const SizedBox(height: 10,),

                    ],
                  ),
                ),
         ),
        ],
      ),
    );
  }
}