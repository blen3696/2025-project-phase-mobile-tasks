import 'package:flutter/material.dart';
import '../../domain/entities/chat.dart';

class MessageBubble extends StatelessWidget {
  final Chat message;
  final bool isMe;

  const MessageBubble({super.key, required this.message, this.isMe = false});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue[300] : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(message.message, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
