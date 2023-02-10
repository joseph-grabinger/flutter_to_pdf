import 'package:flutter/widgets.dart';
import 'package:pdf/widgets.dart' as pw;

enum PfCrossAxisAlignment {
  start,
  end,
  center,
  stretch,
}

extension PfCrossAxisAlignmentExt on PfCrossAxisAlignment {
  CrossAxisAlignment toFl() {
    switch (this) {
      case PfCrossAxisAlignment.start:
        return CrossAxisAlignment.start;
      case PfCrossAxisAlignment.end:
        return CrossAxisAlignment.end;
      case PfCrossAxisAlignment.center:
        return CrossAxisAlignment.center;
      case PfCrossAxisAlignment.stretch:
        return CrossAxisAlignment.stretch;
    }
  }

  pw.CrossAxisAlignment toPw() {
    switch (this) {
      case PfCrossAxisAlignment.start:
        return pw.CrossAxisAlignment.start;
      case PfCrossAxisAlignment.end:
        return pw.CrossAxisAlignment.end;
      case PfCrossAxisAlignment.center:
        return pw.CrossAxisAlignment.center;
      case PfCrossAxisAlignment.stretch:
        return pw.CrossAxisAlignment.stretch;
    }
  }
}