
import 'package:flutter/widgets.dart';
import 'package:pdf/widgets.dart' as pw;

enum PfFlexFit{
  loose,
  tight,
}

extension PfFlexFitExt on PfFlexFit {
  pw.FlexFit toPw() {
    switch (this) {
      case PfFlexFit.loose:
        return pw.FlexFit.loose;
      case PfFlexFit.tight:
        return pw.FlexFit.tight;
    }
  }

  FlexFit toFl() {
    switch (this) {
      case PfFlexFit.loose:
        return FlexFit.loose;
      case PfFlexFit.tight:
        return FlexFit.tight;
    }
  }
}