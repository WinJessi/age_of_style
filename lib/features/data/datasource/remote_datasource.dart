import 'dart:convert';

import 'package:age_of_style/core/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDatasource {
  Future<Map<String, dynamic>> getCategory();
  Future<Map<String, dynamic>> getSubCategory();
  Future<Map<String, dynamic>> settings();
  Future<Map<String, dynamic>> contestants();
  Future<Map<String, dynamic>> vote(Map<String, dynamic> map);

  Future<Map<String, dynamic>> initPayment(Map<String, dynamic> map);
  Future<Map<String, dynamic>> verifyPayment(String ref);
}

class RemoteDatasourceImpl extends RemoteDatasource {
  RemoteDatasourceImpl({
    required this.dio,
    required this.client,
  });

  final Dio dio;
  final http.Client client;

  @override
  Future<Map<String, dynamic>> contestants() async {
    var response = await dio.get('$kURL/contestants');

    return response.data;
  }

  @override
  Future<Map<String, dynamic>> getCategory() async {
    var response = await dio.get('$kURL/category');

    return response.data;
  }

  @override
  Future<Map<String, dynamic>> getSubCategory() async {
    var response = await dio.get('$kURL/sub/category');

    return response.data;
  }

  @override
  Future<Map<String, dynamic>> settings() async {
    var response = await dio.get('$kURL/settings');

    return response.data;
  }

  @override
  Future<Map<String, dynamic>> vote(Map<String, dynamic> map) async {
    var response = await dio.post('$kURL/contestant/vote', data: map);

    return response.data;
  }

  @override
  Future<Map<String, dynamic>> initPayment(Map<String, dynamic> map) async {
    var headers = {
      'Authorization': 'Bearer $kSECRET',
      'Content-Type': 'application/json',
    };

    var request = await http.post(
      Uri.parse('https://api.paystack.co/transaction/initialize'),
      body: json.encode(map),
      headers: headers,
    );

    return json.decode(request.body);
  }

  @override
  Future<Map<String, dynamic>> verifyPayment(String ref) async {
    var response = await dio.get(
      'https://api.paystack.co/transaction/verify/$ref',
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $kSECRET',
      }),
    );

    return response.data;
  }
}
