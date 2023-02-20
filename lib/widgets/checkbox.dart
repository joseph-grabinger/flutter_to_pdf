import 'package:flutter/material.dart' show BorderRadius, Checkbox, CircleBorder, RoundedRectangleBorder;

import 'package:pdf/pdf.dart' show PdfColors;
import 'package:pdf/widgets.dart' as pw show Checkbox, Widget, BoxDecoration, BoxShape, Border, BorderStyle;

import '/args/color.dart';
import '/args/border_radius.dart';
import '/args/border_style.dart';


extension CheckboxConverter on Checkbox {
  pw.Widget toPdfWidget() => pw.Checkbox(
    name: hashCode.toString(),
    value: value!,
    tristate: tristate,
    activeColor: activeColor?.toPdfColor() ?? PdfColors.blue,
    checkColor: checkColor?.toPdfColor() ?? PdfColors.white,
    decoration: getCheckboxDecoration(),
  );

  pw.BoxDecoration getCheckboxDecoration() {
    final pw.Border defaultBorder = pw.Border.all(
      color: side?.color.toPdfColor() ?? PdfColors.black, 
      width: side?.width ?? 1.0,
      style: side?.style.toPdfBorderStyle() ?? pw.BorderStyle.solid,
    );

    switch (shape.runtimeType) {
      case RoundedRectangleBorder:
        return pw.BoxDecoration(
          color: fillColor?.resolve({})?.toPdfColor(),
          borderRadius: ((shape as RoundedRectangleBorder).borderRadius as BorderRadius).toPdfBorderRadius(),
          border: defaultBorder,
        );
      case CircleBorder:
        return pw.BoxDecoration(
          shape: pw.BoxShape.circle,
          color: fillColor?.resolve({})?.toPdfColor(),
          border: defaultBorder,
        );
      default:
        print('Unsupported OutlineBorder: $this');
        return const pw.BoxDecoration();
    }
  }
}
