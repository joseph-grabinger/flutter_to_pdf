import 'package:flutter/material.dart' show BorderRadius, Checkbox, CircleBorder, RoundedRectangleBorder, debugPrint;

import 'package:pdf/pdf.dart' show PdfColors, PdfGraphics, PdfPoint;
import 'package:pdf/widgets.dart' as pw show Checkbox, Widget, Container, BoxDecoration, BoxShape, Border, BorderStyle, Center, CustomPaint;

import '/options/checkbox_options.dart';
import '/args/color.dart';
import '/args/border_radius.dart';
import '/args/border_style.dart';
import '/args/box_decoration.dart';


extension CheckboxConverter on Checkbox {
  Future<pw.Widget> toPdfWidget(CheckboxOptions options) async {
    if (options.interactive) {
      return pw.Checkbox(
        name: hashCode.toString(),
        value: value!,
        tristate: tristate,
        activeColor: activeColor?.toPdfColor() ?? PdfColors.blue,
        checkColor: checkColor?.toPdfColor() ?? PdfColors.white,
        decoration: (await options.getBoxDecoration(key)?.toPdfBoxDecoration()) ?? getCheckboxDecoration(),
      );
    } else {
      return pw.Container(
        height: 13,
        width: 13,
        decoration: value == null || !value!
          ? (await options.getBoxDecoration(key)?.toPdfBoxDecoration()) ?? getCheckboxDecoration()
          : null,
        child: value != null && value! ? pw.Center(
          child: pw.CustomPaint(
            size: const PdfPoint(13, 13),
            painter: (PdfGraphics canvas, PdfPoint size) {
              canvas
                ..drawRect(0, 0, 13, 13)
                ..setFillColor(activeColor?.toPdfColor() ?? PdfColors.blue)
                ..fillPath()
                ..moveTo(2, 13 / 2)
                ..lineTo(13 / 3, 13 / 4)
                ..lineTo(13 - 2, 13 / 4 * 3)
                ..setStrokeColor(checkColor?.toPdfColor() ?? PdfColors.white)
                ..setLineWidth(2)
                ..strokePath();
            },
          ),
        ) : null,
      );
    }
  }

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
        debugPrint('Unsupported OutlineBorder: $this');
        return const pw.BoxDecoration();
    }
  }
}
