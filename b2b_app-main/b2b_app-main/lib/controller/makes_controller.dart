import 'dart:convert';

import 'package:b2b_app/utils/const_string.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/makes_model.dart';

class MakesController extends GetxController {
  var isLoading = true.obs;
  var errorMessage = "".obs;
  var makes = <MakesModel>[].obs;

  Future getMakes() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await http.get(
        Uri.parse("$BASE_URL/makes/from-make-filters"),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List) {
          makes.assignAll(
            List<MakesModel>.from(
              data.map((item) => MakesModel.fromJson(item)),
            ),
          );
        }
        return data;
      } else {
        errorMessage.value =
            "Une erreur s'est produite, veuillez réessayer plus tard";
        print("error while get all  makes");
      }
    } catch (e) {
      errorMessage.value =
          "Une erreur s'est produite, veuillez réessayer plus tard";
      print("error while get all the makes $e");
    } finally {
      isLoading.value = false;
    } 
  }
}
