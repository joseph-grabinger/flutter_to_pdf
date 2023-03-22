import 'package:flutter/widgets.dart' show FontWeight, debugPrint;

import 'package:pdf/widgets.dart' as pw show FontWeight;


extension FontWeightConverter on FontWeight {
  pw.FontWeight toPdfFontWeight() {
    switch (this) {
      case FontWeight.normal:
        return pw.FontWeight.normal;
      case FontWeight.bold:
        return pw.FontWeight.bold;
      default:
        debugPrint('Unsupported FontWeight: $this; defaulting to FontWeight.normal');
        return pw.FontWeight.normal;
    }
  }
}
