import '../entities/message.dart';

abstract class ChatRepository {
  Future<void> connectSocket();
  void sendMessage(String chatId, String content);
  Stream<Message> get onMessageDelivered;
  Stream<Message> get onMessageReceived;
  Future<List<dynamic>> getChats();
}
