import 'package:flutter/widgets.dart' show CrossAxisAlignment, debugPrint;

import 'package:pdf/widgets.dart' as pw show CrossAxisAlignment;

extension CrossAxisAlignmentConverter on CrossAxisAlignment {
  pw.CrossAxisAlignment toPdfCrossAxisAlignment() {
    switch (this) {
      case CrossAxisAlignment.start:
        return pw.CrossAxisAlignment.start;
      case CrossAxisAlignment.end:
        return pw.CrossAxisAlignment.end;
      case CrossAxisAlignment.center:
        return pw.CrossAxisAlignment.center;
      case CrossAxisAlignment.stretch:
        return pw.CrossAxisAlignment.stretch;
      // not supported in pdf package:
      // - CrossAxisAlignment.baseline
      default:
        debugPrint(
            'Unsupported CrossAxisAlignment: $this; defualting to CrossAxisAlignment.start');
        return pw.CrossAxisAlignment.start;
    }
  }
}
