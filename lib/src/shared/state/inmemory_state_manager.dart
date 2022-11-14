import 'package:flutter/material.dart';

class InmemoryStateManager extends StatefulWidget {
  const InmemoryStateManager({
    required this.child,
    this.isStateLoaded = false,
    super.key,
  });

  final Widget child;
  final bool isStateLoaded;

  static InmemoryStateManagerState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_AppState>()
            as _AppState)
        .data;
  }

  @override
  State<InmemoryStateManager> createState() => InmemoryStateManagerState();
}

class InmemoryStateManagerState extends State<InmemoryStateManager> {
  bool isStateLoaded = false;

  void updateState({bool updatedState = false}) {
    setState(() {
      isStateLoaded = updatedState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _AppState(
      data: this,
      child: widget.child,
    );
  }
}

class _AppState extends InheritedWidget {
  final InmemoryStateManagerState data;

  const _AppState({
    required this.data,
    required super.child,
  });

  @override
  bool updateShouldNotify(_AppState old) =>
      this.data.isStateLoaded != old.data.isStateLoaded;
}
