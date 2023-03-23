import 'package:flutter/widgets.dart' show Alignment, AlignmentDirectional, Stack, StackFit;

import 'package:pdf/widgets.dart' as pw show Stack, Widget, StackFit;

import '/args/alignment.dart';


extension StackConverter on Stack {
  pw.Stack toPdfWidget(List<pw.Widget> children) => pw.Stack(
    alignment: alignment is Alignment 
        ? (alignment as Alignment).toPdfAlignment()
        : (alignment as AlignmentDirectional).toPdfAlignment(),
    fit: fit.toPdfStackFit(),
    children: children,
  );
}

extension StackFitConverter on StackFit {
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
