import 'package:flutter/widgets.dart' show Stack, AlignmentDirectional;

import 'package:pdf/widgets.dart' as pw show Stack, Widget;

import '/args/alignment.dart';
import '/args/stack_fit.dart';


extension StackConverter on Stack {
  pw.Stack toPdfWidget(List<pw.Widget> children) => pw.Stack(
    alignment: (alignment as AlignmentDirectional).toPdfAlignment(),
    fit: fit.toPdfStackFit(),
    children: children,
  );
}
