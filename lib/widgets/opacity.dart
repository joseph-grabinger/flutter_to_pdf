import 'package:flutter/widgets.dart' show Opacity;

import 'package:pdf/widgets.dart' as pw show Opacity, Widget;


extension OpacityConverter on Opacity {
  pw.Opacity toPdfWidget(pw.Widget? child) => pw.Opacity(
    opacity: opacity,
    child: child,
  );
}
