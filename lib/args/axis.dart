import 'package:flutter/widgets.dart' show Axis;

import 'package:pdf/widgets.dart' as pw show Axis;


extension AxisConverter on Axis {
  pw.Axis toPdfAxis() {
    switch (this) {
      case Axis.horizontal:
        return pw.Axis.horizontal;
      case Axis.vertical:
        return pw.Axis.vertical;
    }
  }
}
