import 'package:flutter/material.dart';

class AppAnimatedNumberText extends StatefulWidget {
  final double value;
  final TextStyle? style;
  final String? prefix;
  final String? suffix;

  const AppAnimatedNumberText(
      {super.key, required this.value, this.style, this.prefix, this.suffix});

  @override
  State<AppAnimatedNumberText> createState() => _AppAnimatedNumberTextState();
}

class _AppAnimatedNumberTextState extends State<AppAnimatedNumberText> {
  late double _oldValue;

  @override
  void initState() {
    super.initState();
    _oldValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant AppAnimatedNumberText oldWidget) {
    _oldValue = oldWidget.value;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(
        begin: _oldValue,
        end: widget.value,
      ),
      duration: const Duration(milliseconds: 500),
      builder: (_, v, __) {
        return Text(
          '${widget.prefix ?? ''}${double.parse(v.toStringAsFixed(2))}${widget.suffix ?? ''}',
          style: widget.style,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        );
      },
    );
  }
}
