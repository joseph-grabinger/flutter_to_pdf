import 'package:flutter/widgets.dart';
import 'package:pdf/widgets.dart' as pw;

import 'border_style.dart';
import 'color.dart';

class PfBorderSide {
  /// Creates the side of a border.
  const PfBorderSide({
    this.color = const PfColor(0xff000000),
    this.width = 1.0,
    this.style = PfBorderStyle.solid,
  });

  /// A hairline black border that is not rendered.
  static const PfBorderSide none =
      PfBorderSide(width: 0.0, style: PfBorderStyle.none);

  /// The color of this side of the border.
  final PfColor color;

  /// The width of this side of the border.
  final double width;

  /// The style of this side of the border.
  final PfBorderStyle style;

  BorderSide toFl() {
    return BorderSide(
      color: color.toFl(),
      width: width,
      style: style.toFl(),
    );
  }

  pw.BorderSide toPw() {
    return pw.BorderSide(
      color: color.toPw(),
      width: width,
      style: style.toPw(),
    );
  }
}