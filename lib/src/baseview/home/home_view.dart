import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sarf/controllers/home/home_controller.dart';

import '../../../resources/resources.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController ctr = Get.put<HomeController>(HomeController());
  TextEditingController txt = TextEditingController();
  //ScrollController scrollCtr = ScrollController();
  @override
  void initState() {
    getData();
    super.initState();
  }
  getData() async{
    await ctr.getHome(null).then((value) async{
      //print(ctr.budgets.first.id);
      if(ctr.budgets.isNotEmpty){
        ctr.getHome(ctr.budgets.first.id.toString()).then((value){
        if(ctr.budgets.isNotEmpty){
          ctr.selectedBudgetIndex.value = 1;
          ctr.selectedBudgetId.value = ctr.budgets.first.id.toString();
          ctr.selectedBudgetNumbder.value = "";    
          ctr.selectedBudgetName.value = ctr.budgets.first.name.toString();
          ctr.qrCode.value = "${GetStorage().read('mobile')}";
        }
      });
      }
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Obx(
        () => ctr.loading.value == true
            ? Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    //backgroundColor: AppColors.whiteClr,
                    color: R.colors.blue,
                  ),
                ),
              )
            : Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.bottomSheet(
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 40),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: R.colors.white,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (ctr.selectedBudgetId.value ==
                                              '') {
                                            Get.snackbar(
                                                'Error'.tr, 'Select a budget'.tr);
                                            return;
                                          }
                                          Get.dialog(Dialog(
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: R.colors.white),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                     Text("Are you sure you want to delete this budget".tr),
                                     SizedBox(height: 10,),
                                     Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                           onTap: (){
                                            Get.back();
                                             ctr.deleteBudget();
                                           },
                                           child: Container(
                                            // width: Get.width,
                                             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                             decoration: BoxDecoration(
                                                 borderRadius: BorderRadius.circular(10),
                                                 color: R.colors.themeColor),
                                             child: Center(
                                                 child: Text(
                                               'Delete'.tr,
                                               style: TextStyle(color: R.colors.white),
                                             )),
                                           ),
                                                                               ),
                                        ),
                                       SizedBox(width: 10,),
                                       Expanded(
                                         child: InkWell(
                                           onTap: (){
                                             Get.back();
                                           },
                                           child: Container(
                                            // width: Get.width,
                                             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                             decoration: BoxDecoration(
                                                 borderRadius: BorderRadius.circular(10),
                                                 color: R.colors.blue),
                                             child: Center(
                                                 child: Text(
                                               'Back'.tr,
                                               style: TextStyle(color: R.colors.white),
                                             )),
                                           ),
                                         ),
                                       )
                                     
                                      ],
                                     )

                                    ],
                                  ),
                                ),
                              ));
                                          
                                        },
                                        child: Text(
                                          'Delete this budget'.tr,
                                          style: TextStyle(
                                              color: R.colors.blackSecondery),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Divider(
                                        color: R.colors.grey,
                                        thickness: 1,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (ctr.selectedBudgetId.value ==
                                              '') {
                                            Get.snackbar(
                                                'Error'.tr, 'Select a budget'.tr);
                                            return;
                                          }
                                          ctr.resetBudget();
                                        },
                                        child: Text(
                                          'Reset this budget'.tr,
                                          style: TextStyle(
                                              color: R.colors.blackSecondery),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child:
                                Icon(Icons.more_vert, color: R.colors.black)),
                        Row(
                          children: [
                            Obx(() => Text(ctr.selectedBudgetName.value)),
                            GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  Icons.close,
                                  color: R.colors.black,
                                )),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: Get.width,
                      height: GetStorage().read("lang") == 'en'? 100: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.dialog(Dialog(
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: R.colors.white),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                          onTap: () => Get.back(),
                                          child: Image.asset(
                                            R.images.cross,
                                            width: 30,
                                            height: 30,
                                          )),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'Add new Project type'.tr,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: R.colors.blackSecondery),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: R.colors.lightGrey),
                                        child: TextFormField(
                                          controller: txt,
                                          decoration: InputDecoration(
                                            hintText: 'Project Name'.tr,
                                            hintStyle:
                                                TextStyle(color: R.colors.grey),
                                            focusedBorder: InputBorder.none,
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      customSimpleButton(() {
                                        if (txt.text.isEmpty) {
                                          Get.snackbar(
                                              'Error'.tr,
                                              'Required Field'.tr
                                                  .tr,
                                              backgroundColor:
                                                  R.colors.themeColor);
                                          return;
                                        }
                                        ctr.addBudget(txt.text).then((value) {
                                          txt.clear();
                                        });
                                      })
                                    ],
                                  ),
                                ),
                              ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: R.colors.black),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: R.colors.white),
                                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                                    child: const Center(
                                      child: Icon(
                                        Icons.add,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'New budget'.tr,
                                    style: TextStyle(
                                      color: R.colors.white,
                                      decoration: TextDecoration.underline,
                                      fontSize: 12
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "${ctr.budgets.length}",
                                    style: TextStyle(
                                      color: R.colors.white,
                                      decoration: TextDecoration.underline,
                                      fontSize: 12
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                           SizedBox(
                            width: GetStorage().read('lang') == "en" ? 10 : 10,
                          ),
                          Expanded(
                            child: ListView.builder(
                                // physics: NeverScrollableScrollPhysics(),
                                reverse: true,
                                shrinkWrap: true,
                                padding:  EdgeInsets.only(right: GetStorage().read("lang") != "en" ? 7:0,left: GetStorage().read("lang") == "en" ? 7:0 ),
                                scrollDirection: Axis.horizontal,
                                itemCount: ctr.budgets.length,
                                itemBuilder: (context, index) {
                                  var singleData = ctr.budgets[index];
                                  return Obx(
                                    () => Container(
                                      height: GetStorage().read("lang") == 'en'? 100: 100,
                                      margin: const EdgeInsets.only(left: 2),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: (ctr.selectedBudgetIndex
                                                          .value -
                                                      1) ==
                                                  index
                                              ? R.colors.blue.withOpacity(0.2)
                                              : null),
                                      child: GestureDetector(
                                        onTap: () {
                                          ctr.selectedBudgetIndex.value =
                                              (index + 1);
                                          ctr.selectedBudgetId.value =
                                              singleData.id.toString();
                                          ctr.selectedBudgetNumbder.value = singleData.number ?? '';    
                                          ctr.selectedBudgetName.value = singleData.name ?? '' ;    
                                          debugPrint(
                                              ctr.selectedBudgetId.value);
                                          ctr.getHome(singleData.id.toString());
                                        },
                                        child: Container(
                                          height: GetStorage().read("lang") == 'en'? 80: 80,
                                          width: GetStorage().read("lang") == 'en'? 80: 80,
                                          padding: const EdgeInsets.all(5),
                                          //margin: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            //borderRadius: BorderRadius.circular(50),
                                            border: Border.all(
                                                color: R.colors.blue, width: 3),
                                            color: R.colors.white,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${singleData.name ?? ''}\n${singleData.number ?? ''}",
                                                style: const TextStyle(
                                                    fontSize: 14),
                                                    overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,    
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                        flex: 3,
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent:
                                  MediaQuery.of(context).size.width / 2,
                              childAspectRatio: 2.5,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 10,
                            ),
                            itemCount: ctr.expenseTypes.length,
                            itemBuilder: (context, index) {
                              var singleExpanse = ctr.expenseTypes[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: R.colors.blue, width: 1),
                                        color: R.colors.white),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          ctr.currency.value,
                                          style:
                                              TextStyle(color: R.colors.blue),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "${singleExpanse.invoiceSumAmount ?? 0}",
                                          style:
                                              TextStyle(color: R.colors.blue),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${GetStorage().read("lang") == "en" ? singleExpanse.expenseName : singleExpanse.expenseNameAr}",
                                    style: TextStyle(
                                        color: R.colors.blackSecondery),
                                  )
                                ],
                              );
                            })),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: Get.width * 0.42,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: R.colors.grey, width: 1)),
                          child: Column(
                            children: [
                               SizedBox(
                                width: 100,
                                height: 100,
                                child: QrImage(
                                          data: ctr.qrCode.value,
                                          version: QrVersions.auto,
                                          size: 100.0,
                                        ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${ctr.selectedBudgetName} - QR code',
                                style: TextStyle(color: R.colors.grey),
                              ),
                              // const SizedBox(
                              //   height: 5,
                              // ),
                              // Text(
                              //   'Username #1',
                              //   style: TextStyle(color: R.colors.black),
                              // ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                ctr.qrCode.value,
                                style: TextStyle(color: R.colors.black),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: Get.width * 0.47,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: R.colors.grey, width: 1)),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      R.images.icon2,
                                      width: 25,
                                      height: 25,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Total Invoices'.tr,
                                              style: TextStyle(
                                                  color: R.colors.black,
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              " : ${ctr.totalInvoices}",
                                              style: TextStyle(
                                                  color: R.colors.black,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Total Expenses'.tr,
                                              style: TextStyle(
                                                  color: R.colors.black,
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              " : ${ctr.totalExpanses}",
                                              style: TextStyle(
                                                  color: R.colors.black,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: R.colors.grey, width: 1)),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      R.images.icon1,
                                      width: 25,
                                      height: 25,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Share Report'.tr,
                                          style: TextStyle(
                                              color: R.colors.black,
                                              fontSize: 12),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: R.colors.grey, width: 1)),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      R.images.icon3,
                                      width: 25,
                                      height: 25,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Share QR code'.tr,
                                          style: TextStyle(
                                              color: R.colors.black,
                                              fontSize: 12),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
      )),
    );
  }

  InkWell customSimpleButton(Function()? onPress) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: R.colors.themeColor),
        child: Center(
            child: Text(
          'Add'.tr,
          style: TextStyle(color: R.colors.white),
        )),
      ),
    );
  }
}
