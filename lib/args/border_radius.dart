import 'package:flutter/widgets.dart' show BorderRadius, Radius;

import 'package:pdf/widgets.dart' as pw show BorderRadius, Radius;


extension BorderRadiusConverter on BorderRadius {
  pw.BorderRadius toPdfBorderRadius() => pw.BorderRadius.only(
    topLeft: topLeft.toPdfRadius(),
    topRight: topRight.toPdfRadius(),
    bottomLeft: bottomLeft.toPdfRadius(),
    bottomRight: bottomRight.toPdfRadius(),
  );

  double toPdfHorizontalRadius() => topLeft.x;

  double toPdfVerticalRadius() => topLeft.y;
}

extension RadiusConverter on Radius {
  pw.Radius toPdfRadius() => pw.Radius.elliptical(x, y);
}
