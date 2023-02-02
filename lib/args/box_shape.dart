import 'package:flutter/widgets.dart';
import 'package:pdf/widgets.dart' as pw;

enum PfBoxShape { circle, rectangle }

extension PfBoxShapeExt on PfBoxShape {
  BoxShape toFl() {
    switch (this) {
      case PfBoxShape.circle:
        return BoxShape.circle;
      case PfBoxShape.rectangle:
        return BoxShape.rectangle;
    }
  }

  pw.BoxShape toPw() {
    switch (this) {
      case PfBoxShape.circle:
        return pw.BoxShape.circle;
      case PfBoxShape.rectangle:
        return pw.BoxShape.rectangle;
    }
  }
}