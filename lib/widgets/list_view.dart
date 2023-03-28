import 'package:flutter/widgets.dart' show ListView, EdgeInsets;

import 'package:pdf/widgets.dart' as pw show ListView, Widget;

import '/args/edge_insets.dart';
import '/args/axis.dart';

/// Extension on [ListView] to convert it to the pdf equivalent [pw.ListView].
extension ListViewConverter on ListView {
  /// Converts the [ListView] to a [pw.ListView].
  pw.ListView toPdfWidget(List<pw.Widget> children) => pw.ListView(
        children: children,
        reverse: reverse,
        padding: (padding as EdgeInsets?)?.toPdfEdgeInsets(),
        direction: scrollDirection.toPdfAxis(),
      );
}
