import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

import 'AppList.dart';

class _SearchableAppListState extends State<SearchableAppList> {
  String _searchTerm = '';

  void onInput(String str) {
    setState(() { _searchTerm = str; });
  }

  int _appSorter(Application a, Application b) {
    return a.appName.toLowerCase().compareTo(b.appName.toLowerCase());
  }

  bool _filterApp(Application a) {
    return a.appName.toLowerCase().contains(_searchTerm.toLowerCase()) ||
        a.packageName.toLowerCase().contains(_searchTerm.toLowerCase());
  }

  @override
  Widget build(BuildContext ctx) {
    return Column(
        children: [
          Container(
            height: 30,
            child: TextField(
                onChanged: onInput,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                ),
            ),
          ),
          Expanded(child: FutureBuilder(
            future: widget.appListF,
            builder: (ctx, AsyncSnapshot<List<Application>> snap) {
              if (!snap.hasData) {
                return Text('Loading...');
              }

              List<Application> results = snap.data
                  .where(_filterApp)
                  .toList();
              results.sort(_appSorter);

              return AppList(
                  appList: results,
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

