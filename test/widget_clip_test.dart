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
    await tester.pumpWidget(ExportFrame(
      frameId: 'clip rect',
      exportDelegate: exportDelegate,
      child: ClipRect(
        child: Transform.rotate(
          angle: 0.1,
          child: Container(
            width: 200,
            height: 200,
            color: Colors.blue,
          ),
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('clip rect'));
  });

  testWidgets('Clip Widgets ClipRRect', (tester) async {
    await tester.pumpWidget(ExportFrame(
      frameId: 'clip rrect',
      exportDelegate: exportDelegate,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.blue,
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('clip rrect'));
  });

  testWidgets('Clip Widgets ClipOval', (tester) async {
    await tester.pumpWidget(ExportFrame(
      frameId: 'clip oval',
      exportDelegate: exportDelegate,
      child: ClipOval(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.blue,
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('clip oval'));
  });

  tearDownAll(() async {
    final file = File('./test/output/widgets-clip.pdf');
    file.writeAsBytesSync(await pdf.save());
  });
}
