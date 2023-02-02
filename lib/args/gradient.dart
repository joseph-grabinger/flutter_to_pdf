import 'package:flutter/widgets.dart';
import 'package:pdf/widgets.dart' as pw;

import 'color.dart';

abstract class PfGradient {
  /// Initialize the gradient's colors and stops.
  const PfGradient({
    required this.colors,
    this.stops,
  });

  final List<PfColor> colors;

  /// A list of values from 0.0 to 1.0 that denote fractions along the gradient.
  final List<double>? stops;

  Gradient toFl();

  pw.Gradient toPw();
}