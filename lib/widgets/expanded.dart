import 'package:flutter/widgets.dart' show Expanded;

import 'package:pdf/widgets.dart' as pw show Expanded, Widget;

import '/args/flex_fit.dart';


extension ExpandedConverter on Expanded {
  pw.Expanded toPdfWidget(pw.Widget child) => pw.Expanded(
    flex: flex,
    fit: fit.toPdfFlexFit(),
    child: child,
  );
}