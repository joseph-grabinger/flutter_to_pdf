import 'package:pdf/widgets.dart' as pw;
import 'dart:ui';


enum PfFontStyle {
  normal,
  italic,
}

extension PfFontStyleExt on PfFontStyle {
  pw.FontStyle toPw() {
    switch (this) {
      case PfFontStyle.normal:
        return pw.FontStyle.normal;
      case PfFontStyle.italic:
        return pw.FontStyle.italic;
    }
  }

  FontStyle toFl() {
    switch (this) {
      case PfFontStyle.normal:
        return FontStyle.normal;
      case PfFontStyle.italic:
        return FontStyle.italic;
    }
  }
}