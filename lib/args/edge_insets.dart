import 'package:flutter/widgets.dart' show EdgeInsets;

import 'package:pdf/widgets.dart' as pw show EdgeInsets;


extension EdgeInsetsConverter on EdgeInsets {
  pw.EdgeInsets toPdfEdgeInsets() => pw.EdgeInsets.fromLTRB(
    left,
    top,
    right,
    bottom,
  );
}