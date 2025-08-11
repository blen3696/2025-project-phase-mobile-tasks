// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../auth/presentation/bloc/auth_bloc.dart';
// import '../bloc/chat_bloc.dart';
// import '../bloc/chat_event.dart';
// import '../bloc/chat_state.dart';
// import '../widgets/message_bubble.dart';
// import '../../domain/entities/chat.dart';

// class ChatPage extends StatefulWidget {
//   final dynamic chat;
//   const ChatPage({super.key, required this.chat});

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final textController = TextEditingController();
//   final scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//   }

//   void _send() {
//     final content = textController.text.trim();
//     if (content.isEmpty) return;
//     final chatId = widget.chat['_id'] as String;
//     context.read<ChatBloc>().add(SendMessageRequested(chatId, content));
//     textController.clear();
//     Future.delayed(const Duration(milliseconds: 100), () {
//       scrollController.animateTo(
//         scrollController.position.maxScrollExtent + 60,
//         duration: const Duration(milliseconds: 200),
//         curve: Curves.easeOut,
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final otherName = widget.chat['user2'] != null
//         ? widget.chat['user2']['name'] ?? 'Chat'
//         : 'Chat';

//     return Scaffold(
//       appBar: AppBar(title: Text(otherName)),
//       body: Column(
//         children: [
//           Expanded(
//             child: BlocBuilder<ChatBloc, ChatState>(
//               builder: (context, state) {
//                 final messages = state.messages;
//                 if (messages.isEmpty) {
//                   return const Center(child: Text('No messages yet'));
//                 }
//                 return ListView.builder(
//                   controller: scrollController,
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     final m = messages[index];
//                     final isMe =
//                         m.senderId == context.read<AuthBloc>().state.user?.id;
//                     return MessageBubble(
//                       message: Chat(
//                         id: m.id,
//                         senderId: m.senderId,
//                         receiverId: '',
//                         message: m.content,
//                         timestamp: DateTime.now(),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
//             child: Row(
//               children: [
//                 Expanded(child: TextField(controller: textController)),
//                 IconButton(icon: const Icon(Icons.send), onPressed: _send),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';

class ChatPage extends StatefulWidget {
  final dynamic chat; // contains chat data and avatar info
  const ChatPage({
    super.key,
    required this.chat,
    required avatarImage,
    required bgColor,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final textController = TextEditingController();
  final scrollController = ScrollController();

  late String otherName;
  late String otherAvatar;
  late String myAvatar;

  @override
  void initState() {
    super.initState();
    otherName = widget.chat['name'] ?? 'Chat';
    otherAvatar = widget.chat['avatar'] ?? 'assets/image/avatar1.png';
    myAvatar = widget.chat['myAvatar'] ?? 'assets/image/avatar2.png';
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
    final myId = context.read<AuthBloc>().state.user?.id;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: widget.chat['bgColor'],
              backgroundImage: AssetImage(otherAvatar),
            ),
            const SizedBox(width: 10),
            Text(
              otherName,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // Messages
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                final messages = state.messages;
                if (messages.isEmpty) {
                  return const Center(child: Text('No messages yet'));
                }
                return ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final m = messages[index];
                    final isMe = m.senderId == myId;
                    return _messageBubble(
                      message: m.content,
                      isMe: isMe,
                      avatar: isMe ? myAvatar : otherAvatar,
                    );
                  },
                );
              },
            ),
          ),

          // Input bar
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey[300]!)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextField(
                        controller: textController,
                        decoration: const InputDecoration(
                          hintText: 'Type a message...',
                          border: InputBorder.none,
                        ),
                        onSubmitted: (_) => _send(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.blue[600],
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: _send,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _messageBubble({
    required String message,
    required bool isMe,
    required String avatar,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe)
            CircleAvatar(radius: 16, backgroundImage: AssetImage(avatar)),
          if (!isMe) const SizedBox(width: 6),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isMe ? Colors.blue[600] : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: isMe
                      ? const Radius.circular(18)
                      : const Radius.circular(4),
                  bottomRight: isMe
                      ? const Radius.circular(4)
                      : const Radius.circular(18),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                message,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black87,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          if (isMe) const SizedBox(width: 6),
          if (isMe)
            CircleAvatar(radius: 16, backgroundImage: AssetImage(avatar)),
        ],
      ),
    );
  }
}
