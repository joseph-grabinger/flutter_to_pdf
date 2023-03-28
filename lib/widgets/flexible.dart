import 'package:flutter/widgets.dart' show Flexible;

import 'package:pdf/widgets.dart' as pw show Flexible, Widget;

import '/args/flex_fit.dart';

/// Extension on [Flexible] to convert it to the pdf equivalent [pw.Flexible].
extension FlexibleConverter on Flexible {
  /// Converts the [Flexible] to a [pw.Flexible].
  pw.Flexible toPdfWidget(pw.Widget child) => pw.Flexible(
        flex: flex,
        fit: fit.toPdfFlexFit(),
        child: child,
      );
}
