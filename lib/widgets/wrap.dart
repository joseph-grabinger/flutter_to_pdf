import 'package:flutter/widgets.dart' show Wrap, WrapAlignment, WrapCrossAlignment;

import 'package:pdf/widgets.dart' as pw show Wrap, Widget, WrapAlignment, WrapCrossAlignment;

import '/args/vertical_direction.dart';
import '/args/axis.dart';


extension WrapConverter on Wrap {
  pw.Wrap toPdfWidget(List<pw.Widget> children) => pw.Wrap(
    alignment: alignment.toPdfWrapAlignment(),
    crossAxisAlignment: crossAxisAlignment.toPdfWrapCrossAlignment(),
    direction: direction.toPdfAxis(),
    runAlignment: runAlignment.toPdfWrapAlignment(),
    runSpacing: runSpacing,
    spacing: spacing,
    verticalDirection: verticalDirection.toPdfVerticalDirection(),
    children: children,
  );
}

extension WrapAlignmentConverter on WrapAlignment {
  pw.WrapAlignment toPdfWrapAlignment() {
    switch (this) {
      case WrapAlignment.start:
        return pw.WrapAlignment.start;
      case WrapAlignment.end:
        return pw.WrapAlignment.end;
      case WrapAlignment.center:
        return pw.WrapAlignment.center;
      case WrapAlignment.spaceBetween:
        return pw.WrapAlignment.spaceBetween;
      case WrapAlignment.spaceAround:
        return pw.WrapAlignment.spaceAround;
      case WrapAlignment.spaceEvenly:
        return pw.WrapAlignment.spaceEvenly;
    }
  }
}

extension WrapCrossAlignmentConverter on WrapCrossAlignment {
  pw.WrapCrossAlignment toPdfWrapCrossAlignment() {
    switch (this) {
      case WrapCrossAlignment.start:
        return pw.WrapCrossAlignment.start;
      case WrapCrossAlignment.end:
        return pw.WrapCrossAlignment.end;
      case WrapCrossAlignment.center:
        return pw.WrapCrossAlignment.center;
    }
  }
}
