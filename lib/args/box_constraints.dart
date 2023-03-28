import 'package:flutter/widgets.dart' show BoxConstraints;

import 'package:pdf/widgets.dart' as pw show BoxConstraints;

extension BoxConstraintsConverter on BoxConstraints {
  pw.BoxConstraints toPdfBoxConstraints() => pw.BoxConstraints(
        minWidth: minWidth,
        maxWidth: maxWidth,
        minHeight: minHeight,
        maxHeight: maxHeight,
      );
}
