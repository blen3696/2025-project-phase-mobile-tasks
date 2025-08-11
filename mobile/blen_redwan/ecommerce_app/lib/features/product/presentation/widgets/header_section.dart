// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../../chat/data/datasources/chat_socket_service.dart';

// class HeaderSection extends StatelessWidget {
//   const HeaderSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             // Container(
//             //   width: 40,
//             //   height: 40,
//             //   decoration: BoxDecoration(
//             //     color: Colors.grey[400],
//             //     border: Border.all(color: Colors.grey[400]!),
//             //     borderRadius: BorderRadius.circular(10),
//             //   ),
//             GestureDetector(
//               onTap: () async {
// Navigator.pushNamed(
//   context,
//   '/chat',
//   arguments: {
//     '_id': 'dummyId',
//     'user2': {'name': 'Test User'},
//   },
// );
//                 // Navigator.pushNamed(context, '/chats');
//                 final prefs = await SharedPreferences.getInstance();
//                 final token = prefs.getString('user_token');

//                 if (token != null && token.isNotEmpty) {
//                   // Give token to service and connect socket
//                   final socketService = ChatSocketService();
//                   socketService.setToken(token);
//                   socketService.connect(); // connect immediately
//                   Navigator.pushNamed(context, '/chats');
//                 } else {
//                   print('No token — redirecting to login');
//                   Navigator.pushNamed(context, '/login');
//                 }
//               },
//               child: Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[400],
//                   border: Border.all(color: Colors.grey[400]!),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Icon(Icons.message, color: Colors.white, size: 20),
//               ),
//             ),
//             const SizedBox(width: 12),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'July 14, 2023',
//                   style: TextStyle(fontSize: 12, color: Colors.grey[400]),
//                 ),
//                 const SizedBox(height: 4),
//                 const Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Hello, ',
//                       style: TextStyle(fontSize: 16, color: Colors.grey),
//                     ),
//                     Text('User', style: TextStyle(fontSize: 16)),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),

//         Container(
//           width: 40,
//           height: 40,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey[300]!),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: const Icon(Icons.notifications),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../chat/data/datasources/chat_socket_service.dart';

class HeaderSection extends StatefulWidget {
  const HeaderSection({super.key});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  String userName = 'User';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user_token');

    if (token != null && token.isNotEmpty) {
      final decoded = JwtDecoder.decode(token);
      setState(() {
        userName = decoded['name'] ?? decoded['email'] ?? 'User';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                final token = prefs.getString('user_token');

                if (token != null && token.isNotEmpty) {
                  final socketService = ChatSocketService();
                  socketService.setToken(token);
                  socketService.connect();
                  Navigator.pushNamed(context, '/chats');
                } else {
                  Navigator.pushNamed(context, '/login');
                }
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  border: Border.all(color: Colors.grey[400]!),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.message, color: Colors.white, size: 20),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'July 14, 2023',
                  style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Hello, ',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Text(userName, style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
          ],
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.notifications),
        ),
      ],
    );
  }
}
