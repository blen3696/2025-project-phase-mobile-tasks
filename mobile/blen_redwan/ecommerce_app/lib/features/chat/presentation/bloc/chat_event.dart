import 'package:equatable/equatable.dart';
import '../../domain/entities/message.dart';

abstract class ChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatConnectRequested extends ChatEvent {}

class LoadChatsRequested extends ChatEvent {}

class SendMessageRequested extends ChatEvent {
  final String chatId;
  final String content;
  SendMessageRequested(this.chatId, this.content);
  @override
  List<Object?> get props => [chatId, content];
}

class IncomingMessageEvent extends ChatEvent {
  final Message message;
  IncomingMessageEvent(this.message);
  @override
  List<Object?> get props => [message];
}

class DeliveredMessageEvent extends ChatEvent {
  final Message message;
  DeliveredMessageEvent(this.message);
  @override
  List<Object?> get props => [message];
}
