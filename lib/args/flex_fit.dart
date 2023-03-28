import 'package:flutter/widgets.dart' show FlexFit;

import 'package:pdf/widgets.dart' as pw show FlexFit;

extension FlexFitConverter on FlexFit {
  pw.FlexFit toPdfFlexFit() {
    switch (this) {
      case FlexFit.loose:
        return pw.FlexFit.loose;
      case FlexFit.tight:
        return pw.FlexFit.tight;
    }
  }
}
