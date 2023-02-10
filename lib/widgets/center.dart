import 'package:flutter/widgets.dart' show Center;

import 'package:pdf/widgets.dart' as pw show Center, Widget;


extension CenterConverter on Center {
  pw.Center toPDFWidget(pw.Widget? child) => pw.Center(
    heightFactor: heightFactor,
    widthFactor: widthFactor,
    child: child,
  );
}