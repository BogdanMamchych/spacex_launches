import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../models/launch.dart';
import '../models/rocket.dart';

class ApiService {
  final String baseUrl;
  final http.Client _client;

  ApiService({this.baseUrl = 'https://api.spacexdata.com/v3', http.Client? client})
      : _client = client ?? http.Client();

  Future<List<Launch>> fetchAllLaunches() async {
    final uri = Uri.parse('$baseUrl/launches');
    final resp = await _client.get(uri).timeout(const Duration(seconds: 10));
    if (resp.statusCode != 200) throw HttpException('Status ${resp.statusCode}');
    return compute(_parseLaunchList, resp.body);
  }

  static List<Launch> _parseLaunchList(String body) {
    final List<dynamic> list = json.decode(body) as List<dynamic>;
    return list.map((e) => Launch.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<Rocket>> fetchAllRockets() async {
    final uri = Uri.parse('$baseUrl/rockets');
    final resp = await _client.get(uri).timeout(const Duration(seconds: 10));
    if (resp.statusCode != 200) throw HttpException('Status ${resp.statusCode}');
    return compute(_parseRocketList, resp.body);
  }

  static List<Rocket> _parseRocketList(String body) {
    final List<dynamic> list = json.decode(body) as List<dynamic>;
    return list.map((e) => Rocket.fromJson(e as Map<String, dynamic>)).toList();
  }

  void dispose() => _client.close();
}

class HttpException implements Exception {
  final String message;
  HttpException(this.message);
  @override
  String toString() => 'HttpException: $message';
}
