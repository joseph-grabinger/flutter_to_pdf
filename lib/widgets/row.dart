import 'package:flutter/widgets.dart' show Row;

import 'package:pdf/widgets.dart' as pw show Row, Widget;

import '/args/cross_axis_alignment.dart';
import '/args/main_axis_alignment.dart';
import '/args/main_axis_size.dart';
import '/args/vertical_direction.dart';

extension RowConverter on Row {
  pw.Row toPdfWidget(List<pw.Widget> children) => pw.Row(
        mainAxisAlignment: mainAxisAlignment.toPdfMainAxisAlignment(),
        mainAxisSize: mainAxisSize.toPdfMainAxisSize(),
        crossAxisAlignment: crossAxisAlignment.toPdfCrossAxisAlignment(),
        verticalDirection: verticalDirection.toPdfVerticalDirection(),
        children: children,
      );
}
