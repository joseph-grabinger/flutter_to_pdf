import 'package:flutter/material.dart'
    show
        ButtonStyleButton,
        EdgeInsets,
        BeveledRectangleBorder,
        BorderRadius,
        CircleBorder,
        ContinuousRectangleBorder,
        OutlinedBorder,
        RoundedRectangleBorder,
        StadiumBorder,
        debugPrint;

import 'package:pdf/pdf.dart' show PdfColor, PdfColors;
import 'package:pdf/widgets.dart' as pw
    show
        FlatButton,
        Widget,
        BoxDecoration,
        Border,
        BoxShape,
        EdgeInsets,
        BorderRadius;

import '/args/border_side.dart';
import '/args/color.dart';
import '/args/edge_insets.dart';
import '/args/border_radius.dart';

/// Extension on [ButtonStyleButton] to convert it to the pdf equivalent [pw.FlatButton].
extension ButtonConverter on ButtonStyleButton {
  /// Converts the [ButtonStyleButton] to a [pw.FlatButton].
  pw.FlatButton toPdfWidget(pw.Widget child) => pw.FlatButton(
        name: hashCode.toString(),
        textColor: style?.foregroundColor?.resolve({})?.toPdfColor() ??
            PdfColors.white,
        decoration: pw.BoxDecoration(
          border: style?.side?.resolve({}) != null
              ? pw.Border.fromBorderSide(
                  style!.side!.resolve({})!.toPdfBorderSide())
              : null,
          color: style?.backgroundColor?.resolve({})?.toPdfColor() ??
              const PdfColor(0.2, 0.4, 0.4, 0.1)
                  .flatten(background: PdfColors.white),
          shape: style?.shape != null
              ? style!.shape!.resolve({})!.toPdfBoxShape()
              : pw.BoxShape.rectangle,
          borderRadius: style?.shape?.resolve({})?.toPdfBorderRadius(),
        ),
        padding:
            (style?.padding?.resolve({}) as EdgeInsets?)?.toPdfEdgeInsets() ??
                const pw.EdgeInsets.all(4.0),
        child: child,
      );
}

/// Extension on [OutlinedBorder] to convert it to the pdf equivalent [pw.BoxShape].
extension OutlinedBorderConverter on OutlinedBorder {
  /// Converts the [OutlinedBorder] to a [pw.BoxShape].
  pw.BoxShape toPdfBoxShape() {
    switch (runtimeType) {
      case const (CircleBorder):
        return pw.BoxShape.circle;
      case const (StadiumBorder):
        return pw.BoxShape.circle;
      case const (RoundedRectangleBorder):
        return pw.BoxShape.rectangle;
      case const (BeveledRectangleBorder):
        return pw.BoxShape.rectangle;
      case const (ContinuousRectangleBorder):
        return pw.BoxShape.rectangle;
      // unsupported by pdf package:
      // - StadiumBorder
      // - RoundedRectangleBorder
      // - BeveledRectangleBorder
      // - ContinuousRectangleBorder
      default:
        debugPrint(
            'Unsupported OutlinedBorder: $this; defaulting to rectangle border shape');
        return pw.BoxShape.rectangle;
    }
  }

  /// Converts the [OutlinedBorder] to a [pw.BorderRadius].
  pw.BorderRadius toPdfBorderRadius() {
    switch (runtimeType) {
      case const (CircleBorder):
        return pw.BorderRadius.circular(1000);
      case const (StadiumBorder):
        return pw.BorderRadius.circular(10);
      case const (RoundedRectangleBorder):
        return ((this as RoundedRectangleBorder).borderRadius as BorderRadius)
            .toPdfBorderRadius();
      case const (BeveledRectangleBorder):
        return ((this as BeveledRectangleBorder).borderRadius as BorderRadius)
            .toPdfBorderRadius();
      case const (ContinuousRectangleBorder):
        return ((this as ContinuousRectangleBorder).borderRadius
                as BorderRadius)
            .toPdfBorderRadius();
      default:
        debugPrint(
            'Unsupported OutlinedBorder: $this; defaulting to circular border radius');
        return pw.BorderRadius.circular(1000);
    }
  }
}
