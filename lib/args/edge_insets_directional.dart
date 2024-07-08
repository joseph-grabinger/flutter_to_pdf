import 'package:flutter/widgets.dart' show EdgeInsetsDirectional;

import 'package:pdf/widgets.dart' as pw show EdgeInsets;

extension EdgeInsetsDirectionalConverter on EdgeInsetsDirectional {
  pw.EdgeInsets toPdfEdgeInsetsDirectional() => pw.EdgeInsets.only(
        left: start,
        top: top,
        right: end,
        bottom: bottom,
      );
}
