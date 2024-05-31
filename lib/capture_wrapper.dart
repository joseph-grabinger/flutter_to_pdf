import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CaptureWrapper extends StatelessWidget {
  final Widget child;

  const CaptureWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => RepaintBoundary(child: child);
}
