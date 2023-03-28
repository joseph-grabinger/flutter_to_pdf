import 'package:flutter/widgets.dart'
    show ClipRect, ClipRRect, ClipOval, BorderRadius;

import 'package:pdf/widgets.dart' as pw
    show ClipRect, ClipRRect, ClipOval, Widget;

import '/args/border_radius.dart';

/// Extension on [ClipRect] to convert it to the pdf equivalent [pw.ClipRect].
extension ClipRectConverter on ClipRect {
  /// Converts the [ClipRect] to a [pw.ClipRect].
  pw.ClipRect toPdfWidget(pw.Widget? child) => pw.ClipRect(
        child: child,
      );
}

/// Extension on [ClipRRect] to convert it to the pdf equivalent [pw.ClipRRect].
extension ClipRRectConverter on ClipRRect {
  /// Converts the [ClipRRect] to a [pw.ClipRRect].
  pw.ClipRRect toPdfWidget(pw.Widget? child) => pw.ClipRRect(
        horizontalRadius:
            (borderRadius as BorderRadius?)?.toPdfHorizontalRadius() ?? 0,
        verticalRadius:
            (borderRadius as BorderRadius?)?.toPdfVerticalRadius() ?? 0,
        child: child,
      );
}

/// Extension on [ClipOval] to convert it to the pdf equivalent [pw.ClipOval].
extension ClipOvalConverter on ClipOval {
  /// Converts the [ClipOval] to a [pw.ClipOval].
  pw.ClipOval toPdfWidget(pw.Widget? child) => pw.ClipOval(
        child: child,
      );
}
