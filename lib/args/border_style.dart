import 'package:flutter/widgets.dart' show BorderStyle;

import 'package:pdf/widgets.dart' as pw show BorderStyle;


extension BoderStyleConverter on BorderStyle {
  pw.BorderStyle toPdfBorderStyle() {
    switch (this) {
      case BorderStyle.none:
        return pw.BorderStyle.none;
      case BorderStyle.solid:
        return pw.BorderStyle.solid;
    }
  }
}