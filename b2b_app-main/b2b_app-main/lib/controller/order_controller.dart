import 'dart:convert' show json, jsonEncode;

import 'package:b2b_app/controller/cart_controller.dart';
import 'package:b2b_app/models/command_model.dart';
import 'package:b2b_app/utils/const_string.dart';
import 'package:b2b_app/utils/snack_bar_error.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/order_model.dart';

class OrderController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var orderHistory = <OrderModel>[].obs;
  var hasNext = false.obs;
  var orderDetail = <OrderModel>[].obs;

  final CartController cartController = Get.put(CartController());
  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> getAllOrder({
    int page = 1,
    int pageSize = 10,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    String? keyword,
  }) async {
    try {
      isLoading.value = true;
      final String? token = await getToken();

      if (token == null) {
        errorMessage.value = "Jeton d'authentification manquant.";
        return;
      }

      final Map<String, String> queryParams = {
        'page': page.toString(),
        'pageSize': pageSize.toString(),
        'order': 'DESC',
      };

      if (startDate != null) {
        queryParams['startDate'] = startDate.toIso8601String().split('T').first;
      }

      if (endDate != null) {
        queryParams['endDate'] = endDate.toIso8601String().split('T').first;
      }

      if (status != null && status.isNotEmpty) {
        queryParams['status'] = status;
      }
      if (keyword != null) {
        queryParams['keyword'] = keyword;
      }

      final uri = Uri(
        scheme: BASE_SCHEME,
        host: BASE_HOST,
        port: BASE_PORT,
        path: "$API_PREFIX/commands",
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

        final List<dynamic> data = jsonResponse['result'] ?? [];
        final bool next = jsonResponse['hasNext'] ?? false;

        if (page == 1) {
          orderHistory.value = data.map((e) => OrderModel.fromJson(e)).toList();
        } else {
          orderHistory.addAll(data.map((e) => OrderModel.fromJson(e)).toList());
        }

        hasNext.value = next;
        errorMessage.value = '';
      } else if (response.statusCode == 401) {
        SnackbarError.showError(
          "Erreur d'authentification",
          "Session expirée. Redirection vers la connexion...",
        );
      } else {
        errorMessage.value =
            "Impossible de récupérer l'historique de vos commandes pour le moment.";
      }
    } catch (e) {
      print("Erreur lors du chargement de l'historique des commandes: $e");
      errorMessage.value =
          "Une erreur s'est produite, veuillez réessayer plus tard.";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getOrderDetails({
    int page = 1,
    int pageSize = 1,
    String? keyword,
  }) async {
    try {
      isLoading.value = true;
      final String? token = await getToken();

      if (token == null) {
        errorMessage.value = "Authentification échouée  jeton non trouvé.";
        return;
      }

      final Map<String, String> queryParams = {
        'page': page.toString(),
        'pageSize': pageSize.toString(),
        'order': 'DESC',
      };
      if (keyword != null && keyword.trim().isNotEmpty) {
        queryParams['keyword'] = keyword.trim();
      }

      final uri = Uri(
        scheme: BASE_SCHEME,
        host: BASE_HOST,
        port: BASE_PORT,
        path: "$API_PREFIX/commands",
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
        final List<dynamic> data = jsonResponse['result'] ?? [];

        orderDetail.value = data.map((e) => OrderModel.fromJson(e)).toList();
        errorMessage.value = '';
      } else if (response.statusCode == 401) {
        SnackbarError.showError(
          "Erreur d'authentification",
          "Votre session a expiré. Veuillez vous reconnecter.",
        );
      } else {
        errorMessage.value =
            "Nous n'avons pas pu charger vos commandes. Veuillez réessayer ultérieurement.";
      }
    } catch (e) {
      print("Erreur lors du chargement de l’historique des commandes : $e");
      errorMessage.value =
          "Une erreur inattendue est survenue. Merci de réessayer dans quelques instants.";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> placeOrder(CommandModel commandModel) async {
    isLoading.value = true;
    try {
      final String? token = await getToken();

      if (token == null) {
        errorMessage.value = "Authentification échouée : jeton non trouvé.";
        SnackbarError.showError(
          "Erreur d'authentification",
          "Votre session a expiré. Veuillez vous reconnecter.",
        );
        return;
      }

      final uri = Uri(
        scheme: BASE_SCHEME,
        host: BASE_HOST,
        port: BASE_PORT,
        path: "$API_PREFIX/commands",
      );

      final res = await http.post(
        uri,
        body: jsonEncode(commandModel.toJson()),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (res.statusCode == 201) {
        print("Order placed successfully");
        SnackbarError.showSuccess(
          "Commande réussie",
          "Votre commande a été passée avec succès.",
        );
        cartController.clearCart();
      } else if (res.statusCode == 401) {
        SnackbarError.showError(
          "Erreur d'authentification",
          "Session expirée. Redirection vers la connexion...",
        );
      } else if (res.statusCode == 400) {
        SnackbarError.showError(
          "Certains produits de votre panier sont en rupture de stock.",
          " Veuillez les vérifier avant de commander.",
        );
        print("Response: ${res.body}, ${res.statusCode}");
      } else {
        errorMessage.value =
            "Une erreur est survenue. Veuillez réessayer plus tard.";
        SnackbarError.showError(
          "Une erreur est survenue.",
          "Veuillez réessayer plus tard.",
        );
        print("Response: ${res.body}, ${res.statusCode}");
      }
    } catch (e) {
      errorMessage.value = "Error while placing order: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
