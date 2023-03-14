import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teaplates/teaplates.dart';


late Document pdf;

void main() {
  setUpAll(() {
    Document.debug = true;
    pdf = Document();
  });

  testWidgets('Flex Widgets Flexible', (tester) async {
    late BuildContext exportContext;

    for (final fit in FlexFit.values) {
      for (final flex in [0, 1, 2, 3, 4, 5]) {
        await tester.pumpWidget(Builder(
          builder: (BuildContext context) {
            exportContext = context;
            return Directionality(
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
            );
          },
        ));

        pdf.addPage(await exportToPdfPage(exportContext));
      }
    }
  });

    testWidgets('Flex Widgets Expanded', (tester) async {
    late BuildContext exportContext;

    for (final flex in [0, 1, 2, 3, 4, 5]) {
      await tester.pumpWidget(Builder(
        builder: (BuildContext context) {
          exportContext = context;
          return Row(
            textDirection: TextDirection.ltr,
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
          );
        },
      ));

      pdf.addPage(await exportToPdfPage(exportContext));
    }
  });

  tearDownAll(() async {
    final file = File('./test/output/widgets-flex.pdf');
    file.writeAsBytesSync(await pdf.save());
  });
}