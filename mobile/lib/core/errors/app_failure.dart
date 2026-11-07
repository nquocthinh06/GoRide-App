class AppFailure {
  const AppFailure({
    required this.code,
    required this.message,
  });

  final String code;
  final String message;

  @override
  String toString() => 'AppFailure(code: $code, message: $message)';
}

