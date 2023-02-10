import 'package:flutter/widgets.dart';
import 'package:pdf/widgets.dart' as pw;

enum PfBoxFit { fill, contain, cover, fitWidth, fitHeight, none, scaleDown }

extension PfBoxFitExt on PfBoxFit {
  BoxFit toFl() {
    switch (this) {
      case PfBoxFit.fill:
        return BoxFit.fill;
      case PfBoxFit.contain:
        return BoxFit.contain;
      case PfBoxFit.cover:
        return BoxFit.cover;
      case PfBoxFit.fitWidth:
        return BoxFit.fitWidth;
      case PfBoxFit.fitHeight:
        return BoxFit.fitHeight;
      case PfBoxFit.none:
        return BoxFit.none;
      case PfBoxFit.scaleDown:
        return BoxFit.scaleDown;
    }
  }

  pw.BoxFit toPw() {
    switch (this) {
      case PfBoxFit.fill:
        return pw.BoxFit.fill;
      case PfBoxFit.contain:
        return pw.BoxFit.contain;
      case PfBoxFit.cover:
        return pw.BoxFit.cover;
      case PfBoxFit.fitWidth:
        return pw.BoxFit.fitWidth;
      case PfBoxFit.fitHeight:
        return pw.BoxFit.fitHeight;
      case PfBoxFit.none:
        return pw.BoxFit.none;
      case PfBoxFit.scaleDown:
        return pw.BoxFit.scaleDown;
    }
  }
}