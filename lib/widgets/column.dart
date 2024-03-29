import 'package:flutter/widgets.dart' show Column;

import 'package:pdf/widgets.dart' as pw show Column, Widget;

import '/args/cross_axis_alignment.dart';
import '/args/main_axis_alignment.dart';
import '/args/main_axis_size.dart';
import '/args/vertical_direction.dart';

/// Extension on [Column] to convert it to the pdf equivalent [pw.Column].
extension ColumnConverter on Column {
  /// Converts the [Column] to a [pw.Column].
  pw.Column toPdfWidget(List<pw.Widget> children) => pw.Column(
        mainAxisAlignment: mainAxisAlignment.toPdfMainAxisAlignment(),
        mainAxisSize: mainAxisSize.toPdfMainAxisSize(),
        crossAxisAlignment: crossAxisAlignment.toPdfCrossAxisAlignment(),
        verticalDirection: verticalDirection.toPdfVerticalDirection(),
        children: children,
      );
}
