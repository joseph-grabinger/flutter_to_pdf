import 'package:flutter/widgets.dart' show EdgeInsets, Padding;

import 'package:pdf/widgets.dart' as pw show Padding, Widget;

import '/args/edge_insets.dart';


extension PaddingConverter on Padding {
  pw.Padding toPdfWidget(pw.Widget? child) => pw.Padding(
    padding: (padding as EdgeInsets).toPdfEdgeInsets(),
    child: child,
  );
}