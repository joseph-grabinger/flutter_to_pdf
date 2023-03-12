import 'package:flutter/material.dart' show ButtonStyleButton, EdgeInsets;

import 'package:pdf/pdf.dart' show PdfColor, PdfColors;
import 'package:pdf/widgets.dart' as pw show FlatButton, Widget, BoxDecoration, Border, BoxShape, EdgeInsets;

import '/args/border_side.dart';
import '/args/outlined_border.dart';
import '/args/color.dart';
import '/args/edge_insets.dart';


extension ButtonConverter on ButtonStyleButton {
  pw.FlatButton toPdfWidget(pw.Widget child) => pw.FlatButton(
    name: hashCode.toString(),
    textColor: style?.foregroundColor?.resolve({})?.toPdfColor() ?? PdfColors.white,
    decoration: pw.BoxDecoration(
      border: style?.side?.resolve({}) != null
          ? pw.Border.fromBorderSide(style!.side!.resolve({})!.toPdfBorderSide())
          : null,
      color: style?.backgroundColor?.resolve({})?.toPdfColor()
          ?? const PdfColor(0.2, 0.4, 0.4, 0.1).flatten(background: PdfColors.white),
      shape: style?.shape != null 
          ? style!.shape!.resolve({})!.toPdfBoxShape()
          : pw.BoxShape.rectangle,
      borderRadius: style?.shape?.resolve({})?.toPdfBorderRadius(),
    ),
    padding: (style?.padding?.resolve({}) as EdgeInsets?)?.toPdfEdgeInsets()
        ?? const pw.EdgeInsets.all(4.0),
    child: child,
  );
}
