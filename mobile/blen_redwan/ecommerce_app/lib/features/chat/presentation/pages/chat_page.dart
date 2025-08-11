import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';
import '../widgets/message_bubble.dart';
import '../../domain/entities/chat.dart';

class ChatPage extends StatefulWidget {
  final dynamic chat;
  const ChatPage({super.key, required this.chat});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final textController = TextEditingController();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  void _send() {
    final content = textController.text.trim();
    if (content.isEmpty) return;
    final chatId = widget.chat['_id'] as String;
    context.read<ChatBloc>().add(SendMessageRequested(chatId, content));
    textController.clear();
    Future.delayed(const Duration(milliseconds: 100), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent + 60,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final otherName = widget.chat['user2'] != null
        ? widget.chat['user2']['name'] ?? 'Chat'
        : 'Chat';

    return Scaffold(
      appBar: AppBar(title: Text(otherName)),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                final messages = state.messages;
                if (messages.isEmpty) {
                  return const Center(child: Text('No messages yet'));
                }
                return ListView.builder(
                  controller: scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final m = messages[index];
                    final isMe =
                        m.senderId == context.read<AuthBloc>().state.user?.id;
                    return MessageBubble(
                      message: Chat(
                        id: m.id,
                        senderId: m.senderId,
                        receiverId: m.receiverId,
                        message: m.content,
                        timestamp: DateTime.now(),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
            child: Row(
              children: [
                Expanded(child: TextField(controller: textController)),
                IconButton(icon: const Icon(Icons.send), onPressed: _send),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
