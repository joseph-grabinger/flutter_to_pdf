import 'package:flutter/widgets.dart' show Placeholder;

import 'package:pdf/widgets.dart' as pw show Placeholder;

import '/args/color.dart';

/// Extension on [Placeholder] to convert it to the pdf equivalent [pw.Placeholder].
extension PlaceholderConverter on Placeholder {
  /// Converts the [Placeholder] to a [pw.Placeholder].
  pw.Placeholder toPdfWidget() => pw.Placeholder(
        color: color.toPdfColor(),
        strokeWidth: strokeWidth,
        fallbackWidth: fallbackWidth,
        fallbackHeight: fallbackHeight,
      );
}
