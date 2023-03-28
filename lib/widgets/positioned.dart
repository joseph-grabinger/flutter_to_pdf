import 'package:flutter/widgets.dart' show Positioned;

import 'package:pdf/widgets.dart' as pw show Positioned, Widget, SizedBox;

/// Extension on [Positioned] to convert it to the pdf equivalent [pw.Positioned].
extension PositionedConverter on Positioned {
  /// Converts the [Positioned] to a [pw.Positioned].
  pw.Positioned toPdfWidget(pw.Widget child) {
    if (width != null || height != null) {
      child = pw.SizedBox(
        width: width,
        height: height,
        child: child,
      );
    }

    return pw.Positioned(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      child: child,
    );
  }
}
