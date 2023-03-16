import 'package:flutter/widgets.dart' show ClipRect, ClipRRect, ClipOval, BorderRadius;

import 'package:pdf/widgets.dart' as pw show ClipRect, ClipRRect, ClipOval, Widget;

import '/args/border_radius.dart';


extension ClipRectConverter on ClipRect {
  pw.ClipRect toPdfWidget(pw.Widget? child) => pw.ClipRect(
    child: child,
  );
}

extension ClipRRectConverter on ClipRRect {
  pw.ClipRRect toPdfWidget(pw.Widget? child) => pw.ClipRRect(
    horizontalRadius: (borderRadius as BorderRadius?)?.toPdfHorizontalRadius() ?? 0,
    verticalRadius: (borderRadius as BorderRadius?)?.toPdfVerticalRadius() ?? 0,
    child: child,
  );
}

extension ClipOvalConverter on ClipOval {
  pw.ClipOval toPdfWidget(pw.Widget? child) => pw.ClipOval(
    child: child,
  );
}
