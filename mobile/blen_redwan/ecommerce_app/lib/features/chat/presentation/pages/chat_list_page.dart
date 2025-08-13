import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';

class ChatListPage extends StatelessWidget {
  ChatListPage({super.key});

  final List<Color> pastelColors = [
    const Color.fromARGB(255, 156, 219, 208),
    const Color.fromARGB(255, 235, 169, 169),
    const Color.fromARGB(255, 255, 235, 168),
    const Color.fromARGB(255, 209, 240, 159),
    const Color.fromARGB(255, 215, 227, 252),
    const Color.fromARGB(255, 246, 214, 214),
  ];

  final List<String> avatarImages = [
    'assets/image/avatar1.png',
    'assets/image/avatar2.png',
  ];

  @override
  Widget build(BuildContext context) {
    final chatBloc = context.read<ChatBloc>();
    Future.microtask(() => chatBloc.add(LoadChatsRequested()));

    final authUser = context.select((AuthBloc b) => b.state.user);
    final authId = authUser?.id;

    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 110,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _statusCircle(
                          'My status',
                          avatarImages[0],
                          pastelColors[0],
                          isMyStatus: true,
                        ),
                        _statusCircle('Adil', avatarImages[1], pastelColors[1]),
                        _statusCircle(
                          'Marina',
                          avatarImages[0],
                          pastelColors[2],
                        ),
                        _statusCircle('Dean', avatarImages[1], pastelColors[3]),
                        _statusCircle('Max', avatarImages[0], pastelColors[4]),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    if (state.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state.error != null) {
                      return Center(child: Text(state.error!));
                    }
                    if (state.chats.isEmpty) {
                      return const Center(child: Text('No chats'));
                    }

                    final chats = state.chats;

                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      itemCount: chats.length,
                      separatorBuilder: (_, __) =>
                          const Divider(indent: 90, height: 0),
                      itemBuilder: (context, index) {
                        final chat = chats[index];
                        final user2 = chat['user2'] ?? chat['participant'];
                        // ignore: unused_local_variable
                        final isMe = user2 != null
                            ? (user2['_id'] == authId)
                            : false;

                        final avatarImage =
                            avatarImages[index % avatarImages.length];
                        final bgColor =
                            pastelColors[index % pastelColors.length];

                        return ListTile(
                          onTap: () => Navigator.pushNamed(
                            context,
                            '/chat',
                            arguments: {
                              ...chat,
                              'avatar': avatarImage,
                              'myAvatar': 'assets/image/avatar2.png',
                              'bgColor': bgColor,
                            },
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          leading: CircleAvatar(
                            radius: 28,
                            backgroundColor: bgColor,
                            backgroundImage: AssetImage(avatarImage),
                          ),
                          title: Text(
                            chat['name'] ?? 'Unknown',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          subtitle: Text(
                            chat['lastMessage'] ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                chat['lastTime'] ?? '2 min ago',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 6),
                              if ((chat['unreadCount'] ?? 0) > 0)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[400],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '${chat['unreadCount']}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusCircle(
    String name,
    String avatarPath,
    Color bgColor, {
    bool isMyStatus = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: bgColor,
                backgroundImage: AssetImage(avatarPath),
              ),
              if (isMyStatus)
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue[600],
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(Icons.add, size: 20, color: Colors.white),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 70,
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
