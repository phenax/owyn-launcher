import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

class AppList extends StatelessWidget {
  final List<Application> appList;
  final void Function(Application) openApp;
  final void Function(Application) openOptionsMenu;
  final bool allowReorder;
  
  AppList({ this.appList, this.openApp, this.openOptionsMenu, this.allowReorder = false }): super();

  onReorder(int a, int b) {
    // 
  }

  Widget buildItem(Application app) {
    return Container(
      key: Key(app.packageName),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
        dense: true,
        title: Text('${app.appName}', style: const TextStyle(fontSize: 16)),
        onTap: () => openApp(app),
        onLongPress: () => !this.allowReorder ? openOptionsMenu(app) : null,
      ),
    );
  }

  @override
  Widget build(BuildContext ctx) {
    if (this.allowReorder) {
      return ReorderableListView(
        key: Key("reorderlist"),
        onReorder: this.onReorder,
        children: appList.map(this.buildItem).toList(),
      );
    }
    return ListView.builder(
      itemCount: appList.length,
      itemBuilder: (ctx, index) {
        return this.buildItem(appList[index]);
      },
    );
  }
}

