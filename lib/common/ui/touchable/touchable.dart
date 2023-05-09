import 'package:flutter/material.dart';

class Touchable extends StatefulWidget {
  const Touchable({
    super.key,
    required this.child,
    this.onPress,
    this.nested = false,
  });

  final Widget child;
  final VoidCallback? onPress;
  final bool nested;

  @override
  State<Touchable> createState() => _TouchableState();
}

class _TouchableState extends State<Touchable> {
  bool pressed = false;
  void pressIn() {
    setState(() => pressed = true);
  }

  void pressOut() {
    setState(() => pressed = false);
  }

  Widget childWidget() {
    return AnimatedScale(
      duration: const Duration(milliseconds: 200),
      scale: pressed ? 0.95 : 1,
      child: widget.child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.nested
        ? NestedTouchable(
            onPress: widget.onPress,
            onTapDown: pressIn,
            onTapUp: pressOut,
            child: childWidget(),
          )
        : SimpleTouchable(
            onPress: widget.onPress,
            onTapDown: pressIn,
            onTapUp: pressOut,
            child: childWidget(),
          );
  }
}

class SimpleTouchable extends StatelessWidget {
  const SimpleTouchable({
    super.key,
    required this.child,
    required this.onTapDown,
    required this.onTapUp,
    this.onPress,
  });

  final Widget child;
  final VoidCallback onTapDown;
  final VoidCallback onTapUp;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => onTapDown(),
      onTapUp: (_) => onTapUp(),
      onTapCancel: () => onTapUp(),
      onTap: onPress,
      behavior: HitTestBehavior.opaque,
      child: child,
    );
  }
}

class NestedTouchable extends StatelessWidget {
  const NestedTouchable({
    super.key,
    required this.child,
    required this.onTapDown,
    required this.onTapUp,
    this.onPress,
  });

  final Widget child;
  final VoidCallback onTapDown;
  final VoidCallback onTapUp;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTapDown: (_) => onTapDown(),
      onTapUp: (_) => onTapUp(),
      onTapCancel: () => onTapUp(),
      onTap: onPress,
      child: child,
    );
  }
}
