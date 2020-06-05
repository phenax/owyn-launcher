import 'package:device_apps/device_apps.dart';
import 'dart:async';

StreamController<List<Application>> applications_$ = StreamController<List<Application>>.broadcast();

Future<List<Application>> getApplications() {
  return DeviceApps.getInstalledApplications(
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: true,
      includeAppIcons: false,
  );
}

void refreshApplications() async {
  List<Application> apps = await getApplications();
  applications_$.add(apps);
}

Stream<List<Application>> getApplications$() {
  return applications_$.stream;
}

