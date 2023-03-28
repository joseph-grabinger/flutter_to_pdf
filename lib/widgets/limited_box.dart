import 'package:flutter/widgets.dart' show LimitedBox;

import 'package:pdf/widgets.dart' as pw show LimitedBox, Widget;

/// Extension on [LimitedBox] to convert it to the pdf equivalent [pw.LimitedBox].
extension LimitedBoxConverter on LimitedBox {
  /// Converts the [LimitedBox] to a [pw.LimitedBox].
  pw.Widget toPdfWidget(pw.Widget? child) => pw.LimitedBox(
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        child: child,
      );
}
