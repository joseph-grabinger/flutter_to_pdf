import 'package:flutter/material.dart' show InputBorder, InputDecoration, OutlineInputBorder, UnderlineInputBorder;

import 'package:pdf/widgets.dart' as pw show Widget, Container, BoxDecoration, Border, BorderSide;

import '/args/border_radius.dart';
import '/args/border_side.dart';


extension InputDecorationConverter on InputDecoration {
  pw.Widget toPdfWidget() => pw.Container(
    height: 30,
    decoration: border?.toPdfInputBorder(),
  );
}

extension InputBorderConverter on InputBorder {
  pw.BoxDecoration toPdfInputBorder() {
    switch (runtimeType) {
      case OutlineInputBorder:
        return (this as OutlineInputBorder).toPdfOutlineInputBorder();
      case UnderlineInputBorder:
        return (this as UnderlineInputBorder).toPdfUnderlineInputBorder();
      default:
        print('No converter for $this');
        return const pw.BoxDecoration();
    }
  }
}

extension OutlineInputBorderConverter on OutlineInputBorder {
  pw.BoxDecoration toPdfOutlineInputBorder() {
    final pw.BorderSide pdfBorderSide = borderSide.toPdfBorderSide();

    return pw.BoxDecoration(
      borderRadius: borderRadius.toPdfBorderRadius(),
      border: pw.Border.all(
        color: pdfBorderSide.color,
        width: pdfBorderSide.width,
        style: pdfBorderSide.style,
      ),
    );

  }
}

extension UnderLineInputBorderConverter on UnderlineInputBorder {
  pw.BoxDecoration toPdfUnderlineInputBorder() {
    final pw.BorderSide pdfBorderSide = borderSide.toPdfBorderSide();

    return pw.BoxDecoration(
      border: pw.Border(
        bottom: pw.BorderSide(
          color: pdfBorderSide.color,
          width: pdfBorderSide.width,
          style: pdfBorderSide.style,
        ),
      ),
    );
  }
}