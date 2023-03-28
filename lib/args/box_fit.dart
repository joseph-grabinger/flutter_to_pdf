import 'package:flutter/widgets.dart' show BoxFit;

import 'package:pdf/widgets.dart' as pw show BoxFit;

extension BoxFitConverter on BoxFit {
  pw.BoxFit toPdfBoxFit() {
    switch (this) {
      case BoxFit.fill:
        return pw.BoxFit.fill;
      case BoxFit.contain:
        return pw.BoxFit.contain;
      case BoxFit.cover:
        return pw.BoxFit.cover;
      case BoxFit.fitWidth:
        return pw.BoxFit.fitWidth;
      case BoxFit.fitHeight:
        return pw.BoxFit.fitHeight;
      case BoxFit.none:
        return pw.BoxFit.none;
      case BoxFit.scaleDown:
        return pw.BoxFit.scaleDown;
    }
  }
}
