import 'package:flutter/widgets.dart';

import 'package:pdf/pdf.dart' show PdfPoint;

import 'package:teaplates/page.dart';


class PfPoint {
  const PfPoint(this.x, this.y);

  final double x, y;

  static const PfPoint zero = PfPoint(0.0, 0.0);

  PfPoint translate(double offsetX, double offsetY) =>
      PfPoint(x + offsetX, y + offsetY);

  Offset toFl() {
    return Offset(x * pwToFlPx, y * pwToFlPx);
  }

  PdfPoint toPw() {
    return PdfPoint(x, y);
  }
}