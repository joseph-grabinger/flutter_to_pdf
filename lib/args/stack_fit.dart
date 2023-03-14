import 'package:flutter/widgets.dart' show StackFit;

import 'package:pdf/widgets.dart' as pw show StackFit;


extension StackFitConverter on StackFit {
  pw.StackFit toPdfStackFit() {
    switch (this) {
      case StackFit.loose:
        return pw.StackFit.loose;
      case StackFit.expand:
        return pw.StackFit.expand;
      case StackFit.passthrough:
        return pw.StackFit.passthrough;
    }
  }
}
