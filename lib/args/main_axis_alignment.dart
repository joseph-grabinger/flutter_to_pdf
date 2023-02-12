import 'package:flutter/widgets.dart' show MainAxisAlignment;

import 'package:pdf/widgets.dart' as pw show MainAxisAlignment;


extension MainAxisAlignmentConverter on MainAxisAlignment {
  pw.MainAxisAlignment toPdfMainAxisAlignment() {
    switch (this) {
      case MainAxisAlignment.start:
        return pw.MainAxisAlignment.start;
      case MainAxisAlignment.end:
        return pw.MainAxisAlignment.end;
      case MainAxisAlignment.center:
        return pw.MainAxisAlignment.center;
      case MainAxisAlignment.spaceBetween:
        return pw.MainAxisAlignment.spaceBetween;
      case MainAxisAlignment.spaceAround:
        return pw.MainAxisAlignment.spaceAround;
      case MainAxisAlignment.spaceEvenly:
        return pw.MainAxisAlignment.spaceEvenly;
    }
  }
}