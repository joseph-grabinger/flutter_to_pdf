import 'package:flutter/widgets.dart' show Opacity;

import 'package:pdf/widgets.dart' as pw show Opacity, Widget;

/// Extension on [Opacity] to convert it to the pdf equivalent [pw.Opacity].
extension OpacityConverter on Opacity {
  /// Converts the [Opacity] to a [pw.Opacity].
  pw.Opacity toPdfWidget(pw.Widget? child) => pw.Opacity(
        opacity: opacity,
        child: child,
      );
}
