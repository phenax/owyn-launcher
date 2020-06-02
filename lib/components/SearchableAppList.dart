import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

import 'AppList.dart';

class _SearchableAppListState extends State<SearchableAppList> {
  String _searchTerm = '';

  void onInput(String str) {
    setState(() { _searchTerm = str; });
  }

  int _appSorter(Application a, Application b) {
    return a.appName.compareTo(b.appName);
  }

  @override
  Widget build(BuildContext ctx) {
    return Column(
        children: [
          Container(
            height: 100,
            child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter a search term',
                ),
            ),
          ),
          Expanded(child: FutureBuilder(
            future: widget.appListF,
            builder: (ctx, AsyncSnapshot<List<Application>> snap) {
              if (!snap.hasData) {
                return Text('Loading...');
              }

              snap.data.sort(_appSorter);
              return AppList(
                  appList: snap.data,
                  openApp: widget.openApp,
                  openOptionsMenu: widget.openOptionsMenu,
              );
            }
          )),
        ],
    );
  }
}

class SearchableAppList extends StatefulWidget {
  Future<List<Application>> appListF;
  void Function(Application) openApp;
  void Function(Application) openOptionsMenu;
  
  SearchableAppList({ this.appListF, this.openApp, this.openOptionsMenu }): super();

  @override
  _SearchableAppListState createState() => _SearchableAppListState();
}

