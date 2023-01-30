import 'package:flutter/widgets.dart';
import 'package:pdf/widgets.dart' as pw;

enum PfMainAxisAlignment {
  start,
  end,
  center,
  spaceBetween,
  spaceAround,
  spaceEvenly,
}

extension PfMainAxisAlignmentExt on PfMainAxisAlignment {
  MainAxisAlignment toFl() {
    switch (this) {
      case PfMainAxisAlignment.start:
        return MainAxisAlignment.start;
      case PfMainAxisAlignment.end:
        return MainAxisAlignment.end;
      case PfMainAxisAlignment.center:
        return MainAxisAlignment.center;
      case PfMainAxisAlignment.spaceBetween:
        return MainAxisAlignment.spaceBetween;
      case PfMainAxisAlignment.spaceAround:
        return MainAxisAlignment.spaceAround;
      case PfMainAxisAlignment.spaceEvenly:
        return MainAxisAlignment.spaceEvenly;
    }
  }

  pw.MainAxisAlignment toPw() {
    switch (this) {
      case PfMainAxisAlignment.start:
        return pw.MainAxisAlignment.start;
      case PfMainAxisAlignment.end:
        return pw.MainAxisAlignment.end;
      case PfMainAxisAlignment.center:
        return pw.MainAxisAlignment.center;
      case PfMainAxisAlignment.spaceBetween:
        return pw.MainAxisAlignment.spaceBetween;
      case PfMainAxisAlignment.spaceAround:
        return pw.MainAxisAlignment.spaceAround;
      case PfMainAxisAlignment.spaceEvenly:
        return pw.MainAxisAlignment.spaceEvenly;
    }
  }
}