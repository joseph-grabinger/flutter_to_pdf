import 'package:flutter/widgets.dart' show Padding;

import 'package:pdf/widgets.dart' as pw show Padding, Widget, EdgeInsets;

import '/args/edge_insets.dart';

/// Extension on [Padding] to convert it to the pdf equivalent [pw.Padding].
extension PaddingConverter on Padding {
  /// Converts the [Padding] to a [pw.Padding].
  pw.Padding toPdfWidget(pw.Widget? child) => pw.Padding(
        padding: padding.toPdfEdgeInsets() ?? const pw.EdgeInsets.all(0),
        child: child,
      );
}
