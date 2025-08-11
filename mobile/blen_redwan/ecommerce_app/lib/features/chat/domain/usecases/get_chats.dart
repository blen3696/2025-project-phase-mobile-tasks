import '../repositories/chat_repository.dart';

class GetChats {
  final ChatRepository repository;
  GetChats(this.repository);
  Future<List<dynamic>> call() => repository.getChats();
}
