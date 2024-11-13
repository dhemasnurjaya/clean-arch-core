import 'package:clean_arch_core/clean_arch_core.dart';
import 'package:clean_arch_example/weather/domain/entities/current_weather.dart';

abstract class WeatherApiRepository {
  Future<Either<Failure, CurrentWeather>> getCurrentWeather(String city);
}
