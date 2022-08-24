// import 'dart:async';
// import 'package:flutter/services.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:trendoapp/constants/appImages.dart';
// import 'package:trendoapp/constants/appMessages.dart';
// import 'package:trendoapp/constants/appTextStyle.dart';
// import 'package:trendoapp/constants/baseColor.dart';
// import 'package:trendoapp/global/view/globalView.dart';

// // ignore: must_be_immutable
// class SelectBusinessAddressFromMapPage extends StatefulWidget {
//   @override
//   _SelectBusinessAddressFromMapPageState createState() =>
//       _SelectBusinessAddressFromMapPageState();
// }

// class _SelectBusinessAddressFromMapPageState
//     extends State<SelectBusinessAddressFromMapPage> {
//   final Geolocator geolocator = Geolocator();

//   TextEditingController businessAddressTextEditingController =
//       new TextEditingController();

//   LatLng latlong = null;
//   CameraPosition _cameraPosition;
//   GoogleMapController _controller;
//   Set<Marker> _markers = {};
//   Position userLocation;
//   @override
//   void initState() {

//     super.initState();
//     _cameraPosition = CameraPosition(target: LatLng(0, 0), zoom: 10.0);
//     getCurrentLocation();
//     _getLocation().then((position) {
//       userLocation = position;
//       print("userLocation-=-=> $userLocation");
//     });
//   }

//   Future getCurrentLocation() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission != PermissionStatus.granted) {
//       LocationPermission permission = await Geolocator.requestPermission();
//       if (permission != PermissionStatus.granted) getLocation();
//       return;
//     }
//     getLocation();
//   }

//   Future<Position> _getLocation() async {
//     var currentLocation;
//     try {
//       currentLocation = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.best);
//     } catch (e) {
//       currentLocation = null;
//     }
//     return currentLocation;
//   }

//   List<Address> results = [];
//   getLocation() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     print(position.latitude);

//     setState(() {
//       latlong = new LatLng(position.latitude, position.longitude);
//       _cameraPosition = CameraPosition(target: latlong, zoom: 10.0);
//       if (_controller != null)
//         _controller
//             .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));

//       _markers.add(Marker(
//           markerId: MarkerId("a"),
//           draggable: true,
//           position: latlong,
//           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//           onDragEnd: (_currentlatLng) {
//             latlong = _currentlatLng;
//           }));
//     });
//     getCurrentAddress();
//   }

//   getCurrentAddress() async {
//     final coordinates = new Coordinates(latlong.latitude, latlong.longitude);
//     results = await Geocoder.local.findAddressesFromCoordinates(coordinates);
//     var first = results.first;
//     if (first != null) {
//       var address;
//       address = first.featureName;
//       address = " $address, ${first.subLocality}";
//       address = " $address, ${first.subLocality}";
//       address = " $address, ${first.locality}";
//       address = " $address, ${first.countryName}";
//       address = " $address, ${first.postalCode}";

//       businessAddressTextEditingController.text = address;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(
//         "_getLocation-> ${_getLocation().then((value) => print("Value-->> ${value.latitude}"))}");
//     // _getCurrentLocation();
//     _getLocation();
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//             image: DecorationImage(
//           image: AssetImage(
//             AppImages.background_image1,
//           ),
//           fit: BoxFit.cover,
//           // alignment: Alignment.topCenter,
//         )),
//         child: Stack(
//           children: [
//             // GlobalView().assetImageView(AppImages.backgroundImage1),
//             Padding(
//               padding: const EdgeInsets.only(top: 16),
//               // child: SingleChildScrollView(
//               child: Center(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     GlobalView().sizedBoxView(47),
//                     Container(
//                       alignment: Alignment.topCenter,
//                       child: GlobalView().textViewWithCenterAlign(
//                           AppMessages.select_location_title,
//                           AppTextStyle.inter_font_family,
//                           AppTextStyle.semi_bold_font_weight,
//                           BaseColor.black_color,
//                           18),
//                     ),
//                     GlobalView().sizedBoxView(20),

