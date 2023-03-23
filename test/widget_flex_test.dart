import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';
import 'package:pdf/widgets.dart' as pw;


late pw.Document pdf;
final ExportDelegate exportDelegate = ExportDelegate();

void main() {
  setUpAll(() {
    pw.Document.debug = true;
    pdf = pw.Document();
  });

  testWidgets('Flex Widgets Flexible', (tester) async {
    for (final fit in FlexFit.values) {
      for (final flex in [0, 1, 2, 3, 4, 5]) {
        await tester.pumpWidget(ExportFrame(
          frameId: 'flexible $fit $flex',
          exportDelegate: exportDelegate,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              children: [
                Flexible(
                  fit: fit,
                  flex: flex,
                  child: Container(
                    width: 100,
                    height: 400,
                    color: Colors.blue,
                    child: Text('$flex'),
                  ),
                ),
                Flexible(
                  fit: fit,
                  flex: flex + 1,
                  child: Container(
                    width: 100,
                    height: 400,
                    color: Colors.red,
                    child: Text('${flex + 1}'),
                  ),
                ),
                Flexible(
                  fit: fit,
                  flex: flex + 2,
                  child: Container(
                    width: 100,
                    height: 400,
                    color: Colors.yellow,
                    child: Text('${flex + 2}'),
                  ),
                ),
                Flexible(
                  fit: fit,
                  flex: flex + 3,
                  child: Container(
                    width: 100,
                    height: 400,
                    color: Colors.green,
                    child: Text('${flex + 3}'),
                  ),
                ),
              ],
            ),
          ),
        ));

        pdf.addPage(await exportDelegate.exportToPdfPage('flexible $fit $flex'));
      }
    }
  });

    testWidgets('Flex Widgets Expanded', (tester) async {
    for (final flex in [0, 1, 2, 3, 4, 5]) {
      await tester.pumpWidget(ExportFrame(
        frameId: 'expanded $flex',
        exportDelegate: exportDelegate,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            children: [
              Expanded(
                flex: flex,
                child: Container(
                  width: 100,
                  height: 400,
                  color: Colors.blue,
                  child: Text('$flex'),
                ),
              ),
              Expanded(
                flex: flex + 1,
                child: Container(
                  width: 100,
                  height: 400,
                  color: Colors.red,
                  child: Text('${flex + 1}'),
                ),
              ),
              Expanded(
                flex: flex + 2,
                child: Container(
                  width: 100,
                  height: 400,
                  color: Colors.yellow,
                  child: Text('${flex + 2}'),
                ),
              ),
              Expanded(
                flex: flex + 3,
                child: Container(
                  width: 100,
                  height: 400,
                  color: Colors.green,
                  child: Text('${flex + 3}'),
                ),
              ),
            ],
          ),
        ),
      ));

      pdf.addPage(await exportDelegate.exportToPdfPage('expanded $flex'));
    }
  });

  tearDownAll(() async {
    final file = File('./test/output/widgets-flex.pdf');
    file.writeAsBytesSync(await pdf.save());
  });
}
