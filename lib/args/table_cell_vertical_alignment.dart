import 'package:flutter/widgets.dart' show TableCellVerticalAlignment, debugPrint;

import 'package:pdf/widgets.dart' as pw show TableCellVerticalAlignment;


extension TableCellVerticalAlignmentConverter on TableCellVerticalAlignment {
  pw.TableCellVerticalAlignment toPdfTableCellVerticalAlignment() {
    switch (this) {
      case TableCellVerticalAlignment.top:
        return pw.TableCellVerticalAlignment.top;
      case TableCellVerticalAlignment.middle:
        return pw.TableCellVerticalAlignment.middle;
      case TableCellVerticalAlignment.bottom:
        return pw.TableCellVerticalAlignment.bottom;
      case TableCellVerticalAlignment.fill:
        return pw.TableCellVerticalAlignment.full;
      // not supported by pdf package:
      // - TableCellVerticalAlignment.baseline
      default:
        debugPrint('Unsupported TableCellVerticalAlignment: $this');
        return pw.TableCellVerticalAlignment.top;
    }
  }
}