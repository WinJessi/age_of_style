import '../../domain/entity/response_entity.dart';

class ResponseModel extends ResponseEntity {
  ResponseModel({
    required String status,
    required String message,
    required Map<String, dynamic> data,
  }) : super(status: status, message: message, data: data);

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      status: json[ResponseMap.status],
      message: json[ResponseMap.message],
      data: json[ResponseMap.data] ?? {},
    );
  }
}

class ResponseMap {
  static const status = 'status';
  static const message = 'message';
  static const data = 'data';
}
