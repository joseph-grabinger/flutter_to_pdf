import 'package:flutter/widgets.dart' show TextOverflow;

import 'package:pdf/widgets.dart' as pw show TextOverflow;


extension TextOverlfowConverter on TextOverflow {
  pw.TextOverflow toPdfTextOverflow() {
    switch (this) {
      case TextOverflow.clip:
        return pw.TextOverflow.clip;
      case TextOverflow.visible:
        return pw.TextOverflow.visible;
      // not supported in pdf package:
      // - TextOverflow.ellipsis
      // - TextOverflow.fade
      default:
        return pw.TextOverflow.span;
    }
  }
}