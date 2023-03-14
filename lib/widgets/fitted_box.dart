import 'package:flutter/widgets.dart' show FittedBox, Alignment;

import 'package:pdf/widgets.dart' as pw show FittedBox, Widget;

import '/args/alignment.dart';
import '/args/box_fit.dart';


extension FittedBoxConverter on FittedBox {
  pw.Widget toPdfWidget(pw.Widget? child) => pw.FittedBox(
    fit: fit.toPdfBoxFit(),
    alignment: (alignment as Alignment).toPdfAlignment(),
    child: child,
  );
}
