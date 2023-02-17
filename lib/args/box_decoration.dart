import 'package:flutter/widgets.dart' show Border, BorderRadius, BoxDecoration, BoxShadow;

import 'package:pdf/widgets.dart' as pw show BoxDecoration, BoxShadow;

import 'color.dart';
import 'border.dart';
import 'border_radius.dart';
import 'box_shape.dart';
import 'box_shadow.dart';
import 'gradient.dart';
import 'decoration_image.dart';


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