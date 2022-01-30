class ResponseEntity {
  final String status;
  final String message;
  final Map<String, dynamic> data;

  ResponseEntity({
    required this.message,
    required this.status,
    required this.data,
  });
}
