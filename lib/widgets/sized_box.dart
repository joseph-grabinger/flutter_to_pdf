import 'package:flutter/widgets.dart' show SizedBox;

import 'package:pdf/widgets.dart' as pw show SizedBox, Widget;

/// Extension on [SizedBox] to convert it to the pdf equivalent [pw.SizedBox].
extension SizedBoxConverter on SizedBox {
  /// Converts the [SizedBox] to a [pw.SizedBox].
  pw.SizedBox toPdfWidget(pw.Widget? child) => pw.SizedBox(
        width: width,
        height: height,
        child: child,
      );
}
