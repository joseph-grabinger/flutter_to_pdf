import 'package:flutter/widgets.dart' show TableColumnWidth, IntrinsicColumnWidth, FixedColumnWidth, FlexColumnWidth, FractionColumnWidth;

import 'package:pdf/widgets.dart' as pw show TableColumnWidth, IntrinsicColumnWidth, FixedColumnWidth, FlexColumnWidth, FractionColumnWidth;

extension TableColumnWidthConverter on TableColumnWidth {
  pw.TableColumnWidth toPdfTableColumnWidth() {
    switch (runtimeType) {
      case IntrinsicColumnWidth:
        return pw.IntrinsicColumnWidth(flex: flex([]));
      case FixedColumnWidth:
        return pw.FixedColumnWidth((this as FixedColumnWidth).value);
      case FlexColumnWidth:
        return pw.FlexColumnWidth((this as FlexColumnWidth).value);
      case FractionColumnWidth:
        return pw.FractionColumnWidth((this as FractionColumnWidth).value);
      default:
        print('Unsupported TableColumnWidth: $this');
        return const pw.IntrinsicColumnWidth();
    }
  }
}