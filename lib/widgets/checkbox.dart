import 'package:flutter/material.dart'
    show BorderRadius, Checkbox, CircleBorder, RoundedRectangleBorder;

import 'package:pdf/pdf.dart' show PdfColors, PdfGraphics, PdfPoint;
import 'package:pdf/widgets.dart' as pw
    show
        Checkbox,
        Widget,
        Container,
        BoxDecoration,
        BoxShape,
        Border,
        BorderStyle,
        Center,
        CustomPaint;

import '/options/checkbox_options.dart';
import '/args/color.dart';
import '/args/border_radius.dart';
import '/args/border_style.dart';
import '/args/box_decoration.dart';

/// Extension on [Checkbox] to convert it to the pdf equivalent [pw.Checkbox].
extension CheckboxConverter on Checkbox {
  /// Converts the [Checkbox] to a [pw.Checkbox].
  Future<pw.Widget> toPdfWidget(
      CheckboxOptions options, Checkbox? contextWidget) async {
    final Checkbox checkbox = contextWidget ?? this;

    if (options.interactive) {
      return pw.Center(
        child: pw.Checkbox(
          name: checkbox.hashCode.toString(),
          value: checkbox.value!,
          tristate: checkbox.tristate,
          activeColor: checkbox.activeColor?.toPdfColor() ?? PdfColors.blue,
          checkColor: checkbox.checkColor?.toPdfColor() ?? PdfColors.white,
          decoration: (await options
                  .getBoxDecoration(checkbox.key)
                  ?.toPdfBoxDecoration()) ??
              getCheckboxDecoration(checkbox),
        ),
      );
    } else {
      return pw.Center(
        child: pw.Container(
          height: 13,
          width: 13,
          decoration: checkbox.value == null || !checkbox.value!
              ? (await options
                      .getBoxDecoration(checkbox.key)
                      ?.toPdfBoxDecoration()) ??
                  getCheckboxDecoration(checkbox)
              : null,
          child: checkbox.value != null && checkbox.value!
              ? pw.Center(
                  child: pw.CustomPaint(
                    size: const PdfPoint(13, 13),
                    painter: (PdfGraphics canvas, PdfPoint size) {
                      canvas
                        ..drawRect(0, 0, 13, 13)
                        ..setFillColor(checkbox.activeColor?.toPdfColor() ??
                            PdfColors.blue)
                        ..fillPath()
                        ..moveTo(2, 13 / 2)
                        ..lineTo(13 / 3, 13 / 4)
                        ..lineTo(13 - 2, 13 / 4 * 3)
                        ..setStrokeColor(checkbox.checkColor?.toPdfColor() ??
                            PdfColors.white)
                        ..setLineWidth(2)
                        ..strokePath();
                    },
                  ),
                )
              : null,
        ),
      );
    }
  }
}

/// Returns the [pw.BoxDecoration] for the given [Checkbox].
pw.BoxDecoration getCheckboxDecoration(Checkbox checkbox) {
  final pw.Border defaultBorder = pw.Border.all(
    color: checkbox.side?.color.toPdfColor() ?? PdfColors.black,
    width: checkbox.side?.width ?? 1.0,
    style: checkbox.side?.style.toPdfBorderStyle() ?? pw.BorderStyle.solid,
  );

  switch (checkbox.shape.runtimeType) {
    case RoundedRectangleBorder:
      return pw.BoxDecoration(
        color: checkbox.fillColor?.resolve({})?.toPdfColor(),
        borderRadius: ((checkbox.shape as RoundedRectangleBorder).borderRadius
                as BorderRadius)
            .toPdfBorderRadius(),
        border: defaultBorder,
      );
    case CircleBorder:
      return pw.BoxDecoration(
        shape: pw.BoxShape.circle,
        color: checkbox.fillColor?.resolve({})?.toPdfColor(),
        border: defaultBorder,
      );
    default:
      return pw.BoxDecoration(border: defaultBorder);
  }
}
