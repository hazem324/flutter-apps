
import 'message_model.dart';

class ConversationModel {
  String? id;
  String? client;
  String? livreur;
  List<MessageModel>? messages;

  ConversationModel({
    this.id,
    this.client,
    this.livreur,
    this.messages,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['_id'],
      client: json['client'] ?? '',
      livreur: json['livreur'] ?? '',
      messages: json['messages'] != null
          ? (json['messages'] as List)
              .map((messageJson) => MessageModel.fromJson(messageJson))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'client': client,
      'livreur': livreur,
      'messages': messages?.map((message) => message.toJson()).toList(),
    };
  }
}
