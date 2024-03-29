import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:sarf/controllers/common/profile_controller.dart';

import '../../constant/global_constants.dart';
import '../../controllers/auth/registration_controller.dart';
import '../../resources/resources.dart';
import '../widgets/custom_appbar.dart';

class LocationView extends StatefulWidget {
  const LocationView({super.key});

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  RegistrationController registrationController =
      Get.find<RegistrationController>();
  ProfileController profileController =
      Get.put<ProfileController>(ProfileController());
  String label = '';
  String address = '';
  String lat = '';
  String lng = '';
  var locationLatGiven;
  var locationLngGiven;

  var screenDecider = Get.arguments['Screen'] == 'From Profile Screen'
      ? 'From Profile Screen'
      : 'From Register Screen';

  CameraPosition? cameraPosition = CameraPosition(
    //innital position in map
    target:
        LatLng(Get.arguments['lat'], Get.arguments['lng']), //initial position
    zoom: 20.0, //initial zoom level
  );

  List<Marker> marker = [];
  GoogleMapController? mapController; //contrller for Google map

  LatLng startLocation = LatLng(Get.arguments['lat'], Get.arguments['lng']);
  String location = "Search".tr;
  // BitmapDescriptor? customIcon;

  @override
  void initState() {
    // _determinePosition().then((value)async{
    //   setState(() {
    //     startLocation = LatLng(value.latitude, value.longitude);
    //   });
    //   locationLatGiven = value.latitude;

    //   locationLngGiven = value.longitude;
    // LatLng latLng = LatLng(value.latitude, value.longitude);
    //    handleTap(latLng);
    //    cameraPosition = CameraPosition(
    //   //innital position in map
    //   target: LatLng(locationLatGiven, locationLngGiven), //initial position
    //   zoom: 20.0, //initial zoom level
    // );

    // }).catchError((error){
    //   debugPrint(error.toString());
    // });
    // print(profileController.location_lng.value);
    // print(profileController.location_lat.value);

    //  addMarker();
    super.initState();
  }

  // void addMarker() async {
  //   final Uint8List markerIcon =
  //       await getBytesFromAsset('assets/images/location.png', 300);
  //   //BitmapDescriptor.fromBytes(markerIcon)

  //   customIcon = BitmapDescriptor.fromBytes(markerIcon);
  // }

  // Future<Uint8List> getBytesFromAsset(String path, int width) async {
  //   ByteData data = await rootBundle.load(path);
  //   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
  //       targetWidth: width);
  //   ui.FrameInfo fi = await codec.getNextFrame();
  //   return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
  //       .buffer
  //       .asUint8List();
  // }

