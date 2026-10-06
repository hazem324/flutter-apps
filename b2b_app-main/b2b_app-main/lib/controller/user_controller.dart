import 'dart:convert';
import 'package:b2b_app/utils/const_string.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


import '../utils/snack_bar_error.dart';

class UserController extends GetxController {
  var isLoged = false.obs;
  var errorMessage = ''.obs;
  
  var clientData = {}.obs;
  var isLoading = false.obs;
  
Future<void> loginUser(String username, String password) async {
 final SharedPreferences prefs = await SharedPreferences.getInstance();
  isLoading.value = true;

  try {
    final loginBody = {
      "username": username,
      "password": password,
    };

    final response = await http.post(
      Uri.parse('$BASE_URL/auth-client/signin'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(loginBody),
    );

    print('login response: ${response.body}, status: ${response.statusCode}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);

      if (data.containsKey('access_token') && data.containsKey('client')) {
        clientData.value = data['client'];
        isLoged.value = true;
        errorMessage.value = '';

        SnackbarError.showSuccess(
          "Connexion réussie",
          "Bienvenue ${data['client']['fullName'] ?? ''} !",
        );
        await prefs.setString('auth_token',  data['access_token']);
         await prefs.setString('client_data', jsonEncode(data['client']));
      } else {
        isLoged.value = false;
        errorMessage.value = "Données de réponse invalides";
        SnackbarError.showError("Erreur", errorMessage.value);
      }
    } else if (response.statusCode == 401) {
      errorMessage.value = "Identifiants incorrects. Veuillez réessayer.";
      isLoged.value = false;
      SnackbarError.showError("Échec de connexion", errorMessage.value);
    } else {
      errorMessage.value = "Erreur inconnue";
      SnackbarError.showError("Erreur", errorMessage.value);
    }
  } catch (e) {
    errorMessage.value = 'Connexion échouée, veuillez réessayer plus tard.';
    isLoged.value = false;
    SnackbarError.showError("Erreur réseau", errorMessage.value);
    print("Exception during login: $e");
  } finally {
    isLoading.value = false;
  }
}
}
