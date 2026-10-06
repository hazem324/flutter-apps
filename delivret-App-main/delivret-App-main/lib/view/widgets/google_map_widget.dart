import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:deliveryapp/controller/orders_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../model/orderInfo_model.dart';
import 'custom_tost_widget.dart';
import 'info_window_widget.dart';

class MapWidget extends StatefulWidget {
  @override
  MapWidgetState createState() => MapWidgetState();

  final LatLng livreurLocation;
  final Completer<GoogleMapController> mapController;
  final List<OrderInfo> orderInfoList;

  MapWidget({
    required this.mapController,
    required this.livreurLocation,
    required this.orderInfoList,
  });
}

class MapWidgetState extends State<MapWidget> {
  static const LatLng center = LatLng(35.5663582, 11.0168649);
  OrderController orderController = Get.put(OrderController());
  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();
  final tost = FToast();

  @override
  void initState() {
    super.initState();
    tost.init(context);
  }

  @override
  void dispose() {
    customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('+88888888888888++++++++++++++++++++++++++++${widget.orderInfoList}');
    return Stack(children: [
      GoogleMap(
        initialCameraPosition:
            CameraPosition(target: widget.livreurLocation, zoom: 2),
        onMapCreated: (GoogleMapController controller) {
          customInfoWindowController.googleMapController = controller;
        },
        markers: buildMarkersFromOrders(widget.orderInfoList),
        onTap: (LatLng latLng) {
          customInfoWindowController.hideInfoWindow!();
        }, // Use the helper function
      ),
      CustomInfoWindow(
        controller: customInfoWindowController,
        height: 180,
        width: 230,
        offset: 50,
      ),
    ]);
  }

  Set<Marker> buildMarkersFromOrders(List<OrderInfo> orders) {
    final Set<Marker> markers = {};

    // Add the livreur location marker (assuming it's not in orderInfoList)
    markers.add(
      Marker(
        markerId: const MarkerId('currentLocation'),
        infoWindow: const InfoWindow(title: 'Your current Location'),
        position: widget.livreurLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    );

    if (orders.isEmpty) {
      return markers;
    }
    for (final order in orders) {
      // ignore: unnecessary_null_comparison
      if (order.latitude != null && order.longitude != null) {
        markers.add(
          Marker(
            anchor: const Offset(0.5, 1.0),
            markerId: MarkerId(order.id),
            position: LatLng(order.latitude, order.longitude),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            onTap: () async {
              await Future.delayed(const Duration(milliseconds: 200));
              print('custom window******');
              customInfoWindowController.addInfoWindow!(
                InfoWindowWidget(
                  name: order.id,
                  clientName: order.clientName,
                  phone: order.clientPhone,
                  status: order.status,
                  function: () async => updateStatus(order.id),
                ),
                LatLng(order.latitude, order.longitude),
              );
            },
          ),
        );
      } else {
        //  print('Order ${order.orderId} is missing location data.');
      }
    }
    return markers;
  }

  Future updateStatus(String id) async {
    var status = await orderController.changeOrderStatus(id);
    if (status == 200) {
      tost.showToast(
          child: CustomTostWidget(text: "Status updated"),
          gravity: ToastGravity.BOTTOM);
    } else if(status == 403){
      tost.showToast(
          child: CustomTostWidget(text: "Order delivred"),
          gravity: ToastGravity.BOTTOM);
    } else {
       tost.showToast(
          child: CustomTostWidget(text: "Unexpected status value"),
          gravity: ToastGravity.BOTTOM);
    }
  }
}
