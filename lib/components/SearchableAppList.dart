import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

import 'AppList.dart';

class _SearchableAppListState extends State<SearchableAppList> {
  final _inputController = TextEditingController();

  void initState() {
    super.initState();
    _inputController.addListener(() {

    });
  }

  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void reset() {
    _inputController.clear();
  }

  int _appSorter(Application a, Application b) {
    return a.appName.toLowerCase().compareTo(b.appName.toLowerCase());
  }

  bool _filterApp(Application a) {
    var searchTerm = _inputController.text;
    return a.appName.toLowerCase().contains(searchTerm.toLowerCase());
  }

  Widget getIcon(IconData icon, { Color color }) {
    var inputIconSize = 16.0;
    return Icon(icon, color: color, size: inputIconSize);
  }

  @override
  Widget build(BuildContext ctx) {
    ThemeData theme = Theme.of(context);

    return Column(
        children: [
          Container(
            height: 30,
            child: Align(
                alignment: Alignment.topRight,
                child: TextField(
                    //onChanged: onInput,
                    enableSuggestions: false,
                    controller: _inputController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                        //prefix: Container(padding: , child: Text('')),
                        //prefixStyle: TextStyle(color: theme.primaryColor),
                        hintStyle: TextStyle(color: Color(0x88D8DEE9)),
                        hintText: 'Search',
                        suffix: IconButton(
                            icon: getIcon(Icons.close, color: Colors.red[400]),
                            onPressed: reset,
                        ),
                    ),
                )
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

