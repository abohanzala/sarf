import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/resources.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(

          
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.more_vert, color: R.colors.black),
               Row(
                children:  [
                  const Text('Office'),
                  GestureDetector(
                    onTap: (){},
                    child:  Icon(Icons.close, color: R.colors.black,)),
                ],
               )
              ],
            ),
            const SizedBox(height: 15,),
            SizedBox(
              width: Get.width,
              height: 120,
              child: Row(
                
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: R.colors.black),
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: R.colors.white),
                          padding: const EdgeInsets.all(5),
                          child: const Center(child: Icon(Icons.add,size: 15,),),
                        ),
                        const SizedBox(height: 10,),
                        Text('New\nbudget\n#3',style: TextStyle(
                          color: R.colors.white,
                          decoration: TextDecoration.underline,
                        ),
                        textAlign: TextAlign.center,
                        
                        ),
                      ],
                    ),
                  ),
                  //Spacer(),
                  ListView.builder(
                   // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 2,
                    itemBuilder: (context,index){
                    return Container(
                      height: 120,
                      margin: const EdgeInsets.only(left: 2),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(shape: BoxShape.circle,color: index == 1 ? R.colors.blue.withOpacity(0.2): null ),
                      child: Container(
                        height: 100,
                        padding: const EdgeInsets.all(25),
                        //margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          //borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: R.colors.blue,width: 3),
                          color: R.colors.white,
                         
                          ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Office'),
                            Text('#1'),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 15,),
            Expanded(
              child: GridView.builder(gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                      childAspectRatio: 2.5,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 10,
                      
                    ),
                    itemCount: 30,
                     itemBuilder: (context,index){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: Get.width,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: R.colors.blue,width: 1),
                            color: R.colors.white

                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            child: Center(child: Text('\$1413',style: TextStyle(color: R.colors.blue),)),
                          ),
                          SizedBox(height: 5,),
                          Text('مأكولات ومشروبات',style: TextStyle(color: R.colors.blackSecondery),)
                        ],
                      );
              })),
          ],
        ),
      )),
    );
  }
}