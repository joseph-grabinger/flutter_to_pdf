import 'package:flutter/widgets.dart' show Radius;

import 'package:pdf/widgets.dart' as pw show Radius;


extension RadiusConverter on Radius {
  pw.Radius toPdfRadius() {
    print('RadiusConverter: $this');
    return pw.Radius.elliptical(x, y);
  }
}