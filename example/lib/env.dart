// ignore_for_file: public_member_api_docs

abstract class Env {
  String get weatherApiHost;
  String get weatherApiKey;
}

class EnvImpl implements Env {
  @override
  String get weatherApiHost => const String.fromEnvironment('WEATHER_API_HOST');

  @override
  String get weatherApiKey => const String.fromEnvironment('WEATHER_API_KEY');
}
