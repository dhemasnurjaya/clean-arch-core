import 'package:auto_route/auto_route.dart';

import 'router.gr.dart';

@AutoRouterConfig()
class Router extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: CurrentWeatherRoute.page,
          initial: true,
        ),
        AutoRoute(page: AppSettingsRoute.page),
      ];
}
