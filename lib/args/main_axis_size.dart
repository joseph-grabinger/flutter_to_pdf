import 'package:flutter/widgets.dart';
import 'package:pdf/widgets.dart' as pw;

enum PfMainAxisSize {
  min,
  max,
}

extension PfMainAxisSizeExt on PfMainAxisSize {
  MainAxisSize toFl() {
    switch (this) {
      case PfMainAxisSize.min:
        return MainAxisSize.min;
      case PfMainAxisSize.max:
        return MainAxisSize.max;
    }
  }

  pw.MainAxisSize toPw() {
    switch (this) {
      case PfMainAxisSize.min:
        return pw.MainAxisSize.min;
      case PfMainAxisSize.max:
        return pw.MainAxisSize.max;
    }
  }
}