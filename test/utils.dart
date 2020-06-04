import 'package:flutter/material.dart';

Widget wrapper(Widget view) {
  return MaterialApp(
      title: 'owyn test',
      home: Scaffold(
          body: PageView(
              controller: PageController(),
              children: [ view ],
          ),
      ),
    );
}

Future<void> waitFor(Duration duration) { return Future.delayed(duration, () {}); }

Application makeApp(String name, String pkgName) {
  return Application({
    'app_name': name,
    'apk_file_path': '/$pkgName.apk',
    'package_name': pkgName,
    'version_name': '0.0.0',
    'version_code': 1,
    'data_dir': '/$pkgName/data',
    'system_app': false,
    'install_time': 0,
    'update_time': 0,
  });
}

