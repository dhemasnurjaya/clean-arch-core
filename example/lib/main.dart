import 'package:clean_arch_core/clean_arch_core.dart';
import 'package:clean_arch_example/themes.dart';
import 'package:clean_arch_example/weather/presentation/bloc/current_weather_bloc.dart';
import 'package:flutter/material.dart';

import 'router.dart' as r;
import 'injection_container.dart' as ic;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // dependency injection setup
  ic.setup();
  await ic.getIt.allReady();

  // register bloc observer
  Bloc.observer = AppBlocObserver();

  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  WeatherApp({super.key});

  final _router = r.Router();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeModeCubit>(
          create: (context) => ic.getIt(),
        ),
        BlocProvider<CurrentWeatherBloc>(
          create: (context) => ic.getIt(),
        ),
      ],
      child: BlocBuilder<ThemeModeCubit, ThemeMode>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Weather App',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: state,
            routerConfig: _router.config(),
          );
        },
      ),
    );
  }
}
