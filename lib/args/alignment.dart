import 'package:flutter/widgets.dart';
import 'package:pdf/widgets.dart' as pw;

class PfAlignment {
  const PfAlignment(this.x, this.y);

  /// The distance fraction in the horizontal direction.
  final double x;

  /// The distance fraction in the vertical direction.
  final double y;

  /// The top left corner.
  static const PfAlignment topLeft = PfAlignment(-1, 1);

  /// The center point along the top edge.
  static const PfAlignment topCenter = PfAlignment(0, 1);

  /// The top right corner.
  static const PfAlignment topRight = PfAlignment(1, 1);

  /// The center point along the left edge.
  static const PfAlignment centerLeft = PfAlignment(-1, 0);

  /// The center point, both horizontally and vertically.
  static const PfAlignment center = PfAlignment(0, 0);

  /// The center point along the right edge.
  static const PfAlignment centerRight = PfAlignment(1, 0);

  /// The bottom left corner.
  static const PfAlignment bottomLeft = PfAlignment(-1, -1);

  /// The center point along the bottom edge.
  static const PfAlignment bottomCenter = PfAlignment(0, -1);

  /// The bottom right corner.
  static const PfAlignment bottomRight = PfAlignment(1, -1);

  Alignment toFl() {
    return Alignment(x, y);
  }

  pw.Alignment toPw() {
    return pw.Alignment(x, y);
  }
}