class ConnectionUnavailableException implements Exception {
  final String message;
  ConnectionUnavailableException([this.message = 'No internet connection']);

  @override
  String toString() => 'ConnectionUnavailableException: $message';
}

class ServerException implements Exception {
  final int statusCode;
  final String? message;
  ServerException({required this.statusCode, this.message});

  @override
  String toString() => 'ServerException(statusCode: $statusCode, message: $message)';
}
