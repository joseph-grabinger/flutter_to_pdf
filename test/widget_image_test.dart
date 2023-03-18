import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';

import 'utils.dart';


late Document pdf;
const ExportDelegate exportDelegate = ExportDelegate();

void main() {
  setUpAll(() {
    Document.debug = true;
    pdf = Document();
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

    late BuildContext exportContext;

    await tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return Wrap(
          textDirection: TextDirection.ltr,
          children: widgets,
        );
      },
    ));

    await tester.runAsync(() async {
      pdf.addPage(await exportDelegate.exportToPdfPage(exportContext));
    });
  });

  tearDownAll(() async {
    final file = File('./test/output/widgets-image.pdf');
    file.writeAsBytesSync(await pdf.save());
  });
}
