import '../../domain/entities/message.dart';
import '../datasources/chat_remote_data_source.dart';
import '../../domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource dataSource;

  ChatRepositoryImpl(this.dataSource);

  @override
  Future<void> connectSocket() => dataSource.connectSocket();

  @override
  void sendMessage(String chatId, String content) =>
      dataSource.sendMessage(chatId, content);

  @override
  Stream<Message> get onMessageDelivered => dataSource.onMessageDelivered;

  @override
  Stream<Message> get onMessageReceived => dataSource.onMessageReceived;

  @override
  Future<List<dynamic>> getChats() => dataSource.fetchChats();
}
