// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:deliveryapp/utils/const_string.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegionController extends GetxController {
  var regionNames = <String>[].obs;
  var delegationName = <String>[].obs;
   var delegationLivName = <String>[].obs;

  Future<void> getRegionNames() async {
    try {
      var response = await http.get(Uri.parse("$BaseUrl/region/names"));
      if (response.statusCode == 200) {
        final List<String> res = List<String>.from(jsonDecode(response.body));
        print('Regions names: $res');
        regionNames.assignAll(res);
      } else {
        print(
            "Failed to get region names. Status code: ${response.statusCode}, Body: ${response.body}");
      }
    } catch (e) {
      print("Error fetching region names: $e");
    }
  }

  Future<void> getDelegationsNames(String name) async {
    print("");
    try {
      var response =
          await http.get(Uri.parse("$BaseUrl/region/delegation/$name"));
      if (response.statusCode == 200) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        print('Regions delegation: $res');
        final List<dynamic> delegations = res['Delegations'];
        delegationName.value = delegations.cast<String>().toList();
        print(" delegationName.value ==== $delegationName");
      } else {
        print(
            "Failed to get delegation names. Status code: ${response.statusCode}, Body: ${response.body}");
      }
    } catch (e) {
      print("Error fetching delegation names: $e");
    }
  }
  Future<void> getLivDelegationsNames(String name) async {

    print("");
    try {
      var response =
          await http.get(Uri.parse("$BaseUrl/region/delegation/$name"));
      if (response.statusCode == 200) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        print('Regions delegation: $res');
        final List<dynamic> delegations = res['Delegations'];
        delegationLivName.value = delegations.cast<String>().toList();
        print(" delegationName.value ==== $delegationName");
      } else {
        print(
            "Failed to get delegation names. Status code: ${response.statusCode}, Body: ${response.body}");
      }
    } catch (e) {
      print("Error fetching delegation names: $e");
    }
  }
}
