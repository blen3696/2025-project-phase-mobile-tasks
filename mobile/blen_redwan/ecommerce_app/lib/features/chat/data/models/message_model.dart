import '../../domain/entities/message.dart';

class MessageModel extends Message {
  MessageModel({
    required super.id,
    required super.content,
    required super.type,
    required super.senderId,
    required super.chatId,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    final id = json['_id'] ?? json['id'] ?? '';
    final content = json['content'] ?? '';
    final type = json['type'] ?? 'text';

    String senderId = '';
    if (json['sender'] is Map) {
      senderId = json['sender']['_id'] ?? json['sender']['id'] ?? '';
    } else if (json['sender'] is String) {
      senderId = json['sender'] as String;
    }

    String chatId = '';
    if (json['chat'] is Map) {
      chatId = json['chat']['_id'] ?? json['chat']['id'] ?? '';
    } else if (json['chat'] is String) {
      chatId = json['chat'] as String;
    } else if (json['chatId'] != null) {
      chatId = json['chatId'];
    }

    return MessageModel(
      id: id.toString(),
      content: content.toString(),
      type: type.toString(),
      senderId: senderId.toString(),
      chatId: chatId.toString(),
    );
  }

  factory MessageModel.fromMessage(Message m) {
    return MessageModel(
      id: m.id,
      content: m.content,
      type: m.type,
      senderId: m.senderId,
      chatId: m.chatId,
    );
  }

  Map<String, dynamic> toJson() {
    return {'content': content, 'type': type, 'chatId': chatId};
  }
}