//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 30),
//                       child: Container(
//                         padding: EdgeInsets.symmetric(vertical: 5),
//                         alignment: Alignment.centerLeft,
//                         child: GlobalView().textViewWithCenterAlign(
//                             AppMessages.title_business_address,
//                             AppTextStyle.inter_font_family,
//                             AppTextStyle.normal_font_weight,
//                             BaseColor.black_color.withOpacity(0.5),
//                             11),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 30),
//                       child: GlobalView().textFieldView(
//                           AppImages.ic_location,
//                           businessAddressTextEditingController,
//                           AppMessages.hint_business_address,
//                           AppTextStyle.start_text_align),
//                     ),

//                     GlobalView().sizedBoxView(15),
//                     GlobalView().textViewWithCenterAlign(
//                         AppMessages.or_text,
//                         AppTextStyle.inter_font_family,
//                         AppTextStyle.normal_font_weight,
//                         BaseColor.black_color.withOpacity(0.5),
//                         11),
//                     GlobalView().sizedBoxView(15),
//                     GlobalView().textViewWithCenterAlign(
//                         AppMessages.add_from_map_text,
//                         AppTextStyle.inter_font_family,
//                         AppTextStyle.medium_font_weight,
//                         BaseColor.black_color,
//                         16),
//                     GlobalView().sizedBoxView(15),
//                     Expanded(
//                       child: Container(
//                           // color: Colors.red,
//                           // height: ScreenSize().screenHeight(context) - 250,
//                           child: GoogleMap(
//                         initialCameraPosition: _cameraPosition,
//                         onMapCreated: (GoogleMapController controller) {
//                           _controller = (controller);
//                           _controller.animateCamera(
//                               CameraUpdate.newCameraPosition(_cameraPosition));
//                         },
//                         // markers: _markers,
//                         onCameraIdle: () {
//                           setState(() {});
//                         },
//                       )),
//                     ),

//                     // Spacer(),
//                   ],
//                 ),
//               ),
//             ),
//             // ),
//             Positioned(
//               top: 57,
//               left: 21,
//               child: Container(
//                 // color: Colors.red,
//                 height: 25,
//                 width: 25,
//                 child: GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: GlobalView().assetImageView(AppImages.ic_back)),
//               ),
//             ),
//             Positioned(
//               left: 50,
//               right: 50,
//               bottom: 50,
//               child: GestureDetector(
//                 onTap: () {
//                   // Navigator.pushNamed(context,
//                   //     AppRoutes.emailVerificationRouteName);
//                 },
//                 child:
//                     GlobalView().buttonFilled(context, AppMessages.save_text),
//               ),
//             ),
//             // Positioned(
//             //   top: 57,
//             //   left: 0,
//             //   right: 0,
//             //   child: Container(
//             //     alignment: Alignment.topCenter,
//             //     child: GlobalView().textView(
//             //         AppMessages.registerText,
//             //         AppTextStyle.poppinsFontFamily,
//             //         AppTextStyle.semiBoldFontWeight,
//             //         BaseColor.blackColor,
//             //         18),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/global/view/global_view.dart';

// ignore: must_be_immutable
class SelectBusinessAddressFromMapPage extends StatefulWidget {
  @override
  _SelectBusinessAddressFromMapPageState createState() => _SelectBusinessAddressFromMapPageState();
}

class _SelectBusinessAddressFromMapPageState extends State<SelectBusinessAddressFromMapPage> {
  TextEditingController businessAddressTextEditingController = new TextEditingController();

  late LatLng latlong;

  late CameraPosition _cameraPosition;

  GoogleMapController? _controller;

  Set<Marker> _markers = {};

  late BitmapDescriptor pinLocationIcon;

