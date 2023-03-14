import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teaplates/teaplates.dart';


late Document pdf;

void main() async {
  setUpAll(() {
    Document.debug = true;
    pdf = Document();
  });

  testWidgets('Table Widgets Empty', (tester) async {
    late BuildContext exportContext;

    await tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Table(
            children: const [],
          ),
        );
      },
    ));

    pdf.addPage(await exportToPdfPage(exportContext));
  });

  testWidgets('Table Widgets Widths', (tester) async {
    late BuildContext exportContext;

    await tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Table(
            border: TableBorder.all(),
            columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(80),
              1: FlexColumnWidth(2),
              2: FractionColumnWidth(0.2),
            },
            children: buildTable(count: 20),
          ),
        );
      },
    ));

    pdf.addPage(await exportToPdfPage(exportContext));
  });

  tearDownAll(() async {
    final file = File('./test/output/widgets-table.pdf');
    file.writeAsBytesSync(await pdf.save());
  });
}

List<TableRow> buildTable({int count = 10}) {
  final rows = <TableRow>[];
  {
    final tableRow = <Widget>[];
    for (final cell in <String>['Hue', 'Color', 'RGBA']) {
      tableRow.add(Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(5),
        child: Text(cell),
      ));
    }
    rows.add(TableRow(children: tableRow));
  }

  for (var y = 0; y < count; y++) {
    final h = math.sin(y / count) * 365;
    final Color color = Color(h.ceil());
    final tableRow = <Widget>[
      Container(
        margin: const EdgeInsets.all(5),
        child: Text('${h.toInt()}°'),
      ),
      Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
      ),
      Container(
        margin: const EdgeInsets.all(5),
        child: Text(color.toString()),
      ),
    ];
    rows.add(TableRow(children: tableRow));
  }

  return rows;
}
