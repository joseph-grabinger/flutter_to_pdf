import 'package:flutter/widgets.dart';
import 'package:pdf/widgets.dart' as pw;

import 'border_side.dart';
import 'border_style.dart';
import 'color.dart';

class PfBorder {
  const PfBorder({
    this.top = PfBorderSide.none,
    this.right = PfBorderSide.none,
    this.bottom = PfBorderSide.none,
    this.left = PfBorderSide.none,
  });

  factory PfBorder.all({
    PfColor color = const PfColor(0xff000000),
    double width = 1.0,
    PfBorderStyle style = PfBorderStyle.solid,
  }) =>
    PfBorder.fromBorderSide(
      PfBorderSide(color: color, width: width, style: style),
    );

  const PfBorder.fromBorderSide(PfBorderSide side)
    : top = side,
      right = side,
      bottom = side,
      left = side,
      super();

  final PfBorderSide top;
  final PfBorderSide right;
  final PfBorderSide bottom;
  final PfBorderSide left;

  Border toFl() {
    return Border(
      top: top.toFl(),
      right: right.toFl(),
      bottom: bottom.toFl(),
      left: left.toFl(),
    );
  }

  pw.Border toPw() {
    return pw.Border(
      top: top.toPw(),
      right: right.toPw(),
      bottom: bottom.toPw(),
      left: left.toPw(),
    );
  }
}