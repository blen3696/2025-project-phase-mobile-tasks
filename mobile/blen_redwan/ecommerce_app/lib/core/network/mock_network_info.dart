import 'network_info.dart';

class MockNetworkInfo implements NetworkInfo {
  final bool connected;

  MockNetworkInfo(this.connected);

  @override
  Future<bool> get isConnected async => connected;
}
