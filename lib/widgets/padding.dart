import 'package:flutter/widgets.dart' show EdgeInsets, Padding;

import 'package:pdf/widgets.dart' as pw show Padding, Widget;

import '/args/edge_insets.dart';

/// Extension on [Padding] to convert it to the pdf equivalent [pw.Padding].
extension PaddingConverter on Padding {
  /// Converts the [Padding] to a [pw.Padding].
  pw.Padding toPdfWidget(pw.Widget? child) => pw.Padding(
        padding: (padding as EdgeInsets).toPdfEdgeInsets(),
        child: child,
      );
}
