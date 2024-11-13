import 'package:clean_arch_core/clean_arch_core.dart';
import 'package:clean_arch_example/env.dart';
import 'package:clean_arch_example/weather/data/data_sources/remote/weather_api_remote_data_source.dart';
import 'package:clean_arch_example/weather/data/models/current_weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../_responses/_response.dart';

class MockEnv extends Mock implements Env {}

class MockNetwork extends Mock implements Network {}

void main() {
  late MockEnv mockEnv;
  late MockNetwork mockNetwork;
  late WeatherApiRemoteDataSource weatherApiRemoteSource;

  setUp(() {
    mockEnv = MockEnv();
    mockNetwork = MockNetwork();
    weatherApiRemoteSource = WeatherApiRemoteDataSourceImpl(
      env: mockEnv,
      network: mockNetwork,
    );

    registerFallbackValue(Uri());
  });

  group('getCurrentWeather', () {
    test('should return CurrentWeatherModel when getCurrentWeather is called',
        () async {
      // Arrange
      const tCity = 'London';
      final tResponse = readResponse('current_weather');

      when(() => mockEnv.weatherApiKey).thenReturn('api_key');
      when(() => mockEnv.weatherApiHost).thenReturn('api_host');
      when(() => mockNetwork.get(any())).thenAnswer(
        (_) async => tResponse,
      );

      // Act
      final result = await weatherApiRemoteSource.getCurrentWeather(tCity);

      // Assert
      expect(result, isA<CurrentWeatherModel>());
    });
  });
}
