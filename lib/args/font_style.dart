import 'package:flutter/widgets.dart' show FontStyle;

import 'package:pdf/widgets.dart' as pw show FontStyle;


extension FontStyleConverter on FontStyle {
  pw.FontStyle toPdfFontStyle() {
    switch (this) {
      case FontStyle.normal:
        return pw.FontStyle.normal;
      case FontStyle.italic:
        return pw.FontStyle.italic;
    }
  }
}