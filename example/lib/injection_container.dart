import 'package:clean_arch_core/clean_arch_core.dart';
import 'package:clean_arch_example/env.dart';
import 'package:clean_arch_example/weather/data/data_sources/remote/weather_api_remote_data_source.dart';
import 'package:clean_arch_example/weather/data/repositories/weather_api_repository_impl.dart';
import 'package:clean_arch_example/weather/domain/repositories/weather_api_repository.dart';
import 'package:clean_arch_example/weather/domain/use_cases/get_current_weather.dart';
import 'package:clean_arch_example/weather/presentation/bloc/current_weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  // env
  getIt.registerSingleton<Env>(EnvImpl());

  // network
  getIt.registerLazySingleton<Client>(() => Client());
  getIt.registerLazySingleton<Network>(() => NetworkImpl(getIt()));

  // shared preferences
  getIt.registerSingletonAsync<SharedPreferences>(
    () async {
      final prefs = await SharedPreferences.getInstance();
      return prefs;
    },
  );

  // configs
  getIt.registerSingletonWithDependencies<Config<ThemeMode>>(
    () => ThemeModeConfig(sharedPreferences: getIt()),
    dependsOn: [SharedPreferences],
  );

  // data sources
  getIt.registerLazySingleton<WeatherApiRemoteDataSource>(
    () => WeatherApiRemoteDataSourceImpl(
      env: getIt(),
      network: getIt(),
    ),
  );

  // repositories
  getIt.registerLazySingleton<WeatherApiRepository>(
    () => WeatherApiRepositoryImpl(
      weatherApiRemoteSource: getIt(),
    ),
  );

  // use cases
  getIt.registerLazySingleton<GetCurrentWeather>(
    () => GetCurrentWeather(
      weatherApiRepository: getIt(),
    ),
  );

  // blocs
  getIt.registerSingletonAsync<ThemeModeCubit>(
    () async {
      final initialThemeMode = await getIt<Config<ThemeMode>>().get();
      return ThemeModeCubit(
        themeModeConfig: getIt(),
        initialThemeMode: initialThemeMode,
      );
    },
    dependsOn: [SharedPreferences, Config<ThemeMode>],
  );
  getIt.registerFactory<CurrentWeatherBloc>(
    () => CurrentWeatherBloc(
      getCurrentWeather: getIt(),
    ),
  );

  // others
}
