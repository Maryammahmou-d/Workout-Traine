class ChatModel {
  int id;
  String senderId;
  String? receiver;
  String? message;
  String createdAt;
  String updatedAt;

  ChatModel({
    required this.id,
    required this.senderId,
    this.receiver,
    this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      senderId: json['sender_id'].toString(),
      receiver: json['receiver'],
      message: json['message'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
