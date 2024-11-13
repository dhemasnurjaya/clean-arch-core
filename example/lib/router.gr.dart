// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:clean_arch_example/app_settings/presentation/app_settings_page.dart'
    as _i1;
import 'package:clean_arch_example/weather/presentation/current_weather_page.dart'
    as _i2;

/// generated route for
/// [_i1.AppSettingsPage]
class AppSettingsRoute extends _i3.PageRouteInfo<void> {
  const AppSettingsRoute({List<_i3.PageRouteInfo>? children})
      : super(
          AppSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppSettingsRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.AppSettingsPage();
    },
  );
}

/// generated route for
/// [_i2.CurrentWeatherPage]
class CurrentWeatherRoute extends _i3.PageRouteInfo<void> {
  const CurrentWeatherRoute({List<_i3.PageRouteInfo>? children})
      : super(
          CurrentWeatherRoute.name,
          initialChildren: children,
        );

  static const String name = 'CurrentWeatherRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.CurrentWeatherPage();
    },
  );
}
