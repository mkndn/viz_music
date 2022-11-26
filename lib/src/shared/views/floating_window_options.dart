import 'package:flutter/material.dart';
import 'package:freestyle_speed_dial/freestyle_speed_dial.dart';
import 'package:window_manager/window_manager.dart';

@immutable
class FloatingWindowOptions extends StatefulWidget {
  const FloatingWindowOptions({super.key, this.initialOpen});

  final bool? initialOpen;

  @override
  State<FloatingWindowOptions> createState() => _FloatingWindowOptionsState();
}

class _FloatingWindowOptionsState extends State<FloatingWindowOptions>
    with SingleTickerProviderStateMixin {
  bool _maximized = false;

  List<Widget> getActions() {
    return [
      (!_maximized)
          ? FloatingActionButton.small(
              shape: CircleBorder(),
              onPressed: () async {
                await windowManager.maximize();
                _toggleSize();
              },
              child: const Icon(Icons.open_in_full),
            )
          : FloatingActionButton.small(
              shape: CircleBorder(),
              onPressed: () async {
                await windowManager.restore();
                _toggleSize();
              },
              child: const Icon(Icons.close_fullscreen),
            ),
      FloatingActionButton.small(
        shape: CircleBorder(),
        onPressed: () async => await windowManager.close(),
        child: const Icon(Icons.close_rounded),
      ),
    ];
  }

  void _toggleSize() {
    setState(() {
      _maximized = !_maximized;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 200,
      runSpacing: 200,
      children: [
        SpeedDialBuilder(
          buttonAnchor: Alignment.topCenter,
          itemAnchor: Alignment.bottomCenter,
          buttonBuilder: (context, isActive, toggle) => FloatingActionButton(
            shape: CircleBorder(),
            onPressed: toggle,
            child: AnimatedRotation(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutCubicEmphasized,
                turns: isActive ? 1 : 0,
                child: Icon(isActive
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.keyboard_arrow_up_rounded)),
          ),
          curve: Curves.easeInOutCubicEmphasized,
          reverse: true,
          itemBuilder: (context, Widget item, i, animation) {
            final offsetAnimation = Tween<Offset>(
              begin: Offset.zero,
              end: Offset(0, -i - 0.25),
            ).animate(animation);
            return SlideTransition(
                position: offsetAnimation,
                child: FadeTransition(
                  opacity: animation,
                  child: item,
                ));
          },
          items: getActions(),
        ),
      ],
    );
  }
}
