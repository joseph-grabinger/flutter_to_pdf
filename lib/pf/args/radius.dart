import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/widgets.dart';

class PfRadius {
  /// Constructs a circular radius. [x] and [y] will have the same radius value.
  const PfRadius.circular(double radius) : this.elliptical(radius, radius);

  /// Constructs an elliptical radius with the given radii.
  const PfRadius.elliptical(this.x, this.y);

  /// The radius value on the horizontal axis.
  final double x;

  /// The radius value on the vertical axis.
  final double y;

  /// A radius with [x] and [y] values set to zero.
  static const PfRadius zero = PfRadius.circular(0.0);

  Radius toFl() {
    return Radius.elliptical(x, y);
  }

  pw.Radius toPw() {
    return pw.Radius.elliptical(x, y);
  }

}