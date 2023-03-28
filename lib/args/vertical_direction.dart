import 'package:flutter/widgets.dart' show VerticalDirection;

import 'package:pdf/widgets.dart' as pw show VerticalDirection;

extension VerticalDirectionConverter on VerticalDirection {
  pw.VerticalDirection toPdfVerticalDirection() {
    switch (this) {
      case VerticalDirection.up:
        return pw.VerticalDirection.up;
      case VerticalDirection.down:
        return pw.VerticalDirection.down;
    }
  }
}