  void handleTap(LatLng argument) async {
    debugPrint(argument.toString());
    await placemarkFromCoordinates(argument.latitude, argument.longitude)
        .then((value) {
      List<Placemark> placemarks = value;
      if (mounted) {
        setState(() {
          marker = [];
          marker.add(Marker(
            markerId: MarkerId(argument.toString()),
            position: argument,
            // icon: customIcon!
          ));
          // print(placemarks.first.toString());
          location =
              "${placemarks.first.administrativeArea},${placemarks.first.subAdministrativeArea},${placemarks.first.subLocality}, ${placemarks.first.thoroughfare}, ${placemarks.first.street}, ${placemarks.first.country}";
          address = location;
          lat = argument.latitude.toString();
          lng = argument.longitude.toString();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: R.colors.lightGrey,
      body: SafeArea(
          child: Stack(
        children: [
          //  newOrderScreenAppBar("selectlocation".tr),
          //  Sizes.h20,
          Stack(
            children: [
              GoogleMap(
                //Map widget from google_maps_flutter package
                zoomGesturesEnabled: true, //enable Zoom in, out on map
                initialCameraPosition: cameraPosition!,
                myLocationButtonEnabled: false,
                myLocationEnabled: false,
                zoomControlsEnabled: false,
                padding: const EdgeInsets.only(top: 130),
                mapType: MapType.normal, //map type
                onMapCreated: (controller) {
                  //method called when map is created
                  setState(() {
                    mapController = controller;
                    marker.add(Marker(
                        markerId: const MarkerId('default'),
                        position: startLocation));
                    // handleTap(argument);
                  });
                  handleTap(startLocation);
                },
                onTap: handleTap,
                markers: Set.from(marker),
                onCameraMove: (CameraPosition cameraPositiona) {
                  cameraPosition = cameraPositiona;
                },
                onCameraIdle: () async {
                  //   List<Placemark> placemarks = await placemarkFromCoordinates(cameraPosition!.target.latitude, cameraPosition!.target.longitude);
                  //  print(placemarks.first);
                  //   setState(() {
                  //      location = placemarks.first.administrativeArea.toString() + ", " +  placemarks.first.street.toString() + ',' + placemarks.first.country.toString();
                  //   });
                },
              ),

              //search autoconplete input
              Positioned(
                //search input bar
                bottom: 10,

                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                    onTap: () {
                      print(
                          "This is selected Location====================${location.toString()}");
                      print(
                          "This is selected Latitude====================${lat.toString()}");
                      print(
                          "This is selected Longitude====================${lng.toString()}");

                      if (screenDecider == 'From Register Screen') {
                        print(screenDecider);
                        print('Storing in register');
                        registrationController.location.value = location;
                        registrationController.location_lat.value = lat;
                        registrationController.location_lng.value = lng;
                        print(
                            "This is stored Location====================${registrationController.location.toString()}");
                        print(
                            "This is stored Location Lat====================${registrationController.location_lat.toString()}");
                        print(
                            "This is stored Location Lng====================${registrationController.location_lng.toString()}");
                      }
                      if (screenDecider == 'From Profile Screen') {
                        print(screenDecider);
                        print('Storing in profile');
                        profileController.location.value = location;
                        profileController.location_lat.value = lat;
                        profileController.location_lng.value = lng;
                        print(
                            "This is stored Location====================${profileController.location.toString()}");
                        print(
                            "This is stored Location Lat====================${profileController.location_lat.toString()}");
                        print(
                            "This is stored Location Lng====================${profileController.location_lng.toString()}");
                      }

                      Get.back();
                    },
                    child: Container(
                      width: Get.width - 40,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: R.colors.themeColor),
                      child: Center(
                          child: Text(
                        'Done'.tr,
                        style: TextStyle(color: R.colors.white),
                      )),
                    ),
                  ),
                ),
              ),
            ],
          ),
          customAppBar('Select Location'.tr, true, true, '', false, () {}),
          Container(
            margin: const EdgeInsets.only(top: 75),
            child: InkWell(
                onTap: () async {
                  var place = await PlacesAutocomplete.show(
                      context: context,
                      apiKey: googleMapsKey,
                      mode: Mode.overlay,
                      types: [],
                      strictbounds: false,
                      //components: [Component(Component.country, 'np')],
                      //google_map_webservice package
                      onError: (err) {
                        debugPrint(err.errorMessage);
                        debugPrint("hahahaah");
                      }).then((value) async {
                    if (value != null) {
                      //  print(value);

                      //form google_maps_webservice package
                      final plist = GoogleMapsPlaces(
                        apiKey: googleMapsKey,
                        apiHeaders: await const GoogleApiHeaders().getHeaders(),
                        //from google_api_headers package
                      );
                      String placeid = value.placeId ?? "0";
                      final detail = await plist.getDetailsByPlaceId(placeid);
                      final geometry = detail.result.geometry!;
                      final lat = geometry.location.lat;
                      final lang = geometry.location.lng;
                      var newlatlang = LatLng(lat, lang);

                      //move map camera to selected place with animation
                      mapController?.animateCamera(
                          CameraUpdate.newCameraPosition(
                              CameraPosition(target: newlatlang, zoom: 17)));
                      setState(() {
                        marker.clear();
                        location = value.description.toString();
                        marker.add(Marker(
                            markerId: MarkerId('$newlatlang'),
                            position: newlatlang));
                        address = location;
                        this.lat = lat.toString();
                        lng = lang.toString();
                      });
                    }
                  });

                  debugPrint(place.toString());
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: R.colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: R.colors.lightGrey,
                          offset: const Offset(0, 1),
                          blurRadius: 2,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width - 40,
                      child: Text(
                        location.tr,
                        style: const TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                )),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            // child: Container(
            //     margin: const EdgeInsets.only(left: 25, right: 25),
            //     child: customButton(() {
            //       if(address == ''){
            //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Choose an Address')));
            //         return;
            //       }
            //       if(lat == ''){
            //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Choose an Address')));
            //         return;
            //       }
            //       if(lng == ''){
            //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Choose an Address')));
            //         return;
            //       }
            //       Get.dialog(addNametoLocationDilaog(address,lat,lng,context));
            //     }, "proceed".tr)),
          )
        ],
      )
          // Column(
          //   children: [
          //     newOrderScreenAppBar("selectlocation".tr),
          //     Sizes.h20,
          //     //Expanded(child: PlacePicker(googleMapsKey)),

          //                   /* Expanded(
          //                      child: PlacePicker(
          //                                 apiKey: googleMapsKey,
          //                                // initialPosition: LatLng(34, 72),
          //                                 useCurrentLocation: true,
          //                                 selectInitialPosition: true,

          //                                 usePlaceDetailSearch: true,
          //                                 onPlacePicked: (result) {
          //                                          // ctr.setLocation(result.geometry!.location.lat, result.geometry!.location.lng, result.formattedAddress!);
          //                                   print(result.formattedAddress!);
          //                                 //Navigator.of(context).pop();
          //                                 //Navigator.pushNamed(context, RouteNames.searchRealEstate);

          //                                 setState(() {

          //                                 });
          //                                   },
          //                                // autocompleteRadius: 500000,
          //                                 initialPosition: const LatLng(34, 72),

          //                                 /*autocompleteComponents: [
          //                                   gmap.Component(
          //                                       gmap.Component.country, "pk")
          //                                 ],*/
          //                               ),
          //                    ),*/

          //     Sizes.h20,
          //    // searchLocationField(),
          //     Padding(
          //       padding: const EdgeInsets.only(bottom: 20),
          //       child: Container(
          //           margin: EdgeInsets.only(left: 25, right: 25),
          //           child: customButton(() {
          //             Get.dialog(addNametoLocationDilaog());
          //           }, "proceed".tr)),
          //     )
          //   ],
          // ),
          ),
    );
  }
}
