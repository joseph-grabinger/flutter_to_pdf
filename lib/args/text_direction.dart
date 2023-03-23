import 'package:flutter/widgets.dart' show TextDirection;

import 'package:pdf/widgets.dart' as pw show TextDirection;


extension TextDirectionConverter on TextDirection {
  pw.TextDirection toPdfTextDirection() {
    switch (this) {
      case TextDirection.ltr:
        return pw.TextDirection.ltr;
      case TextDirection.rtl:
        return pw.TextDirection.rtl;
    }
  }
}
