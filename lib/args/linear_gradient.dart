import 'package:flutter/widgets.dart';
import 'package:pdf/widgets.dart' as pw;

import 'alignment.dart';
import 'color.dart';
import 'gradient.dart';
import 'tile_mode.dart';

class PfLinearGradient extends PfGradient {
  /// Creates a linear gradient.
  const PfLinearGradient({
    this.begin = PfAlignment.centerLeft,
    this.end = PfAlignment.centerRight,
    required List<PfColor> colors,
    List<double>? stops,
    this.tileMode = PfTileMode.clamp,
  }) : super(colors: colors, stops: stops);

  /// The offset at which stop 0.0 of the gradient is placed.
  final PfAlignment begin;

  /// The offset at which stop 1.0 of the gradient is placed.
  final PfAlignment end;

  /// How this gradient should tile the plane beyond in the region before
  final PfTileMode tileMode;

  LinearGradient toFl() {
    return LinearGradient(
      begin: begin.toFl(),
      end: end.toFl(),
      colors: colors.map((e) => e.toFl()).toList(),
      stops: stops,
      tileMode: tileMode.toFl(),
    );
  }

  pw.LinearGradient toPw() {
    return pw.LinearGradient(
      begin: begin.toPw(),
      end: end.toPw(),
      colors: colors.map((e) => e.toPw()).toList(),
      stops: stops,
      tileMode: tileMode.toPw(),
    );
  }

}