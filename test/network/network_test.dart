import 'dart:io';

import 'package:clean_arch_core/clean_arch_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late NetworkImpl networkImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    networkImpl = NetworkImpl(mockHttpClient);
  });

  group('get', () {
    final tUri = Uri.parse('https://test.com');

    test('should perform a GET request on a URL', () async {
      // Arrange

      when(() => mockHttpClient.get(tUri, headers: null))
          .thenAnswer((_) async => http.Response('{"key": "value"}', 200));

      // Act
      await networkImpl.get(tUri);

      // Assert
      verify(() => mockHttpClient.get(tUri, headers: null));
    });

    test('should return the response body when the status code is 200',
        () async {
      // Arrange
      const tBody = '{"key": "value"}';
      when(() => mockHttpClient.get(tUri, headers: null))
          .thenAnswer((_) async => http.Response(tBody, 200));

      // Act
      final result = await networkImpl.get(tUri);

      // Assert
      expect(result, tBody);
    });

    test('should throw a ServerException when the response code is not 200',
        () async {
      // Arrange
      when(() => mockHttpClient.get(tUri, headers: null))
          .thenAnswer((_) async => http.Response(
                'Something went wrong',
                HttpStatus.internalServerError,
              ));

      // Act
      final call = networkImpl.get;

      // Assert
      expect(() => call(tUri), throwsA(isA<ServerException>()));
    });

    test('should throw a UnauthorizedException when the response code is 401',
        () async {
      // Arrange
      when(() => mockHttpClient.get(tUri, headers: null))
          .thenAnswer((_) async => http.Response(
                'Unauthorized',
                HttpStatus.unauthorized,
              ));

      // Act
      final call = networkImpl.get;

      // Assert
      expect(() => call(tUri), throwsA(isA<UnauthorizedException>()));
    });
  });
}
