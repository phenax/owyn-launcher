import 'package:flutter/material.dart';

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

