import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

import 'AppList.dart';

class _SearchableAppListState extends State<SearchableAppList> {
  final _inputController = TextEditingController();

  void initState() {
    super.initState();
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

    List<Application> results = widget.appList
        .where(_filterApp)
        .toList();
    results.sort(_appSorter);

    return Column(
        children: [
          Container(
            height: 30,
            child: Align(
                alignment: Alignment.topRight,
                child: TextField(
                    enableSuggestions: false,
                    controller: _inputController,
                    focusNode: widget.searchFieldFocus,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
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
          Expanded(child: AppList(
                  appList: results,
                  openApp: widget.openApp,
                  openOptionsMenu: widget.openOptionsMenu,
          )),
        ],
    );
  }
}

class SearchableAppList extends StatefulWidget {
  List<Application> appList;
  void Function(Application) openApp;
  void Function(Application) openOptionsMenu;
  FocusNode searchFieldFocus;
  
  SearchableAppList({ this.appList, this.openApp, this.openOptionsMenu, this.searchFieldFocus }): super();

  @override
  _SearchableAppListState createState() => _SearchableAppListState();
}

