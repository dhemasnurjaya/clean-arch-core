import 'package:clean_arch_core/clean_arch_core.dart';
import 'package:clean_arch_example/weather/data/data_sources/remote/weather_api_remote_data_source.dart';
import 'package:clean_arch_example/weather/data/models/current_weather_model.dart';
import 'package:clean_arch_example/weather/data/models/weather_api_response_model.dart';
import 'package:clean_arch_example/weather/data/repositories/weather_api_repository_impl.dart';
import 'package:clean_arch_example/weather/domain/entities/current_weather.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherApiRemoteDataSource extends Mock
    implements WeatherApiRemoteDataSource {}

void main() {
  late MockWeatherApiRemoteDataSource mockWeatherApiRemoteSource;
  late WeatherApiRepositoryImpl weatherApiRepositoryImpl;

  setUp(() {
    mockWeatherApiRemoteSource = MockWeatherApiRemoteDataSource();
    weatherApiRepositoryImpl = WeatherApiRepositoryImpl(
      weatherApiRemoteSource: mockWeatherApiRemoteSource,
    );
  });

  group('getCurrentWeather', () {
    test('should call getCurrentWeather from WeatherApiRemoteSource', () async {
      // Arrange
      const tCity = 'London';
      final tLastUpdated = DateTime.now();
      final tCurrentWeatherModel = CurrentWeatherModel(
        location: const WeatherApiLocationModel(
          name: 'London',
          region: 'City of London, Greater London',
          country: 'United Kingdom',
        ),
        data: WeatherApiDataModel(
          lastUpdated: tLastUpdated,
          tempC: 4.0,
          feelslikeC: 2.0,
          condition: const WeatherApiConditionModel(
            text: 'Sunny',
            icon: '//cdn.weatherapi.com/weather/64x64/day/113.png',
          ),
          windKph: 9.4,
          windDir: 'W',
          precipMm: 0.0,
          humidity: 81,
          cloud: 0,
          visKm: 10.0,
          uv: 6.0,
        ),
        error: null,
      );

      when(() => mockWeatherApiRemoteSource.getCurrentWeather(tCity))
          .thenAnswer((_) async => tCurrentWeatherModel);

      // Act
      final result = await weatherApiRepositoryImpl.getCurrentWeather(tCity);

      // Assert
      expect(result, isA<Right<Failure, CurrentWeather>>());
      expect(result.isRight(), true);
      verify(() => mockWeatherApiRemoteSource.getCurrentWeather(tCity));
      verifyNoMoreInteractions(mockWeatherApiRemoteSource);
    });
  });
}
