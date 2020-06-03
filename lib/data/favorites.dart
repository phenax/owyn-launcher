import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_apps/device_apps.dart';
import 'dart:async';

const String FAVORITES = 'favorites';
const String SEPERATOR = ',';

StreamController<List<Application>> favorites_$ = StreamController<List<Application>>.broadcast();

Future<List<Application>> getFavorites() async {
  final prefs = await SharedPreferences.getInstance();

  String rawFavoritesList = prefs.getString(FAVORITES);
  List<String> packageNames = rawFavoritesList?.split(SEPERATOR) ?? <String>[];

  return Future.wait(packageNames.map((String pkg) => DeviceApps.getApp(pkg)));
}

void initFavorites() async {
  List<Application> fs = await getFavorites();
  favorites_$.add(fs);
}

Stream<List<Application>> getFavorites$() {
  return favorites_$.stream;
}

void setFavorites(List<Application> favs) async {
  final prefs = await SharedPreferences.getInstance();

  String rawFavoritesList = favs.map((Application app) => app.packageName).join(SEPERATOR);
  
  prefs.setString(FAVORITES, rawFavoritesList);

  favorites_$.add(await getFavorites());
}

void addToFavorites(Application app) async {
  List<Application> fs = await getFavorites();
  fs.add(app);
  await setFavorites(fs);
}

