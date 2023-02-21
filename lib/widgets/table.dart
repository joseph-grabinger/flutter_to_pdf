import 'package:flutter/widgets.dart' show Table, TableColumnWidth;

import 'package:pdf/widgets.dart' as pw show Table, TableRow, Widget;

import '/args/table_border.dart';
import '/args/table_column_width.dart';
import '/args/table_cell_vertical_alignment.dart';


extension TableConverter on Table {
  pw.Widget toPdfWidget(List<pw.TableRow> children) => pw.Table(
    border: border?.toPdfTableBorder(),
    columnWidths: columnWidths?.map((int key, TableColumnWidth value) => MapEntry(
      key, value.toPdfTableColumnWidth(),
    )),
    defaultColumnWidth: defaultColumnWidth.toPdfTableColumnWidth(),
    defaultVerticalAlignment: defaultVerticalAlignment.toPdfTableCellVerticalAlignment(),
    children: children,
  );
}