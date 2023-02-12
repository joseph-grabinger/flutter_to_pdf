import 'package:flutter/widgets.dart' show Positioned;

import 'package:pdf/widgets.dart' as pw show Positioned, Widget;


extension PositionedConverter on Positioned {
  pw.Positioned toPdfWidget(pw.Widget child) => pw.Positioned(
    left: left,
    top: top,
    right: right,
    bottom: bottom,
    child: child,
    // TODO handle width and height
  );
}