import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';


late Document pdf;
final ExportDelegate exportDelegate = ExportDelegate();

void main() {
  setUpAll(() {
    Document.debug = true;
    pdf = Document();
  });

  testWidgets('Clip Widgets ClipRect', (tester) async {
    late BuildContext exportContext;

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: Builder(
          builder: (BuildContext context) {
            exportContext = context;
            return ClipRect(
              child: Transform.rotate(
                angle: 0.1,
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.blue,
                ),
              ),
            );
          },
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage(exportContext));
  });

  testWidgets('Clip Widgets ClipRRect', (tester) async {
    late BuildContext exportContext;

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: Builder(
          builder: (BuildContext context) {
            exportContext = context;
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 200,
                height: 200,
                color: Colors.blue,
              ),
            );
          },
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage(exportContext));
  });

  testWidgets('Clip Widgets ClipOval', (tester) async {
    late BuildContext exportContext;

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: Builder(
          builder: (BuildContext context) {
            exportContext = context;
            return ClipOval(
              child: Container(
                width: 200,
                height: 200,
                color: Colors.blue,
              ),
            );
          },
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage(exportContext));
  });

  tearDownAll(() async {
    final file = File('./test/output/widgets-clip.pdf');
    file.writeAsBytesSync(await pdf.save());
  });
}
