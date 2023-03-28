import 'package:flutter/widgets.dart' show ConstrainedBox;

import 'package:pdf/widgets.dart' as pw show ConstrainedBox, Widget;

import '/args/box_constraints.dart';

extension ConstrainedBoxConverter on ConstrainedBox {
  pw.Widget toPdfWidget(pw.Widget? child) => pw.ConstrainedBox(
        constraints: constraints.toPdfBoxConstraints(),
        child: child,
      );
}
