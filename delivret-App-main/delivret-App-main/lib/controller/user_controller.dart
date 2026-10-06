// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:deliveryapp/utils/const_string.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

class UserController extends GetxController {
  ///
  final isLoading = RxBool(false);
  var userInfor = <UserModel>[].obs;

  Future<String?> login(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? user = prefs.getString('user');
    try {
      var body = jsonEncode({
        'email': email,
        'password': password,
      });
      final header = {
        'Content-Type': 'application/json',
      };
      final response = await http.post(Uri.parse('$BaseUrl/$user/login'),
          headers: header, body: body);
      print("$BaseUrl/$user/login");
      if (response.statusCode == 200) {
        print('login posted successfully');
        final data = jsonDecode(response.body);
        print(data);

        prefs.setString("clientId", data["data"]["_id"]);
        prefs.setString("token", data["token"]);
        return null; // No error, return null
      } else if (response.statusCode == 404) {
        return "User not found Create an account";
      } else if (response.statusCode == 401) {
        return "Wrong password";
      } else {
        print('Failed to login ${response.statusCode}');
        return "Failed to login: ${response.statusCode}";
      }
    } catch (e) {
      print("Login error is $e");
      return "Login error";
    }
  }

  Future<void> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? user = prefs.getString('user');
    var clientId = prefs.getString("clientId");

    try {
      final response = await http.get(Uri.parse("$BaseUrl/$user/$clientId"));

      if (response.statusCode == 200) {
        print("userinfo json body ${response.body}");
        final Map<String, dynamic> userData =
            jsonDecode(response.body); // Decode response body into a Map
        userInfor.value = [
          UserModel.fromJson(userData)
        ]; // Create a list with a single UserModel object

        print(" user lastName : ${userInfor[0].lastName}");
      } else {
        print('error wile get user ${response.statusCode}  ${response.body}');
      }
    } catch (e) {
      print('error wile get user1 $e');
    }
  }

  Future<int?> sendCode(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? user = prefs.getString('user');
    try {
      var body = jsonEncode({"email": email});
      final header = {
        'Content-Type': 'application/json',
      };

      var responce = await http.post(Uri.parse('$BaseUrl/$user/send'),
          body: body, headers: header);
      if (responce.statusCode == 200) {
        var res = jsonDecode(responce.body);
        print('code send: $res');
        return 200;
      } else if (responce.statusCode == 409) {
        print('user already exist');
        return 409;
      } else {
        print('error to send code with status code ${responce.statusCode}');
        return 500;
      }
    } catch (e) {
      print('error send mail $e');
    }
    return 500;
  }

  Future<int?> forgotPassword(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? user = prefs.getString('user');
    try {
      var body = jsonEncode({"email": email});
      final header = {
        'Content-Type': 'application/json',
      };

      var responce = await http.post(Uri.parse('$BaseUrl/$user/forgotPassword'),
          body: body, headers: header);
      if (responce.statusCode == 200) {
        var res = jsonDecode(responce.body);
        print('code send: $res');
        return 200;
      } else if (responce.statusCode == 404) {
        print('not ');
        return 404;
      } else {
        print('error to send code with status code ${responce.statusCode}');
      }
    } catch (e) {
      print('error send mail $e');
      return null;
    }
    return null;
  }

  Future<int?> resetPassword(String otp, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? user = prefs.getString('user');
    try {
      var body = jsonEncode({"otp": otp, "email": email});
      final header = {
        'Content-Type': 'application/json',
      };

      var responce = await http.post(Uri.parse('$BaseUrl/$user/resetPassword'),
          body: body, headers: header);
      if (responce.statusCode == 200) {
        var res = jsonDecode(responce.body);
        print('code send: $res');
        return 200;
      } else if (responce.statusCode == 400) {
        print('not ');
        return 400;
      } else {
        print('error to send code with status code ${responce.statusCode}');
      }
    } catch (e) {
      print('error send mail $e');
      return null;
    }
    return null;
  }

  Future<String?> signUp(UserModel userModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? user = prefs.getString('user');

    try {
      var body = jsonEncode(userModel.toJson());
      final header = {
        'Content-Type': 'application/json',
      };
      final response = await http.post(Uri.parse('$BaseUrl/$user/signup'),
          headers: header, body: body);
      if (response.statusCode == 200) {
        print("signup posted successfully");
        return 'signup successfully';
      } else {
        print(response.statusCode);
        print(response.body);
        print('Failed to signup');
        return 'Failed to signup';
      }
    } catch (e) {
      print("signup error is $e");
      return null;
    }
  }

  Future<void> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? user = prefs.getString('user');
    final String? token = prefs.getString('token');
    print("logout token is $token");
    try {
      final header = {
        'Authorization': 'Bearer $token',
      };

      final response =
          await http.post(Uri.parse("$BaseUrl/$user/logout"), headers: header);
      if (response.statusCode == 200) {
        print("logout posted successfully");
        final data = jsonDecode(response.body);
        prefs.setString("logout", data["message"]);
      } else {
        print("logout failed ${response.statusCode}");
      }
    } catch (e) {
      print("logout error is $e");
    }
  }

  Future<int?> changePassWord(String oldPassword, String newPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? user = prefs.getString('user');
    var clientId = prefs.getString("clientId");

    try {
      var body =
          jsonEncode({"oldPassword": oldPassword, "newPassword": newPassword});
      final header = {
        'Content-Type': 'application/json',
      };
      final response = await http.patch(
          Uri.parse("$BaseUrl/$user/password/$clientId"),
          headers: header,
          body: body);
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        print("body code change pass word is $res");
        return 200;
      } else {
        print("status code change pass word is ${response.statusCode}");
        var res = jsonDecode(response.body);
        print("body code change pass word is $res");
        return response.statusCode;
      }
    } catch (e) {
      print(" error while change passWord $e");
      return null;
    }
  }

  Future<int?> changePhoneNum(int numeroDeTelephone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? user = prefs.getString('user');
    var clientId = prefs.getString("clientId");

    try {
      var body = jsonEncode({
        'numeroDeTelephone': numeroDeTelephone,
      });
      final header = {
        'Content-Type': 'application/json',
      };
      final response = await http.patch(
          Uri.parse("$BaseUrl/$user/phonenumber/$clientId"),
          headers: header,
          body: body);
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        print("body code change pass word is $res");
        return 200;
      } else {
        print("status code change phone num is ${response.statusCode}");
        var res = jsonDecode(response.body);
        print("body code change phone numis $res");
        return response.statusCode;
      }
    } catch (e) {
      print(" error while change phone number $e");
      return null;
    }
  }

  Future<String?> uploadImage(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? user = prefs.getString('user');
    var clientId = prefs.getString("clientId");
    try {
      if (!File(imagePath).existsSync()) {
        print('File does not exist at path: $imagePath');
        return "l'image n'existe pas";
      }

      var request = http.MultipartRequest(
          "PATCH", Uri.parse("$BaseUrl/$user/image/$clientId"));

      final file = await http.MultipartFile.fromPath('image', imagePath);
      request.files.add(file);

      request.fields['image'] = 'some_value';

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody =
            await response.stream.transform(utf8.decoder).join();
        print('Image uploaded successfully: $responseBody');
        return "Image téléchargée avec succès";
      } else {
        print('Image upload failed with status code: ${response.statusCode}');
        // Update the UI with the error message
        return "Échec du téléchargement de l'image";
      }
    } catch (error) {
      print('Image upload failed with error: $error');
      // Update the UI with the error message
      return "télécharger à nouveau";
    }
  }
}
