import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

import '../components/AppList.dart';

class FixedContainer extends StatelessWidget {
  EdgeInsets padding;
  Widget child;

  FixedContainer({ this.padding, this.child }): super();

  @override
  Widget build(BuildContext ctx) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Container(
                    padding: padding,
                    height: viewportConstraints.maxHeight,
                    child: child,
                )
              ),
            ),
          );
        }
    );
  }
}

