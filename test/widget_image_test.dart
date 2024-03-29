import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'utils.dart';

late pw.Document pdf;
final ExportDelegate exportDelegate = ExportDelegate();

void main() {
  setUpAll(() {
    pw.Document.debug = true;
    pdf = pw.Document();
  });

  testWidgets('Image Widgets MemoryImage', (tester) async {
    final image = MemoryImage(getImageBytes());

    final widgets = <Widget>[];
    for (final fit in BoxFit.values) {
      widgets.add(Container(
        width: 100,
        height: 100,
        alignment: Alignment.center,
        child: Image(
          fit: fit,
          image: image,
        ),
      ));
    }

    await tester.pumpWidget(ExportFrame(
      frameId: 'memory image',
      exportDelegate: exportDelegate,
      child: Wrap(
        textDirection: TextDirection.ltr,
        children: widgets,
      ),
    ));

    await tester.runAsync(() async {
      pdf.addPage(await exportDelegate.exportToPdfPage('memory image'));
    });
  });

  tearDownAll(() async {
    final file = File('./test/output/widgets-image.pdf');
    file.writeAsBytesSync(await pdf.save());
  });
}
