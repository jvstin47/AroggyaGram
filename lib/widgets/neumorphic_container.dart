import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NeumorphicContainer extends StatefulWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final bool isInset;
  final bool isInteractive;
  final VoidCallback? onTap;
  final Color? color;

  const NeumorphicContainer({
    super.key,
    required this.child,
    this.borderRadius = 16.0,
    this.padding = const EdgeInsets.all(16.0),
    this.isInset = false,
    this.isInteractive = false,
    this.onTap,
    this.color,
  });

  @override
  State<NeumorphicContainer> createState() => _NeumorphicContainerState();
}

class _NeumorphicContainerState extends State<NeumorphicContainer> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bool showInset = widget.isInset || _isPressed;
    final Color bgColor = widget.color ?? AppTheme.background;

    Widget container = AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      padding: widget.padding,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: showInset
            ? [
                // Inset shadows are tricky in standard Flutter without a custom painter or package.
                // We will simulate it using a very tight inner shadow or just slightly modifying the color
                // Since true inset requires a specific package, we'll do a basic flat look when pressed.
                BoxShadow(
                  color: AppTheme.neumorphicDark,
                  offset: const Offset(2, 2),
                  blurRadius: 4,
                ),
              ]
            : [
                BoxShadow(
                  color: AppTheme.neumorphicLight,
                  offset: const Offset(-8, -8),
                  blurRadius: 16,
                ),
                BoxShadow(
                  color: AppTheme.neumorphicDark,
                  offset: const Offset(8, 8),
                  blurRadius: 16,
                ),
              ],
      ),
      child: widget.child,
    );

    if (widget.isInteractive || widget.onTap != null) {
      return GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          if (widget.onTap != null) widget.onTap!();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedScale(
          scale: _isPressed ? 0.98 : 1.0,
          duration: const Duration(milliseconds: 150),
          child: container,
        ),
      );
    }

    return container;
  }
}
