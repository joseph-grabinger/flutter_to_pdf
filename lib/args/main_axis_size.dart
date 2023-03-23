import 'package:flutter/widgets.dart' show MainAxisSize;

import 'package:pdf/widgets.dart' as pw show MainAxisSize;


extension MainAxisSizeConverter on MainAxisSize {
  pw.MainAxisSize toPdfMainAxisSize() {
    switch (this) {
      case MainAxisSize.min:
        return pw.MainAxisSize.min;
      case MainAxisSize.max:
        return pw.MainAxisSize.max;
    }
  }
}
