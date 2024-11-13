import 'package:clean_arch_core/clean_arch_core.dart';
import 'package:clean_arch_example/weather/domain/entities/current_weather.dart';
import 'package:clean_arch_example/weather/domain/repositories/weather_api_repository.dart';

class GetCurrentWeather
    extends UseCase<CurrentWeather, GetCurrentWeatherParams> {
  final WeatherApiRepository weatherApiRepository;

  GetCurrentWeather({required this.weatherApiRepository});

  @override
  Future<Either<Failure, CurrentWeather>> call(
    GetCurrentWeatherParams params,
  ) async {
    return weatherApiRepository.getCurrentWeather(params.city);
  }
}

class GetCurrentWeatherParams extends Equatable {
  final String city;

  const GetCurrentWeatherParams({required this.city});

  @override
  List<Object?> get props => [city];
}
