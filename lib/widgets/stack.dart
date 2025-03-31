import 'package:flutter/widgets.dart'
    show Alignment, AlignmentDirectional, Stack, StackFit, Clip;
import 'package:pdf/widgets.dart' as pw show Stack, Widget, StackFit, Overflow;

import '/args/alignment.dart';

/// Extension on [Stack] to convert it to the pdf equivalent [pw.Stack].
extension StackConverter on Stack {
  /// Converts the [Stack] to a [pw.Stack].
  pw.Stack toPdfWidget(List<pw.Widget> children) => pw.Stack(
        alignment: alignment is Alignment
            ? (alignment as Alignment).toPdfAlignment()
            : (alignment as AlignmentDirectional).toPdfAlignment(),
        fit: fit.toPdfStackFit(),
        overflow:
            clipBehavior == Clip.none ? pw.Overflow.visible : pw.Overflow.clip,
        children: children,
      );
}

/// Extension on [StackFit] to convert it to the pdf equivalent [pw.StackFit].
extension StackFitConverter on StackFit {
  /// Converts the [StackFit] to a [pw.StackFit].
  pw.StackFit toPdfStackFit() {
    switch (this) {
      case StackFit.loose:
        return pw.StackFit.loose;
      case StackFit.expand:
        return pw.StackFit.expand;
      case StackFit.passthrough:
        return pw.StackFit.passthrough;
    }
  }
}
