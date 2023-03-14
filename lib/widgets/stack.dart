import 'package:flutter/widgets.dart' show Alignment, AlignmentDirectional, Stack;

import 'package:pdf/widgets.dart' as pw show Stack, Widget;

import '/args/alignment.dart';
import '/args/stack_fit.dart';


extension StackConverter on Stack {
  pw.Stack toPdfWidget(List<pw.Widget> children) => pw.Stack(
    alignment: alignment is Alignment 
        ? (alignment as Alignment).toPdfAlignment()
        : (alignment as AlignmentDirectional).toPdfAlignment(),
    fit: fit.toPdfStackFit(),
    children: children,
  );
}
