import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/providers/business_user_provider.dart';

// ignore: must_be_immutable
class MapScreen extends StatefulWidget {
  // Completer<GoogleMapController> _controller = Completer();
  bool isTemp;
  MapScreen({@required this.isTemp});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng latlong;
  CameraPosition _cameraPosition;
  GoogleMapController _controller;
  // Set<Marker> _markers = {};
  BitmapDescriptor pinLocationIcon;
  Position position;
  LatLng lastMapPosition;
  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("IS temp-> ${widget.isTemp}");
    setCustomMapPin();
    _cameraPosition = CameraPosition(target: LatLng(0, 0), zoom: 14);
    getCurrentLocation();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        color: BaseColor.pure_white_color,
        child: SafeArea(
          top: widget.isTemp ? true : false,
          bottom: false,
          child: Scaffold(
            backgroundColor: BaseColor.pure_white_color,
            body: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 2),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    alignment: Alignment.centerLeft,
                    child: GlobalView().textViewWithCenterAlign(
                        AppMessages.hint_business_location,
                        AppTextStyle.inter_font_family,
                        AppTextStyle.normal_font_weight,
                        BaseColor.black_color.withOpacity(0.5),
                        11),
                  ),
                ),
                Visibility(
                    visible: widget.isTemp ? true : false,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 6, bottom: 16),
                      child: GlobalView().textFieldView(
                          AppImages.ic_location,
                          locationController,
                          AppMessages.title_location +
                              " " +
                              AppMessages.title_name,
                          TextAlign.start),
                    )),
                Expanded(
                  child: Stack(
                    children: [
                      GoogleMap(
                        myLocationEnabled: true,
                        initialCameraPosition: _cameraPosition,
                        onMapCreated: (GoogleMapController controller) {
                          _controller = (controller);
                          _controller.animateCamera(
                              CameraUpdate.newCameraPosition(_cameraPosition));
                          print("_cameraPosition-> $_cameraPosition");
                        },
                        onCameraMove: _onCameraMove,
                      ),
                      Positioned(
                        child: Center(
                          child: Center(
                              child: Image.asset(
                            AppImages.ic_location_marker,
                            height: 65,
                            width: 65,
                          )),
                        ),
                      ),
                      Positioned(
                          bottom: 30,
                          left: 60,
                          right: 60,
                          child: Consumer<BusinessUserProvider>(
                              builder: (_, user, child) {
                            return GestureDetector(
                              onTap: () {
                                onClick();
                              },
                              child: GlobalView().buttonFilled(
                                  context, AppMessages.select_location_title),
                            );
                          })),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
            AppImages.marker_map_icon)
        .then((onValue) {
      pinLocationIcon = onValue;
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.latitude);
    print(position.longitude);
    latlong = new LatLng(position.latitude, position.longitude);
    lastMapPosition = latlong;
    _cameraPosition = CameraPosition(target: latlong, zoom: 14);
    print("_cameraPosition=-=-=-=>$_cameraPosition");
    if (_controller != null)
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: lastMapPosition, zoom: 14),
        ),
      );
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
  }

  void _onCameraMove(CameraPosition position) {
    lastMapPosition = position.target;
    print("Latitude-->> ${lastMapPosition.latitude}");
    print("Longitude-->> ${lastMapPosition.longitude}");
  }

  void onClick() {
    var provider = Provider.of<BusinessUserProvider>(context, listen: false);
    if (widget.isTemp == true) {
      bool isAvailableData;
      if (provider.listLatLong != null && provider.listLatLong.length > 0) {
        for (var i = 0; i < provider.listLatLong.length; i++) {
          if ((double.parse(provider.listLatLong[i].latitude)
                      .toStringAsFixed(5) ==
                  lastMapPosition.latitude.toStringAsFixed(5)) ||
              (double.parse(provider.listLatLong[i].longitude)
                      .toStringAsFixed(5) ==
                  lastMapPosition.longitude.toStringAsFixed(5))) {
            isAvailableData = true;
          } else {
            isAvailableData = false;
          }
        }
      }
      if (isAvailableData == true) {
        GlobalView().showToast("Location is Available!");
      } else {
        if (locationController.text.isEmpty) {
          GlobalView().showToast("Please enter location name!");
        } else {
          provider.addBusinessLatlong(
            context,
            lastMapPosition.latitude.toStringAsFixed(5),
            lastMapPosition.longitude.toStringAsFixed(5),
            0,
      
            locationController.text,
            provider.businessUserProfileResponse.user.id.toString(),
          );
          Navigator.of(context).pop();
        }
      }
    } else {
      provider.setCenterLocation(
          lastMapPosition.latitude, lastMapPosition.longitude);
      Navigator.of(context).pop();
    }
  }
}

// class MapScreen extends StatelessWidget {
//   Completer<GoogleMapController> _controller = Completer();

//   static const LatLng _center = const LatLng(45.521563, -122.677433);
//   double _centerLatitude;
//   double _centerLongitude;
//   LatLng _lastMapPosition = _center;
//   void _onMapCreated(GoogleMapController controller) {
//     _controller.complete(controller);
//   }

//   void _onCameraMove(CameraPosition position) {
//     _lastMapPosition = position.target;
//     // print("Latitude-->> ${_lastMapPosition.latitude}");
//     // print("Longitude-->> ${_lastMapPosition.longitude}");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return
//         // Container(
//         //   color: BaseColor.pureWhiteColor,
//         //   child: SafeArea(
//         //     top: true,
//         //     bottom: true,
//         //     child:
//         Scaffold(
//       backgroundColor: BaseColor.pure_white_color,
//       body: Stack(
//         children: [
//           GoogleMap(
//             onMapCreated: _onMapCreated,
//             initialCameraPosition: CameraPosition(
//               target: _center,
//               zoom: 11.0,
//             ),
//             onCameraMove: _onCameraMove,
//           ),
//           Positioned(
//             child: Center(
//               child: Icon(
//                 Icons.location_on_outlined,
//                 color: Colors.red,
//                 size: 50,
//               ),
//             ),
//           ),
//           Positioned(
//               bottom: 30,
//               left: 60,
//               right: 60,
//               child: Consumer<BusinessUserProvider>(builder: (_, user, child) {
//                 return GestureDetector(
//                   onTap: () {
//                     _centerLatitude = _lastMapPosition.latitude;
//                     _centerLongitude = _lastMapPosition.longitude;
//                     print("centerLatitude-> $_centerLatitude");
//                     print("centerLongitude-> $_centerLongitude");
//                     print("CITY-->> ${_lastMapPosition.latitude}");
//                     Provider.of<BusinessUserProvider>(context, listen: false)
//                         .setCenterLocation(_lastMapPosition.latitude,
//                             _lastMapPosition.longitude);
//                     Navigator.pop(context);
//                   },
//                   child: GlobalView()
//                       .buttonFilled(context, AppMessages.select_location_title),
//                 );
//               })),
//         ],
//       ),
//       //   ),
//       // ),
//     );
//   }
// }

// return FlutterMap(
//       options: MapOptions(
//         center: LatLng(21.1702, 72.8311),
//         zoom: 13.0,
//       ),
//       layers: [
//         TileLayerOptions(
//             urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//             subdomains: ['a', 'b', 'c']),
//         MarkerLayerOptions(
//           markers: [
//             Marker(
//               width: 80.0,
//               height: 80.0,
//               point: LatLng(21.1702, 72.8311),
//               builder: (ctx) => Container(
//                 child: Icon(
//                   Icons.location_on_outlined,
//                   color: Colors.red,
//                   size: 70,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
