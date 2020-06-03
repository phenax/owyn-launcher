import 'dart:async';
import 'package:flutter/material.dart';

class StreamStateValue<Value> {
  Stream<Value> stream$;
  Value value;

  StreamStateValue({ this.stream$, this.value }) {}

  StreamSubscription initialize(void Function(void Function()) setState) {
    return stream$.listen((Value v) {
      setState(() { value = v; });
    });
  }
}

abstract class StreamState<T extends StatefulWidget> extends State<T> {
  List<StreamSubscription> subs = <StreamSubscription>[];

  void initStateValue<V>(StreamStateValue<V> streamVal) {
    subs.add(streamVal.initialize(setState));
  }

  @override
  void dispose() {
    super.dispose();
    for(StreamSubscription sub in subs) {
      sub.cancel();
    }
  }
}
