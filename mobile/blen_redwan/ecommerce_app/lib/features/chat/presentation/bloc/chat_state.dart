import 'package:equatable/equatable.dart';
import '../../domain/entities/message.dart';

class ChatState extends Equatable {
  final bool loading;
  final String? error;
  final List<Message> messages;
  final List<dynamic> chats;

  const ChatState({
    this.loading = false,
    this.error,
    this.messages = const [],
    this.chats = const [],
  });

  ChatState copyWith({
    bool? loading,
    String? error,
    List<Message>? messages,
    List<dynamic>? chats,
  }) {
    return ChatState(
      loading: loading ?? this.loading,
      error: error,
      messages: messages ?? this.messages,
      chats: chats ?? this.chats,
    );
  }

  @override
  List<Object?> get props => [loading, error ?? '', messages, chats];
}
