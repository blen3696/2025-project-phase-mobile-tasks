import 'dart:async';
import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/message.dart';
import '../models/message_model.dart';

class ChatSocketService {
  static final ChatSocketService _instance = ChatSocketService._();
  factory ChatSocketService() => _instance;
  ChatSocketService._();

  IO.Socket? socket;

  final String baseUrl = 'https://g5-flutter-learning-path-be.onrender.com';

  String? _token;

  final StreamController<Message> _receivedController =
      StreamController.broadcast();
  final StreamController<Message> _deliveredController =
      StreamController.broadcast();

  Stream<Message> get receivedStream => _receivedController.stream;
  Stream<Message> get deliveredStream => _deliveredController.stream;

  Future<void> connect() async {
    if (socket != null && socket!.connected) return;

    String token = _token ?? await _getTokenFromPrefs();

    if (token.isEmpty) {
      print('[Socket] No token available for connection');
      return;
    }

    socket = IO.io(baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'secure': true,
      'path': '/api/v3/socket.io/',
      'auth': {'token': token},
      'extraHeaders': {'Authorization': 'Bearer $token'},
    });

    socket!.onConnect((_) {
      print('[Socket] connected: ${socket!.id}');
    });

    socket!.onConnectError((err) => print('[Socket] connectError: $err'));
    socket!.onError((err) => print('[Socket] error: $err'));
    socket!.onDisconnect((_) => print('[Socket] disconnected'));

    socket!.on('message:received', (data) {
      try {
        final Map<String, dynamic> map = _toMap(data);
        final msg = MessageModel.fromJson(map);
        _receivedController.add(msg);
      } catch (e, st) {
        print('[Socket] parse message:received error $e\n$st\nraw:$data');
      }
    });

    socket!.on('message:delivered', (data) {
      try {
        final Map<String, dynamic> map = _toMap(data);
        final msg = MessageModel.fromJson(map);
        _deliveredController.add(msg);
      } catch (e, st) {
        print('[Socket] parse message:delivered error $e\n$st\nraw:$data');
      }
    });

    socket!.connect();
  }

  void disconnect() {
    socket?.disconnect();
    socket = null;
  }

  void setToken(String token) {
    _token = token;
    if (socket != null && socket!.connected) {
      disconnect();
    }
    connect();
  }

  void emitMessageSend(Map<String, dynamic> payload) {
    if (socket == null || socket!.disconnected) {
      print('[Socket] not connected yet — cannot emit');
      return;
    }
    socket!.emit('message:send', payload);
  }

  Map<String, dynamic> _toMap(dynamic data) {
    if (data == null) return {};
    if (data is Map) {
      return Map<String, dynamic>.from(data);
    } else if (data is String) {
      return jsonDecode(data) as Map<String, dynamic>;
    } else {
      return Map<String, dynamic>.from(data as Map);
    }
  }

  Future<String> _getTokenFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_token') ?? '';
  }

  void dispose() {
    _receivedController.close();
    _deliveredController.close();
    disconnect();
  }
}
