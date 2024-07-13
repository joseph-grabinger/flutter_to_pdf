import 'package:flutter/widgets.dart' show Align;
import 'package:flutter_to_pdf/args/alignment.dart';

import 'package:pdf/widgets.dart' as pw show Align, Widget, Alignment;

/// Extension on [Align] to convert it to the pdf equivalent [pw.Align].
extension AlignConverter on Align {
  /// Converts the [Align] to a [pw.Align].
  pw.Align toPdfWidget(pw.Widget? child) => pw.Align(
        alignment: alignment.toPdfAlignment() ?? pw.Alignment.center,
        widthFactor: widthFactor,
        heightFactor: heightFactor,
        child: child,
      );
}
