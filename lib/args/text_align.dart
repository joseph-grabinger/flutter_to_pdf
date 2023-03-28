import 'package:flutter/widgets.dart' show TextAlign, debugPrint;

import 'package:pdf/widgets.dart' as pw show TextAlign;

extension TextAlignConverter on TextAlign {
  pw.TextAlign? toPdfTextAlign() {
    switch (this) {
      case TextAlign.center:
        return pw.TextAlign.center;
      case TextAlign.justify:
        return pw.TextAlign.justify;
      case TextAlign.left:
        return pw.TextAlign.left;
      case TextAlign.right:
        return pw.TextAlign.right;
      // not supported in pdf package:
      // - TextAlign.end
      // - TextAlign.start
      default:
        debugPrint('Unsupported TextAlign: $this; defaulting to null');
        return null;
    }
  }
}
