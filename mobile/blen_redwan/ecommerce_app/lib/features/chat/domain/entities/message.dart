class Message {
  final String id;
  final String content;
  final String type;
  final String senderId;
  final String chatId;

  Message({
    required this.id,
    required this.content,
    required this.type,
    required this.senderId,
    required this.chatId,
  });
}
