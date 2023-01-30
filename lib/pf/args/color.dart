import 'package:flutter/widgets.dart' show Color;
import 'package:pdf/pdf.dart' show PdfColor;

class PfColor {
  const PfColor(this.value);

  final int value;

  Color toFl() {
    return Color(value);
  }

  PdfColor toPw() {
    return PdfColor.fromInt(value);
  }
}