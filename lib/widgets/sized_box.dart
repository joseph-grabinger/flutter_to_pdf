import 'package:flutter/widgets.dart' show SizedBox;

import 'package:pdf/widgets.dart' as pw show SizedBox, Widget;

extension SizedBoxConverter on SizedBox {
  pw.SizedBox toPdfWidget(pw.Widget? child) => pw.SizedBox(
        width: width,
        height: height,
        child: child,
      );
}
