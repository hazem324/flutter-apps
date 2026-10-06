import 'dart:convert';
import 'package:b2b_app/models/product_model.dart';
import 'package:b2b_app/utils/const_string.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/donnee_model.dart';
import '../utils/snack_bar_error.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var isFiltering = false.obs;
  var errorMessage = "".obs;
  var products = <ProductModel>[].obs;
 var product = Rxn<ProductModel>();
 var hasNext = false.obs;
var relatedProducts = <ProductModel>[].obs;
var stockList = <DonneeModel>[].obs;

Future<String?> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return  prefs.getString('auth_token');
}

Future<void> getStockData() async {
  final String? token = await getToken();
  try {
    const uriData = "http://197.5.192.95:3000/api/STOCK/DONNEE_2025";
    print("Final URL data: $uriData");

    final stockResponse = await http
        .get(
          Uri.parse(uriData),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Connection': 'keep-alive',
            'Authorization': 'Bearer $token',
          },
        )
        .timeout(const Duration(seconds: 60));

    print("Stock API status code: ${stockResponse.statusCode}");

    if (stockResponse.statusCode == 200) {
      final stockJson = json.decode(stockResponse.body);
      stockList.assignAll(
        (stockJson as List).map((e) => DonneeModel.fromJson(e)).toList(),
      );
      print("Stock list updated: ${stockList.length} items");
    } else {
      print("Stock API failed with status: ${stockResponse.statusCode}");
    }
  } catch (e) {
    print("Erreur lors de la récupération du stock: $e");
  }
}

