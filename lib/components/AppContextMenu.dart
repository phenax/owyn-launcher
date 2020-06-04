import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:android_intent/android_intent.dart';
import 'package:android_intent/flag.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/favorites.dart';

class Option extends StatelessWidget {
  void Function() onTap;
  Widget icon;
  Widget child;

  Option({ this.child, this.icon, this.onTap }): super();

  @override
  build(BuildContext ctx) {
    return Column(
      children: [
        ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            title: Row(children: [
              Container(width: 36.0, padding: EdgeInsets.only(right: 16.0), child: icon),
              child,
            ]),
            onTap: () {
              onTap();
              Navigator.pop(ctx);
            },
        ),
        Divider(height: 1.0),
      ],
    );
  }
}

class AppContextMenu extends StatelessWidget {
  final Application app;
  final bool isFavorite;

  AppContextMenu({ this.app, this.isFavorite }): super();

  @override
  Widget build(BuildContext ctx) {
    ThemeData theme = Theme.of(ctx);

    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: theme.backgroundColor,
        ),
        height: 170.0,
        child: ListView(
          children: [
            Option(
                icon: Icon(Icons.star, size: 22.0, color: theme.primaryColor),
                child: Text(isFavorite ? 'Remove from favorites' : 'Add to favorites'),
                onTap: () async {
                  await isFavorite ? removeFromFavorites(app) : addToFavorites(app);
                },
            ),
            Option(
                child: Text('App Settings'),
                icon: Icon(Icons.settings, size: 22.0, color: theme.primaryColor),
                onTap: () async {
                  await AndroidIntent(
                      action: 'action_application_details_settings',
                      data: 'package:${app.packageName}',
                  ).launch();
                },
            ),
            Option(
                child: Text('Uninstall'),
                icon: Icon(Icons.delete_forever, size: 22.0, color: theme.primaryColor),
                onTap: () async {
                  await AndroidIntent(
                      action: 'android.intent.action.DELETE',
                      data: 'package:${app.packageName}',
                  ).launch();
                },
            ),
          ],
        ),
      ),
    );
  }
}
