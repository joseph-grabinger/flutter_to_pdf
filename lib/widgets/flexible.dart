import 'package:flutter/widgets.dart' show Flexible;

import 'package:pdf/widgets.dart' as pw show Flexible, Widget;

import '/args/flex_fit.dart';


extension FlexibleConverter on Flexible {
  pw.Widget toPdfWidget(pw.Widget child) => pw.Flexible(
    flex: flex,
    fit: fit.toPdfFlexFit(),
    child: child,
  );
}