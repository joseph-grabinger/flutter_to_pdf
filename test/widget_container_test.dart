import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teaplates/teaplates.dart';

import 'utils.dart';


late Document pdf;

void main() {
  setUpAll(() {
    pdf = Document();
  });

  testWidgets('Container Widget Flat', (tester) async {
    late BuildContext exportContext;

    tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(30),
          padding: const EdgeInsets.all(20),
          color: Colors.blue,
          width: 200,
          height: 400,
        );
      },
    ));

    pdf.addPage(await exportToPdfPage(exportContext));
  });

  testWidgets('Container Widget Decoration', (tester) async {
    late BuildContext exportContext;

    tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(30),
          padding: const EdgeInsets.all(20),
          width: 200,
          height: 400,
          decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(
              color: Colors.green,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        );
      },
    ));

    pdf.addPage(await exportToPdfPage(exportContext));
  });

  testWidgets('Container Widget Image', (tester) async {
    // final image = generateBitmap(100, 200);

    for (final shape in BoxShape.values) {
      for (final fit in BoxFit.values) {
        late BuildContext exportContext;

        Widget widget = Container(
          width: 100,
          height: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: shape,
            image: DecorationImage(
              // image: generateBitmap(100, 200),
              image: MemoryImage(imageBytes()),
            )
          ),
          child: Container(
            width: 70,
            color: Colors.yellow,
            child: Text('$fit\n$shape', 
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
              textScaleFactor: 0.6,
            ),
          ),
        );

        await tester.pumpWidget(Builder(
          builder: (BuildContext context) {
            exportContext = context;
            return widget;
          },
        ), const Duration(seconds: 1),);

        await tester.runAsync(() async {
          pdf.addPage(await exportToPdfPage(exportContext));
        });
      }
    }
  });

  tearDownAll(() async {
    final file = File('./test/output/widgets-container.pdf');
    file.writeAsBytesSync(await pdf.save());
  });
}
