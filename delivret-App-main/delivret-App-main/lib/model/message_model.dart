class MessageModel {
  String? id;
  String? message;
  String? senderId;
  String? createdAt;
  String? conversation ;

  MessageModel({
    this.id,
    required this.message,
    required this.senderId,
    required this.createdAt,
    required this.conversation ,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        id: json['_id'],
        message: json["message"],
        senderId: json["senderId"],
        createdAt: json["createdAt"],
        conversation : json["conversation"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> messages = <String, dynamic>{};
    messages['message'] = this.message;
    messages['senderId'] = this.senderId;
    messages['createdAt'] = this.createdAt;
    messages['conversation'] = this.conversation ;
    return messages;
  }
}
