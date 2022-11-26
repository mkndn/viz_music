import 'package:flutter/material.dart';
import 'package:mkndn/src/shared/typedefs.dart';

class LifeCycleEventHandler with WidgetsBindingObserver {
  LifeCycleEventHandler(
      {required this.resumeCallBack, required this.detachedCallBack});

  final FutureCallback resumeCallBack;
  final FutureCallback detachedCallBack;

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        await detachedCallBack();
        break;
      case AppLifecycleState.resumed:
        await resumeCallBack();
        break;
    }
  }
}
