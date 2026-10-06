// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:deliveryapp/model/order_model.dart';
import 'package:deliveryapp/utils/const_string.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrderController extends GetxController {
  var orderList = <OrderModel>[].obs;
  var isLoading = false.obs;
  var loading = false.obs;
  var orderLivreurtList = <OrderModel>[].obs;
  var orderClientList = <OrderModel>[].obs;
  var allOrderList = <OrderModel>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    getOrders();
    // getOrderByUser();
    getAllOrder();
  }

  Future<void> createOrder(OrderModel orderModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var body = json.encode(orderModel.toJson());
    var token = prefs.getString("token") ?? "";
    var header = {
      'Content-Type': 'application/json',
      //'Authorization': 'Bearer $token',
    };
    print("token to create order is $token");
    try {
      var response = await http.post(Uri.parse("$BaseUrl/order/add"),
          headers: header, body: body);
      if (response.statusCode == 201) {
        print("add order successfully");
      } else {
        print("status code error is ${response.statusCode}, ${response.body}");
      }
    } catch (e) {
      print('Error while send data is $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAllOrder() async {
    try {
      final response = await http.get(Uri.parse('$BaseUrl/order/'));
      print('$BaseUrl/order/');
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body);
        print('get all orders ');
        allOrderList.value = result.map((e) => OrderModel.fromJson(e)).toList();
        update();
      } else {
        print("status code getall orders error is ${response.statusCode}");
      }
    } catch (e) {
      print("error while getall order  $e");
    }
  }

  Future<void> getOrderByClient() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("clientId");
    // var token = prefs.getString("token");

    try {
      final response = await http.get(
        Uri.parse("$BaseUrl/order/client/$userId"),
      );
      print("$BaseUrl/order/client/$userId");
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body) as List<dynamic>;
        print("////// result $result");
        orderClientList.value = result
            .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
            .toList();
        print("////// list ${orderClientList}");
        loading.value = false;
        print("orderuser list ${response.body}");
        print("orderuser list $orderClientList");
        update();
      } else {
        print("status code error is ${response.statusCode}");
      }
    } catch (e) {
      print("error while get order by user id $e");
    } finally {
      loading.value = false;
    }
  }

  Future<void> getOrderByLivreur(String status) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString("clientId");

  try {
    final response = await http.get( Uri.parse("$BaseUrl/order/livreur/$userId/$status"));
    print("$BaseUrl/order/livreur/$userId/$status");
    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(response.body) as List<dynamic>;
      print("////// result $result");
      orderLivreurtList.value = result
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList();
      print("////// list ${orderLivreurtList}");
      loading.value = false;
      print("orderuser list ${response.body}");
      print("orderuser list $orderLivreurtList");
      update();
    } else {
      print("status code error is ${response.statusCode}");
    }
  } catch (e) {
    print("error while get order by livreur id $e");
  } finally {
    loading.value = false;
  }
}


  Future<void> getOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    try {
      final response = await http.get(
        Uri.parse('$BaseUrl/order'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body);
        orderList.value = result.map((e) => OrderModel.fromJson(e)).toList();
        update();
        print('get all order ');
        isLoading.value = false;
        // update();
      } else {
        print("status code error is ${response.statusCode}");
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future deleteById(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    try {
      final response = await http.delete(
        Uri.parse('$BaseUrl/order/delet/$id'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body);

        print("delete list $result");
        return result;
      } else {
        print("delete status code ${response.statusCode}");
        print("delete status code ${response.body}");
      }
    } catch (e) {
      print('Error while getting data is $e');
    }
  }

  Future<void> upDateOrder(OrderModel orderModel, String id) async {
    try {
      var body = json.encode(orderModel.toJson());
      var header = {
        'Content-Type': 'application/json',
        //'Authorization': 'Bearer $token',
      };
      var response = await http.patch(Uri.parse("$BaseUrl/order/update/$id"),
          headers: header, body: body);

      if (response.statusCode == 200) {
        print("updated");
      } else {
        print("$BaseUrl/api/order/update/$id");
        print(
            'update order failed with status code is ${response.statusCode}   ${response.body}');
      }
    } catch (e) {
      print('Error while update addres data is $e');
    }
  }

  Future<int?> takeEnCharge(String livreurId, String id) async {
    try {
      var body = jsonEncode({"livreur": livreurId});
      var header = {
        'Content-Type': 'application/json',
        //'Authorization': 'Bearer $token',
      };
      var response = await http.patch(
          Uri.parse("$BaseUrl/order/takeInCharge/$id"),
          headers: header,
          body: body);

      if (response.statusCode == 200) {
        print("updated");

        return 200;
      } else {
        print("$BaseUrl/orderorder/takeInCharge/$id");
        print(
            'add livreur order failed with status code is ${response.statusCode}   ${response.body}');
        return 401;
      }
    } catch (e) {
      print('Error while add livreur is $e');
      return null;
    }
  }

  Future<int?> changeOrderStatus(String id) async {
    try {
      var res = await http.patch(Uri.parse("$BaseUrl/order/changeStatus/$id"));
      if (res.statusCode == 200) {
        print(" order change status${res.body}");
        return 200;
      } else if (res.statusCode == 403) {
        return 403;
      } else {
        return 500;
      }
    } catch (e) {
      print("change order status error $e");
    }
    return null;
  }
}
