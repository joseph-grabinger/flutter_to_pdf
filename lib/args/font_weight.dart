import 'package:pdf/widgets.dart' as pw;
import 'dart:ui';


enum PfFontWeight {
  normal,
  bold
}

extension PfFontWeightExt on PfFontWeight {
  pw.FontWeight toPw() {
    switch (this) {
      case PfFontWeight.normal:
        return pw.FontWeight.normal;
      case PfFontWeight.bold:
        return pw.FontWeight.bold;
    }
  }

  FontWeight toFl() {
    switch (this) {
      case PfFontWeight.normal:
        return FontWeight.normal;
      case PfFontWeight.bold:
        return FontWeight.bold;
    }
  }
}