import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_apps/device_apps.dart';
import 'dart:async';

const String FAVORITES = 'favorites';
const String SEPERATOR = ',';

StreamController<List<Application>> favorites_$ = StreamController<List<Application>>.broadcast();

Future<Application> getApplication(String pkg) async {
  if (pkg == null || pkg.length == 0) return null;
  try {
    return DeviceApps.getApp(pkg);
  } catch(e) {
    return null;
  }
}

Future<List<Application>> getFavorites() async {
  final prefs = await SharedPreferences.getInstance();

  String rawFavoritesList = prefs.getString(FAVORITES);
  List<String> packageNames = rawFavoritesList?.split(SEPERATOR) ?? <String>[];

  Iterable<Future<Application>> futures = packageNames.map(getApplication);

  List<Application> result = await Future.wait(futures);

  return result.where((a) => a != null).toList();
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

  String rawFavoritesList = favs.map((Application app) => app.packageName).toList().join(SEPERATOR);
  
  prefs.setString(FAVORITES, rawFavoritesList);

  favorites_$.add(await getFavorites());
}

void addToFavorites(Application app) async {
  List<Application> fs = await getFavorites() as List<Application>;
  
  var matching = fs.where((a) => a.packageName == app.packageName);
  if(matching.length == 0) {
    fs.add(app);
  }

  await setFavorites(fs);
}

