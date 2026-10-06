import 'dart:convert';

import 'package:deliveryapp/model/conversation_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/message_model.dart';
import '../utils/const_string.dart';

class ChatController extends GetxController {
  var conversation = <ConversationModel>[].obs;
  bool conv = false;

  Future<int?> getConversation(String clientId, String livreurId) async {
    try {
      var result = await http
          .get(Uri.parse("$BaseUrl/conversation/$clientId/$livreurId"));

      if (result.statusCode == 200) {
        final List data = jsonDecode(result.body);
        print(data);
        conversation.value =
            data.map((e) => ConversationModel.fromJson(e)).toList();
        conv = true;
        update();
        print('++++++++++++++++++$conversation');
        return 200;
      } else if (result.statusCode == 201) {
        conv = true;
        update();
        return 201;
      } else {
        return 500;
      }
    } catch (e) {
      print("conversation api $e");
    }
    return 500;
  }

  Future<int?> sendMEssages(MessageModel messageModel) async {
    try {
      var body = json.encode(messageModel.toJson());
      var header = {
        'Content-Type': 'application/json',
      };
      var result = await http.post(Uri.parse("$BaseUrl/message"),
          headers: header, body: body);

      if (result.statusCode == 201) {
        print("message send");
        return 201;
      } else {
        print("error post message ${result.statusCode}");
        print(result.body);
        return 500;
      }
    } catch (e) {
      print("messsage post error $e");
    }
    return 500;
  }
}
