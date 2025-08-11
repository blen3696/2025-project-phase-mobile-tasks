import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/chat_repository.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository repo;
  StreamSubscription<Message>? _receivedSub;
  StreamSubscription<Message>? _deliveredSub;

  ChatBloc(this.repo) : super(const ChatState()) {
    on<ChatConnectRequested>(_onConnectRequested);
    on<LoadChatsRequested>(_onLoadChatsRequested);
    on<SendMessageRequested>(_onSendMessageRequested);
    on<IncomingMessageEvent>(_onIncomingMessage);
    on<DeliveredMessageEvent>(_onDeliveredMessage);
  }

  Future<void> _onConnectRequested(
    ChatConnectRequested event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      await repo.connectSocket();

      _receivedSub?.cancel();
      _deliveredSub?.cancel();

      _receivedSub = repo.onMessageReceived.listen((message) {
        add(IncomingMessageEvent(message));
      });

      _deliveredSub = repo.onMessageDelivered.listen((message) {
        add(DeliveredMessageEvent(message));
      });

      emit(state.copyWith(loading: false));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _onLoadChatsRequested(
    LoadChatsRequested event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final chats = await repo.getChats();
      emit(state.copyWith(loading: false, chats: chats));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _onSendMessageRequested(
    SendMessageRequested event,
    Emitter<ChatState> emit,
  ) async {
    try {
      final tempMessage = Message(
        id: 'temp_${DateTime.now().millisecondsSinceEpoch}',
        content: event.content,
        type: 'text',
        senderId: '',
        chatId: event.chatId,
      );
      final newList = List<Message>.from(state.messages)..add(tempMessage);
      emit(state.copyWith(messages: newList));

      repo.sendMessage(event.chatId, event.content);
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  void _onIncomingMessage(IncomingMessageEvent event, Emitter<ChatState> emit) {
    final updated = List<Message>.from(state.messages)..add(event.message);
    emit(state.copyWith(messages: updated));
  }

  void _onDeliveredMessage(
    DeliveredMessageEvent event,
    Emitter<ChatState> emit,
  ) {
    final exists = state.messages.any(
      (m) => m.id == event.message.id || m.content == event.message.content,
    );
    if (!exists) {
      final updated = List<Message>.from(state.messages)..add(event.message);
      emit(state.copyWith(messages: updated));
    }
  }

  @override
  Future<void> close() {
    _receivedSub?.cancel();
    _deliveredSub?.cancel();
    return super.close();
  }
}
