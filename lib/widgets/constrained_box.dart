import 'package:flutter/widgets.dart' show ConstrainedBox;

import 'package:pdf/widgets.dart' as pw show ConstrainedBox, Widget;

import '/args/box_constraints.dart';

/// Extension on [ConstrainedBox] to convert it to the pdf equivalent [pw.ConstrainedBox].
extension ConstrainedBoxConverter on ConstrainedBox {
  /// Converts the [ConstrainedBox] to a [pw.ConstrainedBox].
  pw.Widget toPdfWidget(pw.Widget? child) => pw.ConstrainedBox(
        constraints: constraints.toPdfBoxConstraints(),
        child: child,
      );
}
