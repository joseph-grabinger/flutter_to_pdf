import 'package:flutter/widgets.dart'
    show Wrap, WrapAlignment, WrapCrossAlignment;

import 'package:pdf/widgets.dart' as pw
    show Wrap, Widget, WrapAlignment, WrapCrossAlignment;

import '/args/vertical_direction.dart';
import '/args/axis.dart';

/// Extension on [Wrap] to convert it to the pdf equivalent [pw.Wrap].
extension WrapConverter on Wrap {
  /// Converts the [Wrap] to a [pw.Wrap].
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

/// Extension on [WrapAlignment] to convert it to the pdf equivalent [pw.WrapAlignment].
extension WrapAlignmentConverter on WrapAlignment {
  /// Converts the [WrapAlignment] to a [pw.WrapAlignment].
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

/// Extension on [WrapCrossAlignment] to convert it to the pdf equivalent [pw.WrapCrossAlignment].
extension WrapCrossAlignmentConverter on WrapCrossAlignment {
  /// Converts the [WrapCrossAlignment] to a [pw.WrapCrossAlignment].
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
