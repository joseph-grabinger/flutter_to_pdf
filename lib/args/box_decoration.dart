import 'package:flutter/widgets.dart' show Border, BorderRadius, BoxDecoration, BoxShadow, BoxShape, Alignment, DecorationImage;

import 'package:pdf/pdf.dart' show PdfPoint;
import 'package:pdf/widgets.dart' as pw show BoxDecoration, BoxShadow, Border, BoxShape, DecorationImage, BoxFit;

import 'color.dart';
import 'border_side.dart';
import 'border_radius.dart';
import 'gradient.dart';
import 'image_provider.dart';
import 'alignment.dart';
import 'box_fit.dart';


extension BoxDecorationConverter on BoxDecoration {
  Future<pw.BoxDecoration> toPdfBoxDecoration() async => pw.BoxDecoration(
    color: color?.toPdfColor(),
    border: (border as Border?)?.toPdfBorder(),
    borderRadius: (borderRadius as BorderRadius?)?.toPdfBorderRadius(),
    boxShadow: boxShadow?.map<pw.BoxShadow>((BoxShadow e) => e.toPdfBoxShadow()).toList(),
    gradient: gradient?.toPdfGradient(),
    shape: shape.toPdfBoxShape(),
    image: await image?.toPdfDecorationImage(),
  );
}

extension BorderConverter on Border {
  pw.Border toPdfBorder() => pw.Border(
    top: top.toPdfBorderSide(),
    right: right.toPdfBorderSide(),
    bottom: bottom.toPdfBorderSide(),
    left: left.toPdfBorderSide(),
  );
}

extension BoxShadowConverter on BoxShadow {
  pw.BoxShadow toPdfBoxShadow() => pw.BoxShadow(
    color: color.toPdfColor(),
    offset: PdfPoint(offset.dx, offset.dy),
    blurRadius: blurRadius,
    spreadRadius: spreadRadius,
  );
}

extension BoxShapeConverter on BoxShape {
  pw.BoxShape toPdfBoxShape() {
    switch (this) {
      case BoxShape.circle:
        return pw.BoxShape.circle;
      case BoxShape.rectangle:
        return pw.BoxShape.rectangle;
    }
  }
}

extension DecorationImageConverter on DecorationImage {
  Future<pw.DecorationImage> toPdfDecorationImage() async => pw.DecorationImage(
    image: await image.toPdfImageProvider(),
    fit: fit?.toPdfBoxFit() ?? pw.BoxFit.cover,
    alignment: (alignment as Alignment).toPdfAlignment(),
  );
}
