import 'package:flutter/widgets.dart' show Align;

import 'package:pdf/widgets.dart' as pw show Align, Alignment, Widget;

import '/args/alignment.dart';

/// Extension on [Align] to convert it to the pdf equivalent [pw.Align].
extension AlignConverter on Align {
  /// Converts the [Align] to a [pw.Align].
  pw.Align toPdfWidget(pw.Widget? child) => pw.Align(
        alignment: _convertAlignment(alignment),
        widthFactor: widthFactor,
        heightFactor: heightFactor,
        child: child,
      );

  _convertAlignment(AlignmentGeometry? alignment) {
    if (alignment is Alignment) return alignment.toPdfAlignment();
    if (alignment is AlignmentDirectional) return alignment.toPdfAlignment();
    debugPrint(
      'Unsupported AlignmentGeometry: $this; defaulting to Alignment.centerRight',
    );
    return Alignment.centerRight.toPdfAlignment();
  }
}
