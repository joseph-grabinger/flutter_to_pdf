import 'package:flutter/widgets.dart' show BoxDecoration, Table, TableBorder, TableColumnWidth, FixedColumnWidth, FlexColumnWidth, FractionColumnWidth, IntrinsicColumnWidth,TableCellVerticalAlignment, debugPrint;

import 'package:pdf/widgets.dart' as pw show Table, TableRow, Widget, TableBorder, TableCellVerticalAlignment, TableColumnWidth, IntrinsicColumnWidth, FixedColumnWidth, FlexColumnWidth, FractionColumnWidth;

import '/args/box_decoration.dart';
import '/args/border_side.dart';


extension TableConverter on Table {
  Future<pw.Table> toPdfWidget(List<pw.Widget> children) async => pw.Table(
    border: border?.toPdfTableBorder(),
    columnWidths: columnWidths?.map((int key, TableColumnWidth value) => MapEntry(
      key, value.toPdfTableColumnWidth(),
    )),
    defaultColumnWidth: defaultColumnWidth.toPdfTableColumnWidth(),
    defaultVerticalAlignment: defaultVerticalAlignment.toPdfTableCellVerticalAlignment(),
    children: [
      for (int i = 0; i < this.children.length; i++)
        pw.TableRow(
          decoration: await (this.children[i].decoration as BoxDecoration?)?.toPdfBoxDecoration(),
          children: children.getRange(
            i*(children.length~/this.children.length),
            (i+1)*(children.length~/this.children.length),
          ).toList(),
        ),
    ],
  );
}

extension TableBorderConverter on TableBorder {
  pw.TableBorder toPdfTableBorder() => pw.TableBorder(
    horizontalInside: horizontalInside.toPdfBorderSide(),
    verticalInside: verticalInside.toPdfBorderSide(),
    top: top.toPdfBorderSide(),
    right: right.toPdfBorderSide(),
    bottom: bottom.toPdfBorderSide(),
    left: left.toPdfBorderSide(),
  );
}

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
        debugPrint('Unsupported TableColumnWidth: $this; defaulting to IntrinsicColumnWidth');
        return const pw.IntrinsicColumnWidth();
    }
  }
}

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
        debugPrint('Unsupported TableCellVerticalAlignment: $this; defaulting to TableCellVerticalAlignment.top');
        return pw.TableCellVerticalAlignment.top;
    }
  }
}
