import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

String defaultTheme = 'dark';

class Config {
  String theme = defaultTheme;
  Config({ this.theme }) {}

  bool isDarkMode() {
    return theme != 'light';
  }
}

StreamController<Config> config_$ = StreamController<Config>.broadcast();

Future<Config> getConfig() async {
  final prefs = await SharedPreferences.getInstance();

  return Config(
    theme: prefs.getString('theme'),
  );
}

void initConfig() async {
  Config c = await getConfig();
  config_$.add(c);
}

Stream<Config> getConfig$() {
  return config_$.stream;
}

void setConfig(Config config) async {
  final prefs = await SharedPreferences.getInstance();
  
  prefs.setString('theme', config.theme);

  config_$.add(await getConfig());
}

void toggleTheme() async {
  final config = await getConfig();

  if (config.theme == 'dark') {
    setConfig(Config(theme: 'light'));
  } else {
    setConfig(Config(theme: 'dark'));
  }
}

