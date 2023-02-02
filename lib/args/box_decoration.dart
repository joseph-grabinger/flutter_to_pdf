import 'package:flutter/widgets.dart';

import 'package:pdf/widgets.dart' as pw;

import 'package:teaplates/args/box_shape.dart';
import 'package:teaplates/args/box_shadow.dart';
import 'package:teaplates/args/color.dart';
import 'package:teaplates/args/gradient.dart';
import 'package:teaplates/args/border.dart';
import 'package:teaplates/args/border_radius.dart';


class PfBoxDecoration {
  /// Creates a box decoration.
  ///
  /// * If [color] is null, this decoration does not paint a background color.
  /// * If [image] is null, this decoration does not paint a background image.
  /// * If [border] is null, this decoration does not paint a border.
  /// * If [borderRadius] is null, this decoration uses more efficient background
  ///   painting commands. The [borderRadius] argument must be null if [shape] is
  ///   [BoxShape.circle].
  /// * If [boxShadow] is null, this decoration does not paint a shadow.
  /// * If [gradient] is null, this decoration does not paint gradients.
  /// * If [backgroundBlendMode] is null, this decoration paints with [BlendMode.srcOver]
  ///
  /// The [shape] argument must not be null.
  const PfBoxDecoration({
    this.color,
    this.border,
    this.borderRadius,
    this.boxShadow,
    this.gradient,
    this.shape = PfBoxShape.rectangle,
  });

  final PfColor? color;
  final PfBorder? border;
  final PfBorderRadius? borderRadius;
  final List<PfBoxShadow>? boxShadow;
  final PfGradient? gradient;
  final PfBoxShape shape;

  BoxDecoration toFl() {
    return BoxDecoration(
      color: color?.toFl(),
      border: border?.toFl(),
      borderRadius: borderRadius?.toFl(),
      boxShadow: boxShadow?.map((e) => e.toFl()).toList(),
      gradient: gradient?.toFl(),
      shape: shape.toFl(),
    );
  }

  pw.BoxDecoration toPw() {
    return pw.BoxDecoration(
      color: color?.toPw(),
      border: border?.toPw(),
      borderRadius: borderRadius?.toPw(),
      boxShadow: boxShadow?.map((e) => e.toPw()).toList(),
      gradient: gradient?.toPw(),
      shape: shape.toPw(),
    );
  }
}