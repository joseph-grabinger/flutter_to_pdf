import 'package:flutter/widgets.dart' show Color;

import 'package:pdf/pdf.dart' show PdfColor;

extension ColorConverter on Color {
  PdfColor toPdfColor() => PdfColor(
        red / 255,
        green / 255,
        blue / 255,
        opacity,
      );
}
