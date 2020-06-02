import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

class AppList extends StatelessWidget {
  List<Application> appList;
  void Function(Application) openApp;
  void Function(Application) openOptionsMenu;
  
  AppList({ this.appList, this.openApp, this.openOptionsMenu }): super();

  @override
  Widget build(BuildContext ctx) {
    return ListView.builder(
      itemCount: appList.length,
      itemBuilder: (ctx, index) {
        Application app = appList[index];
        return Column(
          children: [
            ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                dense: true,
                title: Text('${app.appName}', style: const TextStyle(fontSize: 16)),
                onTap: () => openApp(app),
                onLongPress: () => openOptionsMenu(app),
            ),
            Divider(height: 1.0),
          ],
        );
      },
    );
  }
}

