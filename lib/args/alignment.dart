import 'package:flutter/widgets.dart'
    show Alignment, AlignmentDirectional, AlignmentGeometry, debugPrint;

import 'package:pdf/widgets.dart' as pw show Alignment;

extension AlignmentGeometryConverter on AlignmentGeometry {
  pw.Alignment? toPdfAlignment() {
    switch (runtimeType) {
      case const (Alignment):
        return (this as Alignment).toPdfAlignment();
      case const (AlignmentDirectional):
        return (this as AlignmentDirectional).toPdfAlignment();
      default:
        debugPrint('Unsupported AlignmentGeometry: $this; defaulting to null');
        return null;
    }
  }
}

extension AlignmentConverter on Alignment {
  pw.Alignment toPdfAlignment() => pw.Alignment(x, y);
}

extension AlignmentDirectionalConverter on AlignmentDirectional {
  pw.Alignment toPdfAlignment() => pw.Alignment(start, y);
}
