import 'package:flutter/widgets.dart' show Expanded;

import 'package:pdf/widgets.dart' as pw show Expanded, Widget;

import '/args/flex_fit.dart';

/// Extension on [Expanded] to convert it to the pdf equivalent [pw.Expanded].
extension ExpandedConverter on Expanded {
  /// Converts the [Expanded] to a [pw.Expanded].
  pw.Expanded toPdfWidget(pw.Widget child) => pw.Expanded(
        flex: flex,
        fit: fit.toPdfFlexFit(),
        child: child,
      );
}
