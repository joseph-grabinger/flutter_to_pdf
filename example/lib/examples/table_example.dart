import 'package:flutter/material.dart';


final Widget tableExample = Table(
  border: TableBorder.all(),
  columnWidths: const <int, TableColumnWidth>{
    0: IntrinsicColumnWidth(),
    1: FlexColumnWidth(),
    2: FixedColumnWidth(64),
  },
  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
  children: <TableRow>[
    TableRow(
      children: <Widget>[
        Container(
          height: 32,
          color: Colors.green,
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            height: 32,
            width: 32,
            color: Colors.red,
          ),
        ),
        Container(
          height: 64,
          color: Colors.blue,
        ),
      ],
    ),
    TableRow(
      decoration: const BoxDecoration(
        color: Colors.grey,
      ),
      children: <Widget>[
        Container(
          height: 64,
          width: 128,
          color: Colors.purple,
        ),
        Container(
          height: 32,
          color: Colors.yellow,
        ),
        Center(
          child: Container(
            height: 32,
            width: 32,
            color: Colors.orange,
          ),
        ),
      ],
    ),
  ],
);
