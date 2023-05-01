import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sarf/controllers/home/home_controller.dart';
import 'package:sarf/src/baseview/Invoices/invoice_list_home.dart';
import 'package:sarf/src/utils/routes_name.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../constant/api_links.dart';
import '../../../controllers/common/profile_controller.dart';
import '../../../controllers/invoice/invoice_controller.dart';
import '../../../model/home/home_model.dart';
import '../../../model/members/invoice_list_model.dart';
import '../../../resources/resources.dart';
import '../../../services/dio_client.dart';
import '../../../services/notification_services.dart';
import '../base_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController ctr = Get.put<HomeController>(HomeController());
  InvoiceController invCtr = Get.find<InvoiceController>();
  
  InvoiceList? invoices;
  ProfileController profileController = Get.put<ProfileController>(ProfileController());
  TextEditingController txt = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();
  DateTime date = DateTime.now();
  DateTime month = DateTime.now();
  DateTime day = DateTime.now();
  NotificationServices notificationServices = NotificationServices();
  List<ExpenseTypes> expenseTypes = [];
  //ScrollController scrollCtr = ScrollController();
  @override
  void initState() {
    getData();
    super.initState();
   
     notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    // notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value){
      if (kDebugMode) {
        print('device token');
        print(value);
      }
    });
  }
  getData() async{
    
    await ctr.getHome(null,null,null,null).then((value) async{
      //print(ctr.budgets.first.id);
      if(ctr.budgets.isNotEmpty){
        ctr.getHome(ctr.budgets.first.id.toString(),null,null,null).then((value){
        if(ctr.budgets.isNotEmpty){
          ctr.selectedBudgetIndex.value = 1;
          ctr.selectedBudgetId.value = ctr.budgets.first.id.toString();
          ctr.selectedBudgetNumbder.value = "";    
          ctr.selectedBudgetName.value = ctr.budgets.first.name.toString() == 'Expenses' ? GetStorage().read('name') : ctr.budgets.first.name.toString() ;
          ctr.qrCode.value = "${GetStorage().read('mobile')}";
        }
      });
      }

       for (var expanse in ctr.expenseTypes) {
      if (expanse.invoiceSumAmount != null && expanse.invoiceSumAmount! > 0 ) {
        expenseTypes.add(expanse);
      }
    }
    setState(() {
      
    });
      
    }).catchError((error) async{
    await GetStorage().remove('user_token');
    await GetStorage().remove('groupId');
    await GetStorage().remove('userId');
    await GetStorage().remove('user_type');
    await GetStorage().remove('accountType');
    await GetStorage().remove('countryId');
    await GetStorage().remove(
      'name',
    );
    await GetStorage().remove(
      'username',
    );
    await GetStorage().remove(
      'email',
    );
    await GetStorage().remove(
      'firebase_email',
    );
    await GetStorage().remove(
      'mobile',
    );
    await GetStorage().remove(
      'photo',
    );
    await GetStorage().remove(
      'status',
    );
     Get.offAllNamed(RoutesName.LogIn);
    });
    // await profileController.getProfile();
    await invCtr.getInvoiceList('').then((value){
      invoices = value;
      return null;
    });
   
  }
  @override
  void dispose() {
    txt.dispose();
    super.dispose();
  }


  _shareQrCode() async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    screenshotController.capture().then((Uint8List? image) async {
      if (image != null) {
        try {
          String fileName = DateTime.now().microsecondsSinceEpoch.toString();
          final imagePath = await File('$directory/$fileName.png').create();
          await imagePath.writeAsBytes(image);
          
          // ignore: deprecated_member_use
          Share.shareXFiles([XFile(imagePath.path)]);
        } catch (error) {
          debugPrint(error.toString());
        }
      }
    }).catchError((onError) {
      debugPrint('Error --->> $onError');
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        // exit(0);
        SystemNavigator.pop(animated: true);
        //  SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
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
                          // buildLogoutIconAndText
                          
                          if(GetStorage().read("user_type") != 3)
                          GestureDetector(
                              onTap: () {
                                if(GetStorage().read("user_type") == 3){
                                  Get.snackbar("Error".tr, "You do not have access".tr);
                                  return;
                                }
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
                                        if(ctr.selectedBudgetName.value !=
                                                GetStorage().read('name')) ... [
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
                                       const SizedBox(height: 10,),
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
                                         const SizedBox(width: 10,),
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
                                        ],
                                       
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
                              Obx(() => Text(ctr.selectedBudgetName.value == GetStorage().read("name") ? GetStorage().read("name") :  ctr.selectedBudgetName.value )),
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
                                if(GetStorage().read("user_type") == 3){
                                  Get.snackbar("Error".tr, "You do not have access".tr);
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
                                      "#${ctr.budgets.length}",
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
                                            ctr.selectedBudgetNumbder.value = singleData.number == '#0' ? '' : singleData.number ?? '' ;    
                                            ctr.selectedBudgetName.value = singleData.name == 'Expenses' ? GetStorage().read('name') : singleData.name ?? '' ;    
                                            debugPrint(
                                                ctr.selectedBudgetId.value);
                                            ctr.getHome(singleData.id.toString(),day.day,month.month,date.year);
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
                                                  "${singleData.name == 'Expenses' ? GetStorage().read('name') : singleData.name ?? ''}\n${singleData.number == '#0' ? '' : singleData.number ?? ''}",
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
                                childAspectRatio: 3,
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 10,
                              ),
                              itemCount: expenseTypes.length,
                              itemBuilder: (context, index) {
                                var singleExpanse = expenseTypes[index];
                                
                                   return Obx(
                                  () =>  GestureDetector(
                                    onTap: (){
                                      Get.to(() => InvoiceListScreenHome( expanseId: singleExpanse.id.toString(),budgetId: ctr.selectedBudgetId.value.toString(),) );
                                    },
                                    child: Column(
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
                                              if(singleExpanse.unviewInvoice != null && singleExpanse.unviewInvoice! > 0 ) ...[
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
                                          height: 2,
                                        ),
                                        Text(
                                          "${ GetStorage().read("accountType") == 1 ? 'Personal'.tr : GetStorage().read("lang") == "en" ? singleExpanse.expenseName : singleExpanse.expenseNameAr}",
                                          style: TextStyle(
                                              color: R.colors.blackSecondery),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                                
                               
                              })),
                      const SizedBox(
                        height: 15,
                      ),
    
    
                      Container(
                        width: Get.width,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: R.colors.grey, width: 1)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
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
                                                'Total Invoices Yearly'.tr,
                                                style: TextStyle(
                                                    color: R.colors.black,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                " : ${ctr.totalInvoicesYearly}",
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
                                                'Total Expenses Yearly'.tr,
                                                style: TextStyle(
                                                    color: R.colors.black,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                " : ${ctr.totalExpansesYearly}",
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
                                     GestureDetector(
                                      onTap: () {
                                        Get.bottomSheet(
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                            decoration:  BoxDecoration(
                                              color: R.colors.white,
                                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                            ),
                                            child: Column(children: [
                                              Expanded(child: SingleChildScrollView(child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 10,),
                                                  
                                                 
                                                  Text("Day".tr), 
                                                  const SizedBox(height: 10,),  
                                                  GestureDetector(
                                                    onTap: () async {
                                                      
                                                       DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: day,
                      firstDate: DateTime(1950),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime.now());
     
                  if (pickedDate != null) {
                    
                      setState(() {
                        day = pickedDate;
                      });
                      Get.back();  
                      ctr.getHome(ctr.selectedBudgetId.value, day.day, month.month, date.year);
                   
                    }
                                                      
                                                    },
                                                    child:  Container(
                                                      padding: const EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(color: R.colors.black,width: 1),
                                                        borderRadius: BorderRadius.circular(10)
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text("${day.day}"),
                                                          Icon(Icons.arrow_drop_down,color: R.colors.black,),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10,),
                                                  
                                                  const SizedBox(height: 10,),
                                                  Text("Month".tr), 
                                                  const SizedBox(height: 10,),  
                                                  GestureDetector(
                                                    onTap: () async {
                                                   final selected = await showMonthPicker(
      context: context,
      initialDate: month,
      firstDate: DateTime(1970),
      lastDate: DateTime(2050)
    );                                                if(selected != null){
    
      setState(() {
      month = selected;
      });
    }
    Get.back();  
                      ctr.getHome(ctr.selectedBudgetId.value, day.day, month.month, date.year);
                                                      
                                                    },
                                                    child:  Container(
                                                      padding: const EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(color: R.colors.black,width: 1),
                                                        borderRadius: BorderRadius.circular(10)
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text("${month.month}"),
                                                          Icon(Icons.arrow_drop_down,color: R.colors.black,),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10,),
    
    //                                              
                                                  Text("Year".tr), 
                                                  const SizedBox(height: 10,),  
                                                  GestureDetector(
                                                    onTap: () async {
                                                     showDialog(
        context: context,
        builder: (BuildContext context) {
          
          return AlertDialog(
            // title: Text("Select Year"),
            content: Container( // Need to use container to add size constraint.
              width: 300,
              height: 300,
              child: YearPicker(
                firstDate: DateTime(DateTime.now().year - 100, 1),
                lastDate: DateTime(DateTime.now().year , 1),
                initialDate: DateTime.now(),
                // save the selected date to _selectedDate DateTime variable.
                // It's used to set the previous selected date when
                // re-showing the dialog.
                selectedDate: date,
                onChanged: (DateTime dateTime) {
                  // close the dialog when year is selected.
                  setState(() {
                    date = dateTime;
                  });
                  Navigator.pop(context);
    
                  Get.back();  
                      ctr.getHome(ctr.selectedBudgetId.value, day.day, month.month, date.year);
    
                  // Do something with the dateTime selected.
                  // Remember that you need to use dateTime.year to get the year
                },
              ),
            ),
          );
        },
      );
                                                      
                                                    },
                                                    child:  Container(
                                                      padding: const EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(color: R.colors.black,width: 1),
                                                        borderRadius: BorderRadius.circular(10)
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text("${date.year}".tr),
                                                          Icon(Icons.arrow_drop_down,color: R.colors.black,),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
    
                                                  SizedBox(height: 20,),
    
                                                  GestureDetector(
                                                    onTap: (){
                                                      // print(GetStorage().read("user_token"));
                                                      Get.back();  
                                                      setState(() {
                                                        date = DateTime.now();
                                                        month = DateTime.now();
                                                        day = DateTime.now();
                                                        
                                                      });
                      ctr.getHome(ctr.selectedBudgetId.value, null, null, null);  
                                                    },
                                                    child: Container(
                                                      width: 100,
                                                      
                                                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(20),
                                                        color: R.colors.blue
                                                        ),
                                                        child: Center(child: Text('Reset'.tr),),
                                                    ),
                                                  ),
                                                  
                                                ],
                                              ),))
                                            ]),
                                          ),
                                        );
                                      },
                                       child: Container(
                                        width: 50,
                                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                                        decoration: BoxDecoration(
                                          color: R.colors.lightBlue3,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            // Text(ctr.expanse.value,style: TextStyle(color: R.colors.black),),
                                            Icon(Icons.search,color: R.colors.black,)
                                          ],
                                        ),
                                       ),
                                     ),
                                      
                                    ],
                                  ),
                                ),
    
    
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: Get.width,
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  // width: Get.width * 0.35,
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border:
                                          Border.all(color: R.colors.grey, width: 1)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Screenshot(controller: screenshotController, child: Column(
                                        children: [
                                          SizedBox(
                                            width: 80,
                                            height: 80,
                                            child:  Container(
                                            color: R.colors.white,
                                            child: QrImage(
                                                      data: ctr.qrCode.value,
                                                      version: QrVersions.auto,
                                                      size: 100.0,
                                                    ),
                                          ),
                                          ),
                                           const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${ctr.selectedBudgetName}',
                                        // - ${'QR code'.tr
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
                                                  
                                        ],
                                      )),
                                      //  SizedBox(
                                      //   width: 100,
                                      //   height: 100,
                                      //   child: Screenshot(
                                      //     controller: screenshotController,
                                      //     child: Container(
                                      //       color: R.colors.white,
                                      //       child: QrImage(
                                      //                 data: ctr.qrCode.value,
                                      //                 version: QrVersions.auto,
                                      //                 size: 100.0,
                                      //               ),
                                      //     ),
                                      //   ),
                                      // ),
                                     
                                      Text(
                                        ctr.qrCode.value,
                                        style: TextStyle(color: R.colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 3,
                                child: SizedBox(
                                   width: Get.width,
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                                color: R.colors.grey, width: 1)),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                // Image.asset(
                                                //   R.images.icon2,
                                                //   width: 25,
                                                //   height: 25,
                                                // ),
                                                // const SizedBox(
                                                //   width: 5,
                                                // ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Daily".tr),
                                                    SizedBox(height: 5,),
                                                    Row(
                                                      children: [
                                                        
                                                        Text(
                                                          'Total Invoices'.tr,
                                                          style: TextStyle(
                                                              color: R.colors.black,
                                                              fontSize: 12),
                                                        ),
                                                        Text(
                                                          " : ${ctr.totalInvoicesDaily}",
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
                                                          " : ${ctr.totalExpansesDaily}",
                                                          style: TextStyle(
                                                              color: R.colors.black,
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 5,),
                                                     Text("Monthly".tr),
                                                    SizedBox(height: 5,),
                                                    Row(
                                                      children: [
                                                        
                                                        Text(
                                                          'Total Invoices'.tr,
                                                          style: TextStyle(
                                                              color: R.colors.black,
                                                              fontSize: 12),
                                                        ),
                                                        Text(
                                                          " : ${ctr.totalInvoicesMontly}",
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
                                                          " : ${ctr.totalExpansesMontly}",
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
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: R.colors.grey, width: 1)),
                                              child: GestureDetector(
                                                onTap: (){
                                                  Get.bottomSheet(
                                                    Container(
                                                      padding: const EdgeInsets.all(20),
                                                      decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                                      color: R.colors.white,
                                                      ),
                                                      child: Column(mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Row(children: [
                                                          GestureDetector(
                                                            onTap: ()async{
                                                              // debugPrint(invoices?.data?.length.toString());
                                                              if(invoices?.data != null){

                                                                    final xcel.Workbook workbook = xcel.Workbook();
                                                                  final xcel.Worksheet sheet = workbook.worksheets[0];
                                                                  sheet.getRangeByIndex(1, 1).setText("Inv number".tr);
                                                                  sheet.getRangeByIndex(1, 2).setText("Created at".tr);
                                                                  sheet.getRangeByIndex(1, 3).setText("Customer".tr);
                                                                  sheet.getRangeByIndex(1, 4).setText("Description".tr);
                                                                  sheet.getRangeByIndex(1, 5).setText("Amount".tr);
                                                                  for (var i = 0; i < invoices!.data!.length; i++) {
                                                                    final item = invoices!.data![i];
                                                                    var id = (invoices!.data!.length - 1 ) - i;
                                                                    sheet.getRangeByIndex(i + 2, 1).setText((id + 1).toString());
                                                                    sheet.getRangeByIndex(i + 2, 2).setText(item.createdDate.toString());
                                                                    sheet.getRangeByIndex(i + 2, 3).setText(item.customer?.name.toString());
                                                                    sheet.getRangeByIndex(i + 2, 4).setText(item.note ?? '');
                                                                    sheet.getRangeByIndex(i + 2, 5).setText(item.amount.toString());
                                                                  }

                                                                  final List<int> bytes = workbook.saveAsStream();
                                                                   workbook.dispose();
                                                                  //  FileStorage.writeCounter(bytes, "geeksforgeeks.xlsx", context);
                                                                  final directory = (await getApplicationDocumentsDirectory()).path;
                                                                  String fileName = DateTime.now().microsecondsSinceEpoch.toString();
                                                                  final file = File('$directory/$fileName.xlsx');
                                                                   await file.writeAsBytes(bytes,flush: true);
                                                                  try{
                                                                        Share.shareXFiles([XFile(file.path)]);
                                                                      } catch (error) {
                                                                        debugPrint(error.toString());
                                                                      
                                                                  }
                                                                 
                                                                Get.back();

                                                              }
                                                             
                                                            },
                                                            child: Image.asset(R.images.excelIcon,width: 60,height: 60,fit: BoxFit.cover,),
                                                          ),
                                                          SizedBox(width: 20,),
                                                           GestureDetector(
                                                            onTap: () async{
                                                              // A Suls Regular.ttf
                                                              final  font = await rootBundle.load("assets/fonts/arabic.ttf");
                                                              final  ttf = pw.Font.ttf(font);
                                                              // final data = await rootBundle.load("assets/fonts/arabic.ttf");

                                                              //   final  dataint = data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);

                                                              //   final  PdfFont  font  =  pw.PdfTrueTypeFont (date,12);
                                                              if(invoices?.data != null){
                                                                  final pdf = pw.Document();
                                                                    pdf.addPage(pw.MultiPage(
                                                                      pageFormat: PdfPageFormat.a4,
                                                                      theme: pw.ThemeData.withFont(
                                                                            base: ttf,
                                                                          ),
                                                                      build: (pw.Context context) {
                                                                      return <pw.Widget>[
                                                                        pw.Table(children: [
                                                                          pw.TableRow(children: [
                                                                            pw.Column(children: [
                                                                              
                                                                              pw.Text("Inv number".tr,
                                                                               textDirection: pw.TextDirection.rtl,
                                                                              )
                                                                            ]),
                                                                             pw.Column(children: [
                                                                 
                                                                              pw.Text("Created at".tr.toString(), textDirection: pw.TextDirection.rtl, ),
                                                                            ]),

                                                                             pw.Column(children: [
                                                                 
                                                                              pw.Text("Customer".tr.toString(),  textDirection: pw.TextDirection.rtl,),
                                                                            ]),


                                                                             pw.Column(children: [
                                                                
                                                                              pw.Text("Description".tr.toString(), textDirection: pw.TextDirection.rtl,),
                                                                            ]),



                                                                             pw.Column(children: [
                                                                  
                                                                              pw.Text("Amount".tr.toString(),  textDirection: pw.TextDirection.rtl,),
                                                                            ]),
                                                                            
                                                                          ]),
                                                                           for(var i = 0; i < invoices!.data!.length; i++)
                                                                            pw.TableRow(children: [
                                                                            pw.Column(children: [
                                                                              
                                                                              pw.Text("${((invoices!.data!.length - 1 ) - i + 1)}"),
                                                                            ]),
                                                                             pw.Column(children: [
                                                                 
                                                                              pw.Text(invoices!.data![i].createdDate.toString()),
                                                                            ]),

                                                                             pw.Column(children: [
                                                                 
                                                                              pw.Text(invoices!.data![i].customer?.name.toString() ?? ''),
                                                                            ]),


                                                                             pw.Column(children: [
                                                                
                                                                              pw.Text(invoices!.data![i].note ?? ''),
                                                                            ]),



                                                                             pw.Column(children: [
                                                                  
                                                                              pw.Text(invoices!.data![i].amount.toString()),
                                                                            ]),
                                                                            
                                                                          ]),
                                                                        ]),
                                                                      //  pw.Table(children: <>) 
                                                                      ]; // Center
                                                                    })); // Page
                                                                            
                                                                      final output = await getTemporaryDirectory();
                                                                      String fileName2 = DateTime.now().microsecondsSinceEpoch.toString();
                                                                      final file = File("${output.path}/$fileName2.pdf");
                                                                    // final file = File("example.pdf");
                                                                    await file.writeAsBytes(await pdf.save());

                                                                    try{
                                                                       Share.shareXFiles([XFile(file.path)]);
                                                                          } catch (error) {
                                                                            debugPrint(error.toString());
                                                                          }

                                                                    Get.back();                                                                  

                                                              }
                                                              

                                                            },
                                                            child: Image.asset(R.images.pdfIcon,width: 60,height: 60,fit: BoxFit.cover,),
                                                          ),
                                                        ],),
                                                      ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      R.images.icon1,
                                                      width: 20,
                                                      height: 20,
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
                                            ),
                                          ),
                                          const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Container(
                                          // width: Get.width * 0.25,
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: R.colors.grey, width: 1)),
                                          child: GestureDetector(
                                            onTap: (){
                                              _shareQrCode();
                                            },
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  R.images.icon3,
                                                  width: 20,
                                                  height: 20,
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
                                        ),
                                      ),
                                        ],
                                        
                                      ),
                                      
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        )),
      ),
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
