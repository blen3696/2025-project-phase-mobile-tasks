import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';
import '../widgets/chat_item.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final chatBloc = context.read<ChatBloc>();
    Future.microtask(() => chatBloc.add(LoadChatsRequested()));

    return Scaffold(
      appBar: AppBar(title: const Text('Chats')),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null) return Center(child: Text(state.error!));
          if (state.chats.isEmpty) return const Center(child: Text('No chats'));

          final chats = state.chats;
          final authUser = context.select((AuthBloc b) => b.state.user);
          final authId = authUser?.id;

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              final user2 = chat['user2'] ?? chat['participant'];
              final isMe = user2 != null ? (user2['_id'] == authId) : false;

              return GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, '/chat', arguments: chat),
                child: ChatItem(chat: chat, isMe: isMe),
              );
            },
          );
        },
      ),
    );
  }
}
