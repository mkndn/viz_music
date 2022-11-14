import 'package:flutter/material.dart';
import 'dart:math';

class IconRotateAnimation extends StatefulWidget {
  final Widget child;
  final bool animate;
  const IconRotateAnimation(
      {required this.child, this.animate = false, super.key});

  @override
  State<IconRotateAnimation> createState() => _IconRotateAnimationState();
}

class _IconRotateAnimationState extends State<IconRotateAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  void prepareAnimation() {
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
        upperBound: pi * 2);
    _animation = Tween<double>(begin: 0, end: pi).animate(_animationController);
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
    prepareAnimation();
    _toggle();
  }

  @override
  void didUpdateWidget(IconRotateAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    _toggle();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(turns: _animation, child: widget.child);
  }
}
