

import 'package:pdf/pdf.dart' show PdfPageFormat;

class PfPageFormat {
  const PfPageFormat(this.width, this.height,
    {double marginTop = 0.0,
    double marginBottom = 0.0,
    double marginLeft = 0.0,
    double marginRight = 0.0,
    double? marginAll})
    : assert(width > 0),
      assert(height > 0),
      marginTop = marginAll ?? marginTop,
      marginBottom = marginAll ?? marginBottom,
      marginLeft = marginAll ?? marginLeft,
      marginRight = marginAll ?? marginRight;

  static const PfPageFormat a3 =
    PfPageFormat(29.7 * cm, 42 * cm, marginAll: 2.0 * cm);
  static const PfPageFormat a4 =
    PfPageFormat(21.0 * cm, 29.7 * cm, marginAll: 2.0 * cm);
  static const PfPageFormat a5 =
    PfPageFormat(14.8 * cm, 21.0 * cm, marginAll: 2.0 * cm);
  static const PfPageFormat a6 =
    PfPageFormat(105 * mm, 148 * mm, marginAll: 1.0 * cm);
  static const PfPageFormat letter =
    PfPageFormat(8.5 * inch, 11.0 * inch, marginAll: inch);
  static const PfPageFormat legal =
    PfPageFormat(8.5 * inch, 14.0 * inch, marginAll: inch);

  static const PfPageFormat roll57 =
    PfPageFormat(57 * mm, double.infinity, marginAll: 5 * mm);
  static const PfPageFormat roll80 =
    PfPageFormat(80 * mm, double.infinity, marginAll: 5 * mm);

  static const PfPageFormat undefined =
    PfPageFormat(double.infinity, double.infinity);

  static const PfPageFormat standard = a4;

  static const double point = 1.0;
  static const double inch = 72.0;
  static const double cm = inch / 2.54;
  static const double mm = inch / 25.4;

  final double width;
  final double height;

  final double marginTop;
  final double marginBottom;
  final double marginLeft;
  final double marginRight;

  PdfPageFormat toPw() {
    return PdfPageFormat(width, height,
      marginTop: marginTop,
      marginBottom: marginBottom,
      marginLeft: marginLeft,
      marginRight: marginRight
    );
  }
}