import 'package:flutter/widgets.dart' show Alignment, AlignmentDirectional;

import 'package:pdf/widgets.dart' as pw show Alignment;


extension AlignmentConverter on Alignment {
  pw.Alignment toPdfAlignment() => pw.Alignment(x, y);
}

extension AlignmentDirectionalConverter on AlignmentDirectional {
  pw.Alignment toPdfAlignment() => pw.Alignment(start, y);
}
