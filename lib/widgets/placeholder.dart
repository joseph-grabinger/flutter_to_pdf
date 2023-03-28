import 'package:flutter/widgets.dart' show Placeholder;

import 'package:pdf/widgets.dart' as pw show Placeholder;

import '/args/color.dart';

extension PlaceholderConverter on Placeholder {
  pw.Placeholder toPdfWidget() => pw.Placeholder(
        color: color.toPdfColor(),
        strokeWidth: strokeWidth,
        fallbackWidth: fallbackWidth,
        fallbackHeight: fallbackHeight,
      );
}
