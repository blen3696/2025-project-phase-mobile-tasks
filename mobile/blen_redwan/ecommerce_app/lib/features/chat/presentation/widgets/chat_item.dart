import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final dynamic chat;
  final bool isMe;

  const ChatItem({Key? key, required this.chat, required this.isMe})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final message = chat['lastMessage'] ?? chat['message'] ?? '';
    final timestamp = chat['updatedAt'] ?? chat['timestamp'] ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        children: [
          CircleAvatar(child: const Icon(Icons.person)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  chat['user2']?['name'] ?? 'User',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  message.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(timestamp.toString(), style: const TextStyle(fontSize: 10)),
        ],
      ),
    );
  }
}
