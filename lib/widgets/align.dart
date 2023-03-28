import 'package:flutter/widgets.dart' show Align, Alignment;

import 'package:pdf/widgets.dart' as pw show Align, Widget;

import '/args/alignment.dart';

extension AlignConverter on Align {
  pw.Align toPdfWidget(pw.Widget? child) => pw.Align(
        alignment: (alignment as Alignment).toPdfAlignment(),
        widthFactor: widthFactor,
        heightFactor: heightFactor,
        child: child,
      );
}
