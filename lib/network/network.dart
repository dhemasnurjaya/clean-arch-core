import 'dart:convert';
import 'dart:io';
import 'package:clean_arch_core/error/exception.dart';
import 'package:http/http.dart' as http;

/// Network interface
abstract class Network {
  /// Get data from uri
  Future<String> get(
    Uri uri, {
    Map<String, String>? headers,
  });
}

/// Network implementation
class NetworkImpl implements Network {
  NetworkImpl(http.Client httpClient) : _httpClient = httpClient;

  final http.Client _httpClient;

  @override
  Future<String> get(
    Uri uri, {
    Map<String, String>? headers,
  }) async {
    final response = await _httpClient.get(
      uri,
      headers: headers,
    );
    final stringResponse = utf8.decode(response.bodyBytes);

    if (response.statusCode == HttpStatus.unauthorized) {
      throw UnauthorizedException(stringResponse);
    }

    if (response.statusCode != HttpStatus.ok) {
      throw ServerException(stringResponse);
    }

    return stringResponse;
  }
}
