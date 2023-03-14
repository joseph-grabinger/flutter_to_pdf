import 'package:flutter/widgets.dart' show LimitedBox;

import 'package:pdf/widgets.dart' as pw show LimitedBox, Widget;


extension LimitedBoxConverter on LimitedBox {
  pw.Widget toPdfWidget(pw.Widget? child) => pw.LimitedBox(
    maxWidth: maxWidth,
    maxHeight: maxHeight,
    child: child,
  );
}