Future<void> getAllProducts({
  int page = 1,
  int pageSize = 15,
  String order = "DESC",
  String? keyword,
  double? minPrice,
  double? maxPrice,
  List<String>? makes,
  List<String>? suppliers,
  bool append = false,
  String? status,
  bool isFilterRequest = false,
}) async {
  try {
    if (isFilterRequest) {
      isFiltering.value = true;
      print("Filtering started");
    } else {
      isLoading.value = true;
      print("Loading started");
    }

    final String? token = await getToken();
    if (token == null) {
      errorMessage.value = "Aucun jeton d'authentification trouvé";
      return;
    }

  
    if (stockList.isEmpty) {
      await getStockData();
    }

    final queryParams = <String, dynamic>{
      'page': page.toString(),
      'pageSize': pageSize.toString(),
      'order': order,
      if (status != null) 'status': status,
      if (keyword != null) 'keyword': keyword,
      if (minPrice != null) 'minPrice': minPrice.toString(),
      if (maxPrice != null) 'maxPrice': maxPrice.toString(),
      if (makes != null) 'makes': makes,
      if (suppliers != null) 'suppliers': suppliers,
    };

    final uri = Uri(
      scheme: BASE_SCHEME,
      host: BASE_HOST,
      port: BASE_PORT,
      path: "$API_PREFIX/products",
      queryParameters: queryParams,
    );

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List<ProductModel> newProducts = (jsonResponse['result'] as List)
          .map<ProductModel>((item) => ProductModel.fromJson(item))
          .toList();

      
      final stockMap = {for (var s in stockList) s.ref: s.stock};
      newProducts = newProducts.map((p) {
        final stockValue = stockMap[p.id];
        return ProductModel(
          id: p.id,
          isActive: p.isActive,
          remise: p.remise,
          prixHt: p.prixHt,
          colisage: p.colisage,
          prixTtc: p.prixTtc,
          designation: p.designation,
          tva: p.tva,
          status: p.status,
          supplierId: p.supplierId,
          categoryId: p.categoryId,
          quantity: (stockValue is num) ? stockValue.toInt() : 0,
          applications: p.applications,
          oemMakes: p.oemMakes,
          supplier: p.supplier,
          file: p.file,
        );
      }).toList();

      if (append) {
        products.addAll(newProducts);
      } else {
        products.assignAll(newProducts);
      }

      errorMessage.value = '';
    } else if (response.statusCode == 401) {
      SnackbarError.showError(
        "Erreur d'authentification",
        "Session expirée. Redirection vers la connexion...",
      );
    } else {
      errorMessage.value =
          "Une erreur s'est produite, veuillez réessayer plus tard";
    }
  } catch (e) {
    print("Erreur lors de la récupération des produits: $e");
    errorMessage.value =
        "Une erreur s'est produite, veuillez réessayer plus tard";
  } finally {
    if (isFilterRequest) {
      isFiltering.value = false;
      print("Filtering ended");
    } else {
      isLoading.value = false;
      print("Loading ended");
    }
  }

}

  Future<void> getProduct({required String id}) async {
  try {
    isLoading.value = true;

    final String? token = await getToken();
    if (token == null) {
      errorMessage.value = "Aucun jeton d'authentification trouvé";
      return;
    }

    
    if (stockList.isEmpty) {
      await getStockData();
    }

    final encodedId = Uri.encodeComponent(id);
    final uri = Uri(
      scheme: BASE_SCHEME,
      host: BASE_HOST,
      port: BASE_PORT,
      path: "$API_PREFIX/products/$encodedId",
    );

    print("Product Final URL: $uri");

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      ProductModel p = ProductModel.fromJson(jsonResponse);

    
      final stockMap = {for (var s in stockList) s.ref: s.stock};
      final stockValue = stockMap[p.id];

      p = ProductModel(
        id: p.id,
        isActive: p.isActive,
        remise: p.remise,
        prixHt: p.prixHt,
        colisage: p.colisage,
        prixTtc: p.prixTtc,
        designation: p.designation,
        tva: p.tva,
        status: p.status,
        supplierId: p.supplierId,
        categoryId: p.categoryId,
        quantity: (stockValue is num) ? stockValue.toInt() : 0,
        applications: p.applications,
        oemMakes: p.oemMakes,
        supplier: p.supplier,
        file: p.file,
      );

      product.value = p;
      print("Product loaded with stock: ${product.value}");
    } else if (response.statusCode == 401) {
      SnackbarError.showError(
        "Erreur d'authentification",
        "Session expirée. Redirection vers la connexion...",
      );
    } else {
      errorMessage.value = "Erreur lors du chargement du produit";
    }
  } catch (e) {
    print("Erreur lors de la récupération du produit: $e");
    errorMessage.value =
        "Une erreur s'est produite, veuillez réessayer plus tard";
  } finally {
    isLoading.value = false;
  }
}



Future<void> getRelatedPRoduct ({required String id,  int page = 1,}) async {
       
    try{
         final encodedId = Uri.encodeComponent( id,); 
           final String? token = await getToken();
         final uri = Uri(
        scheme: BASE_SCHEME,
        host: BASE_HOST,
        port: BASE_PORT,
        path: "$API_PREFIX/products/$encodedId/related",
        queryParameters: {
    'page': "$page",
    'pageSize': '20',
    'order': 'DESC',
  },
      );

        
      print("product related Final URL: $uri");

      final response = await http.get(
        uri, 
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200){
        final jsonResponse = json.decode(response.body);

    relatedProducts.value =   (jsonResponse['result'] as List)
            .map<ProductModel>((item) => ProductModel.fromJson(item))
            .toList(); 
         hasNext.value= jsonResponse['hasNext'];
      print("has next page ${hasNext.value}");
      print("Product loaded: ${relatedProducts.length}");
    } else if (response.statusCode == 401) {
        SnackbarError.showError(
          "Erreur d'authentification",
          "Session expirée. Redirection vers la connexion...",
        );
      } else {
        errorMessage.value = "Erreur lors du chargement du produit";
      }
    } catch (e) {
      print("Erreur lors de la récupération du produit: $e");
      errorMessage.value =
          "Une erreur s'est produite, veuillez réessayer plus tard";
    } finally {
      isLoading.value = false;
    }

}


}
