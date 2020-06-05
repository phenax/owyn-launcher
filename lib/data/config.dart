import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

final defaultDarkMode = true;

class Config {
  bool isDark = defaultDarkMode;
  Config({ this.isDark }) {}

  bool isDarkMode() {
    return isDark == null ? defaultDarkMode : isDark;
  }
}

StreamController<Config> config_$ = StreamController<Config>.broadcast();

Future<Config> getConfig() async {
  final prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool('isDark');

  return Config(isDark: isDark == null ? defaultDarkMode : isDark);
}

void refreshConfig() async {
  Config c = await getConfig();
  config_$.add(c);
}

Stream<Config> getConfig$() {
  return config_$.stream;
}

void setConfig(Config config) async {
  final prefs = await SharedPreferences.getInstance();
  
  prefs.setBool('isDark', config.isDark);

  config_$.add(await getConfig());
}

void toggleTheme() async {
  final config = await getConfig();

  setConfig(Config(isDark: !config.isDark));
}

