import 'package:clean_arch_core/clean_arch_core.dart';
import 'package:clean_arch_example/weather/domain/entities/current_weather.dart';
import 'package:clean_arch_example/weather/domain/use_cases/get_current_weather.dart';

part 'current_weather_bloc.event.dart';
part 'current_weather_bloc.state.dart';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  final GetCurrentWeather getCurrentWeather;

  CurrentWeatherBloc({
    required this.getCurrentWeather,
  }) : super(const CurrentWeatherInitialState()) {
    on<GetCurrentWeatherEvent>(_onGetCurrentWeatherEvent);
  }

  Future<void> _onGetCurrentWeatherEvent(
    GetCurrentWeatherEvent event,
    Emitter<CurrentWeatherState> emit,
  ) async {
    emit(const CurrentWeatherLoadingState());

    final result = await getCurrentWeather(
      GetCurrentWeatherParams(city: event.city),
    );

    result.fold(
      (l) => emit(CurrentWeatherErrorState(message: l.message)),
      (r) => emit(CurrentWeatherLoadedState(currentWeather: r)),
    );
  }
}
