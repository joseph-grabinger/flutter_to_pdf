import 'package:flutter/widgets.dart';
import 'package:pdf/widgets.dart' as pw;

enum PfVerticalDirection {
  up,
  down,
}

extension PfVerticalDirectionExt on PfVerticalDirection {
  VerticalDirection toFl() {
    switch (this) {
      case PfVerticalDirection.up:
        return VerticalDirection.up;
      case PfVerticalDirection.down:
        return VerticalDirection.down;
    }
  }

  pw.VerticalDirection toPw() {
    switch (this) {
      case PfVerticalDirection.up:
        return pw.VerticalDirection.up;
      case PfVerticalDirection.down:
        return pw.VerticalDirection.down;
    }
  }
}