  Future getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    // ignore: unrelated_type_equality_checks
    if (permission != PermissionStatus.granted) {
      LocationPermission permission = await Geolocator.requestPermission();
      // ignore: unrelated_type_equality_checks
      if (permission != PermissionStatus.granted) getLocation();
      return;
    }
    getLocation();
  }

  void setCustomMapPin() async {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5), AppImages.marker_map_icon).then((onValue) {
      pinLocationIcon = onValue;
    });
  }

  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    print(position.latitude);
    print(position.longitude);

    latlong = new LatLng(position.latitude, position.longitude);
    _cameraPosition = CameraPosition(target: latlong, zoom: 10.0);
    print("_cameraPosition=-=-=-=>$_cameraPosition");
    if (_controller != null) _controller!.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
    // final Uint8List markerIcon =
    //     await getBytesFromAsset(AppImages.marker_map_icon, 100);

    _markers.add(Marker(
        markerId: MarkerId("a"),
        draggable: true,
        position: latlong,
        icon: pinLocationIcon,
        onDragEnd: (_currentlatLng) {
          setState(() {
            print("_currentlatLng==>> $_currentlatLng");
            latlong = _currentlatLng;
            print("latlong==>> $latlong");
          });
        }));

    // _markers.add(Marker(
    //     markerId: MarkerId("1"), position: latlong, icon: pinLocationIcon));

    // getCurrentAddress();
  }

  @override
  Widget build(BuildContext context) {
    // print(
    //     "_getLocation-> ${_getLocation().then((value) => print("Value-->> $value"))}");
    // _getCurrentLocation();
    setCustomMapPin();
    _cameraPosition = CameraPosition(target: LatLng(0, 0), zoom: 10.0);
    getCurrentLocation();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            AppImages.background_image1,
          ),
          fit: BoxFit.cover,
          // alignment: Alignment.topCenter,
        )),
        child: Stack(
          children: [
            // GlobalView().assetImageView(AppImages.backgroundImage1),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              // child: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GlobalView().sizedBoxView(47),
                    Container(
                      alignment: Alignment.topCenter,
                      child: GlobalView().textViewWithCenterAlign(AppMessages.select_location_title, AppTextStyle.inter_font_family,
                          AppTextStyle.semi_bold_font_weight, BaseColor.black_color, 18),
                    ),
                    GlobalView().sizedBoxView(20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        alignment: Alignment.centerLeft,
                        child: GlobalView().textViewWithCenterAlign(AppMessages.title_business_address, AppTextStyle.inter_font_family,
                            AppTextStyle.normal_font_weight, BaseColor.black_color.withOpacity(0.5), 11),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: GlobalView().textFieldView(AppImages.ic_location, businessAddressTextEditingController,
                          AppMessages.hint_business_address, AppTextStyle.start_text_align),
                    ),

                    GlobalView().sizedBoxView(15),
                    GlobalView().textViewWithCenterAlign(AppMessages.or_text, AppTextStyle.inter_font_family, AppTextStyle.normal_font_weight,
                        BaseColor.black_color.withOpacity(0.5), 11),
                    GlobalView().sizedBoxView(15),
                    GlobalView().textViewWithCenterAlign(
                        AppMessages.add_from_map_text, AppTextStyle.inter_font_family, AppTextStyle.medium_font_weight, BaseColor.black_color, 16),
                    GlobalView().sizedBoxView(15),
                    Expanded(
                      child: Container(
                          // color: Colors.red,
                          // height: ScreenSize().screenHeight(context) - 250,
                          child: GoogleMap(
                        myLocationEnabled: true,
                        initialCameraPosition: _cameraPosition,
                        onMapCreated: (GoogleMapController controller) {
                          _controller = (controller);
                          _controller!.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
                          // _markers.add(Marker(
                          //     markerId: MarkerId("a"),
                          //     draggable: true,
                          //     position: latlong,
                          //     icon: pinLocationIcon,
                          //     onDragEnd: (_currentlatLng) {
                          //       setState(() {
                          //         print("_currentlatLng==>> $_currentlatLng");
                          //         latlong = _currentlatLng;
                          //         print("latlong==>> $latlong");
                          //       });
                          //     }));
                        },
                        markers: _markers,
                      )),
                    ),

                    // Spacer(),
                  ],
                ),
              ),
            ),
            // ),
            Positioned(
              top: 57,
              left: 21,
              child: Container(
                // color: Colors.red,
                height: 25,
                width: 25,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: GlobalView().assetImageView(AppImages.ic_back)),
              ),
            ),
            Positioned(
              left: 50,
              right: 50,
              bottom: 50,
              child: GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(context,
                  //     AppRoutes.emailVerificationRouteName);
                },
                child: GlobalView().buttonFilled(context, AppMessages.save_text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
