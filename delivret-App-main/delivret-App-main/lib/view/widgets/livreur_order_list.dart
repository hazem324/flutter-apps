import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controller/orders_controller.dart';
import '../../model/orderInfo_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/custom_navigation.dart';
import '../../utils/order_status_enum.dart';
import '../screen/map_screen.dart';
import '../screen/order_info_screen.dart';
import 'drop_down_widget.dart';
import 'livreur_order_container_widget.dart';

class LivreurOrderList extends StatefulWidget {
  @override
  LivreurOrderListState createState() => LivreurOrderListState();
}

class LivreurOrderListState extends State<LivreurOrderList> {
  bool startAnimation = false;
  String status = 'All';
  OrderController orderController = Get.put(OrderController());
  List<LatLng> convertedAddresses = [];
  List<String> address = [];
  List<String> orderId = [];
  List<String> coord = [];
  List<String> colisNames = [];
  List<String> clientNames = [];
  List<String> clientPhones = [];
  List<String> statuses = [];
  List<OrderInfo> orderInfoList = [];

  @override
  void initState() {
    super.initState();
    orderController.getOrderByLivreur(status);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
    //  _performGeocoding();
  }

  @override
  Widget build(BuildContext context) {
    address.clear();
    clientNames.clear();
    clientPhones.clear();
    statuses.clear();
    orderInfoList.clear();

    orderController.orderLivreurtList.forEach((order) {
      var departureAddress = order.departureAddress;
      var deliveryAddress = order.deliveryAddress;
      var orderclient = order.client;

      String orderAddress = order.status == 0
          ? '${departureAddress!.street} ${departureAddress.postalCode} ${departureAddress.city} ${departureAddress.state}'
          : '${deliveryAddress!.street} ${deliveryAddress.postalCode} ${deliveryAddress.city} ${deliveryAddress.state}';

      address.add(orderAddress);
      orderId.add(order.id ?? "");
      clientNames.add(orderclient.nom ?? "");
      clientPhones.add(orderclient.phoneNum.toString());
      statuses.add(Status.orderStatus(order.status));
    });
    return Scaffold(
      backgroundColor: AppColors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        highlightElevation: 50,
        child: const Icon(Icons.map_outlined, color: Colors.white, size: 25),
        onPressed: () async {
          await performGeocoding(address);
          Navigator.of(context).push(CustomPageTransition(
              child: MapScreen(
            orderInfoList: orderInfoList,
          )));
        },
      ),
      body: Obx(() {
        if (orderController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropDownButtonWidget(
                  selectedValue: status,
                  hintText: status,
                  items: const ["All", "Packaging", "In transit", "Delivered"],
                  itemSelect: (value) async {
                    status = value!;
                    print(status);
                    int val = getStatusInt(status);
                    await orderController.getOrderByLivreur("$val");
                    setState(() {});
                  },
                  width: 360,
                  height: 60,
                ),
              ),
              if (orderController.orderLivreurtList.isEmpty)
                SvgPicture.asset('assets/icons/Empty.svg'),
              if (orderController.orderLivreurtList.isNotEmpty)
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: initializeData,
                    child: ListView.builder(
                      itemCount: orderController.orderLivreurtList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var orderLivreurtList =
                            orderController.orderLivreurtList[index];
                        var departureAddress =
                            orderLivreurtList.departureAddress;
                        var deliveryAddress = orderLivreurtList.deliveryAddress;
                        var client = orderLivreurtList.client;

                        return GestureDetector(
                          onTap: () {
                         Navigator.of(context).push(CustomPageTransition(
                          child: OrderInfoScreen(
                             order: orderLivreurtList,
                          ),
                          direction: AxisDirection.up,
                        )); 
                          },
                          child: LivreurOrderContainerWidget(
                            detarturAddress:
                                '${departureAddress!.street}, ${departureAddress.city} ${departureAddress.postalCode}, ${departureAddress.state}',
                            livraisonAddress:
                                '${deliveryAddress!.street}, ${deliveryAddress.city} ${deliveryAddress.postalCode}, ${deliveryAddress.state}',
                            status:
                                Status.orderStatus(orderLivreurtList.status),
                            index: index + 1,
                            fullName: '${client.nom} ${client.prenom}',
                            phoneNumber: '${client.phoneNum}',
                          ),
                        );
                      },
                    ),
                  ),
                ),
            ],
          );
        }
      }),
    );
  }

  int getStatusInt(String status) {
    switch (status) {
      case "Packaging":
        return 1;
      case "In transit":
        return 2;
      case "Delivered":
        return 3;
      default:
        throw Exception('Invalid status : ');
    }
  }

  Future<void> initializeData() async {
    await orderController.getOrderByLivreur(status);
    setState(() {
      startAnimation = true;
    });
  }

// geocoding

  Future<void> performGeocoding(List<String> addresses) async {
    print("addres list : $address");
    try {
      for (int i = 0; i < addresses.length; i++) {
        String address = addresses[i];
        List<Location> locations = await locationFromAddress(address);
        if (locations.isNotEmpty) {
          if (i < clientNames.length &&
              i < clientPhones.length &&
              i < statuses.length) {
            Location location = locations[0];
            print(
                'Latitude: ${location.latitude}, Longitude: ${location.longitude}');
            coord.add("${location.latitude}, ${location.longitude}");
            OrderInfo orderInfo = OrderInfo(
              latitude: location.latitude,
              longitude: location.longitude,
              clientName: clientNames[i],
              clientPhone: clientPhones[i],
              status: statuses[i], 
              id:orderId[i],
            );
            orderInfoList.add(orderInfo);
            print("++++++++++ $coord");
            print("Order Info List:");
            print(
                "Latitude: ${orderInfo.latitude}, Longitude: ${orderInfo.longitude}");
            print("Client Name: ${orderInfo.clientName}");
            print("Client Phone: ${orderInfo.clientPhone}");
            print("Status: ${orderInfo.status}");
            print("Status: ${orderInfo.id}");
            print(
                "--------------------------------------------------------------");
          } else {
            print(
                'Index out of bounds for clientNames, clientPhones, or statuses lists');
          }
        } else {
          print('No locations found for the address: $address');
        }
      }
    } catch (e) {
      print("Geocoding error: $e");
    }
  }
}
