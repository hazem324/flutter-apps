import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http ;

import '../models/supplier_model.dart';
import '../utils/const_string.dart';

class SupplierController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var suppliers = <SupplierModel>[].obs;

  Future<void> getSuppliers() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await http.get(Uri.parse("$BASE_URL/suppliers/from-product-filters"));
      

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List) {
          suppliers.assignAll(
            List<SupplierModel>.from(
              data.map((item) => SupplierModel.fromJson(item)),
            ),
          );
         
        } else {
          errorMessage.value = "Une erreur s'est produite, veuillez réessayer plus tard"; 
        }
      } else {
        errorMessage.value =
            "Une erreur s'est produite, veuillez réessayer plus tard";
       
      }
    } catch (e) {
      errorMessage.value =
          "Une erreur s'est produite, veuillez réessayer plus tard";
      
    } finally {
      isLoading.value = false;
    }
  }
}