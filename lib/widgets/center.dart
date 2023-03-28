import 'package:flutter/widgets.dart' show Center;

import 'package:pdf/widgets.dart' as pw show Center, Widget;

/// Extension on [Center] to convert it to the pdf equivalent [pw.Center].
extension CenterConverter on Center {
  /// Converts the [Center] to a [pw.Center].
  pw.Center toPdfWidget(pw.Widget? child) => pw.Center(
        heightFactor: heightFactor,
        widthFactor: widthFactor,
        child: child,
      );
}
