import '../repositories/chat_repository.dart';

class SendMessage {
  final ChatRepository repository;
  SendMessage(this.repository);
  void call(String chatId, String content) =>
      repository.sendMessage(chatId, content);
}
