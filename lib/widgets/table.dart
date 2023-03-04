import 'package:flutter/widgets.dart' show BoxDecoration, Table, TableColumnWidth;

import 'package:pdf/widgets.dart' as pw show Table, TableRow, Widget;

import '/args/table_border.dart';
import '/args/table_column_width.dart';
import '/args/table_cell_vertical_alignment.dart';
import '/args/box_decoration.dart';


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
            i*(this.children.length+1),
            i*this.children.length+children.length~/this.children.length
          ).toList(),
        ),
    ],
  );
}