import 'package:flutter/widgets.dart' show BoxShadow, debugPrint;

import 'package:pdf/pdf.dart' show PdfPoint;
import 'package:pdf/widgets.dart' as pw show BoxShadow;

import 'color.dart';


extension BoxShadowConverter on BoxShadow {
  pw.BoxShadow toPdfBoxShadow() {
    debugPrint('BoxShadowConverter: $this');
    return pw.BoxShadow(
      color: color.toPdfColor(),
      offset: PdfPoint(offset.dx, offset.dy),
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
    );
  }
}