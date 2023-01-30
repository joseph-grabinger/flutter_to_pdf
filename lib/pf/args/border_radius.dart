import 'package:flutter/widgets.dart';
import 'package:pdf/widgets.dart' as pw;

import 'radius.dart';

class PfBorderRadius {
  /// Creates a border radius where all radii are [radius].
  const PfBorderRadius.all(PfRadius radius)
      : this.only(
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        );

  /// Creates a border radius where all radii are [Radius.circular(radius)].
  PfBorderRadius.circular(double radius)
      : this.all(
          PfRadius.circular(radius),
        );

  /// Creates a vertically symmetric border radius where the top and bottom
  /// sides of the rectangle have the same radii.
  const PfBorderRadius.vertical({
    PfRadius top = PfRadius.zero,
    PfRadius bottom = PfRadius.zero,
  }) : this.only(
          topLeft: top,
          topRight: top,
          bottomLeft: bottom,
          bottomRight: bottom,
        );

  /// Creates a horizontally symmetrical border radius where the left and right
  /// sides of the rectangle have the same radii.
  const PfBorderRadius.horizontal({
    PfRadius left = PfRadius.zero,
    PfRadius right = PfRadius.zero,
  }) : this.only(
          topLeft: left,
          topRight: right,
          bottomLeft: left,
          bottomRight: right,
        );

  /// Creates a border radius with only the given non-zero values. The other
  /// corners will be right angles.
  const PfBorderRadius.only({
    this.topLeft = PfRadius.zero,
    this.topRight = PfRadius.zero,
    this.bottomLeft = PfRadius.zero,
    this.bottomRight = PfRadius.zero,
  });

  /// A border radius with all zero radii.
  static const PfBorderRadius zero = PfBorderRadius.all(PfRadius.zero);

  /// The top-left [Radius].
  final PfRadius topLeft;

  /// The top-right [Radius].
  final PfRadius topRight;

  /// The bottom-left [Radius].
  final PfRadius bottomLeft;

  /// The bottom-right [Radius].
  final PfRadius bottomRight;

  BorderRadius toFl() {
    return BorderRadius.only(
      topLeft: topLeft.toFl(),
      topRight: topRight.toFl(),
      bottomLeft: bottomLeft.toFl(),
      bottomRight: bottomRight.toFl(),
    );
  }

  pw.BorderRadius toPw() {
    return pw.BorderRadius.only(
      topLeft: topLeft.toPw(),
      topRight: topRight.toPw(),
      bottomLeft: bottomLeft.toPw(),
      bottomRight: bottomRight.toPw(),
    );
  }
}