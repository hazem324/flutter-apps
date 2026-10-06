import 'dart:async';

import 'package:deliveryapp/model/orderInfo_model.dart';
import 'package:deliveryapp/utils/app_colors.dart';
import 'package:deliveryapp/utils/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../widgets/google_map_widget.dart';

class MapScreen extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();

  final List<OrderInfo> orderInfoList;
  MapScreen({required this.orderInfoList});
}

class MapScreenState extends State<MapScreen> {
  
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  Location locationController = Location();
  static const LatLng mahdia = LatLng(35.5203341, 11.0329795);
  LatLng? curP;

  @override
  void initState() {
    super.initState();
    fetCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(iconTheme: const IconThemeData(color: AppColors.white),
          flexibleSpace: Container(decoration:
          const BoxDecoration(
           gradient:  LinearGradient(
                    colors: [AppColors.primary, AppColors.third],
                    end: Alignment.bottomCenter,
                    begin: Alignment.topCenter),
          )),),
      body: RefreshIndicator(
        onRefresh: () async {
          fetCurrentLocation();
          await Future.delayed(Duration(seconds: 1));
          setState(() {});
        },
        child: (curP == null)
            ? Center(
                child: Text(translation(context).is_loading),
              )
            : MapWidget(
                mapController: mapController,
                livreurLocation: curP!,
                orderInfoList: widget.orderInfoList,
              ),
      ),
    );
  }

  Future<void> cameraPosition(LatLng position) async {
    final GoogleMapController controller = await mapController.future;
    CameraPosition newCameraPosition =
        CameraPosition(target: position, zoom: 14);
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  Future<void> fetCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionStatus;
    serviceEnabled = await locationController.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await locationController.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    // Request permission to access the device's location
    permissionStatus = await locationController.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await locationController.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return;
      }
    }

    // Get the user's current location
    LocationData locationData = await locationController.getLocation();
    setState(() {
      curP = LatLng(locationData.latitude!, locationData.longitude!);
    });

    // Center the map on the user's location if available
    if (curP != null) {
      await cameraPosition(curP!);
    }
  }
}
