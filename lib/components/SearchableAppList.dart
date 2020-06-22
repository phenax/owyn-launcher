import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

import 'AppList.dart';

class _SearchableAppListState extends State<SearchableAppList> {
  TextEditingController editingController = TextEditingController();
  var items = List<Application>();

  int _appSorter(Application a, Application b) {
    return a.appName.toLowerCase().compareTo(b.appName.toLowerCase());
  }

  @override
  void initState() {
    items.addAll(widget.appList);
    items.sort(_appSorter);
    super.initState();
  }

  /* bool _filterApp(Application a) {
    var searchTerm = _inputController.text;
    return a.appName.toLowerCase().contains(searchTerm.toLowerCase());
  } */

  void filterSearchResults(String query) {
  List<Application> dummySearchList = List<Application>();
  dummySearchList.addAll(widget.appList);
  if(query.isNotEmpty) {
    List<Application> dummyListData = List<Application>();
    dummySearchList.forEach((item) {
      if(item.appName.toLowerCase().contains(query.toLowerCase())) {
        dummyListData.add(item);
      }
    });
    dummySearchList.sort(_appSorter);
    setState(() {
      items.clear();
      items.addAll(dummyListData);
    });
    return;
  } else {
    items.sort(_appSorter);
    setState(() {
      items.clear();
      items.addAll(widget.appList);
    });
  }
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
            margin: EdgeInsets.only(top: 20),
            child: Align(
                alignment: Alignment.topRight,
                child: TextField(
                    cursorColor: Colors.white,
                    onChanged: (value) {
                      filterSearchResults(value);
                    },
                    enableSuggestions: false,
                    controller: editingController,
                    focusNode: widget.searchFieldFocus,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                        hintStyle: TextStyle(color: Color(0x88D8DEE9)),
                        hintText: 'Search',
                        suffix: IconButton(
                            icon: getIcon(Icons.close, color: Colors.white),
                            onPressed: (){},
                        ),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                    ),
                )
            ),
          ),
          Expanded(child: AppList(
                  appList: items,
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

