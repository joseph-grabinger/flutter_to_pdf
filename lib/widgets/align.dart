import 'package:flutter/widgets.dart' show Align, Alignment;

import 'package:pdf/widgets.dart' as pw show Align, Widget;

import '/args/alignment.dart';

/// Extension on [Align] to convert it to the pdf equivalent [pw.Align].
extension AlignConverter on Align {
  /// Converts the [Align] to a [pw.Align].
  pw.Align toPdfWidget(pw.Widget? child) => pw.Align(
        alignment: (alignment is Alignment)
            ? (alignment as Alignment).toPdfAlignment()
            : Alignment.centerRight.toPdfAlignment(),
        widthFactor: widthFactor,
        heightFactor: heightFactor,
        child: child,
      );
}
