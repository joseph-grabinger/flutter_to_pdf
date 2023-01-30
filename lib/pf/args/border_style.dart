import 'package:flutter/widgets.dart';
import 'package:pdf/widgets.dart' as pw;

enum PfBorderStyle {
  none,
  solid,
}

extension PfBorderStyleExt on PfBorderStyle {
  BorderStyle toFl() {
    switch (this) {
      case PfBorderStyle.none:
        return BorderStyle.none;
      case PfBorderStyle.solid:
        return BorderStyle.solid;
    }
  }

  pw.BorderStyle toPw() {
    switch (this) {
      case PfBorderStyle.none:
        return pw.BorderStyle.none;
      case PfBorderStyle.solid:
        return pw.BorderStyle.solid;
    }
  }
}