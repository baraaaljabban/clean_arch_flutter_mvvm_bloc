import 'dart:io';

enum NetworkStatus { online, offline }

class ConnectionChecker {
  Future<NetworkStatus> get status async {
    try {
      final List<InternetAddress> result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {
        return NetworkStatus.online;
      }
      return NetworkStatus.offline;
    } catch (_) {
      return NetworkStatus.offline;
    }
  }
}
