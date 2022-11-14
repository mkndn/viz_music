import 'package:flutter/material.dart';

class EspandIconAnimation extends StatefulWidget {
  final Widget child;
  final bool animate;
  final double axisAlignment;
  EspandIconAnimation({
    this.animate = false,
    required this.axisAlignment,
    required this.child,
  });

  @override
  _EspandIconAnimationState createState() => _EspandIconAnimationState();
}

class _EspandIconAnimationState extends State<EspandIconAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  void prepareAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInCubic,
      reverseCurve: Curves.easeOutCubic,
    );
  }

  void _toggle() {
    if (widget.animate) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _toggle();
  }

  @override
  void didUpdateWidget(EspandIconAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    _toggle();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        axis: Axis.horizontal,
        axisAlignment: -1.0,
        sizeFactor: _animation,
        child: widget.child);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
