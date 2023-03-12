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

  testWidgets('Multichild Widgets Row', (tester) async {
    late BuildContext exportContext;

    for (final crossAxisAlignment in CrossAxisAlignment.values.where(
      (alignment) => alignment != CrossAxisAlignment.baseline)) {
      for (final mainAxisAlignment in MainAxisAlignment.values) {
        await tester.pumpWidget(Builder(
          builder: (BuildContext context) {
            exportContext = context;
            return Row(
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: crossAxisAlignment,
              textDirection: TextDirection.ltr,
              children: [
                Container(
                  width: 100,
                  height: 400,
                  color: Colors.blue,
                ),
                Container(
                  width: 100,
                  height: 400,
                  color: Colors.red,
                ),
                Container(
                  width: 100,
                  height: 400,
                  color: Colors.yellow,
                ),
                Container(
                  width: 100,
                  height: 400,
                  color: Colors.green,
                ),
              ],
            );
          },
        ));

        pdf.addPage(await exportToPdfPage(exportContext));
      }
    }
  });

  testWidgets('Multichild Widgets Column', (tester) async {
    late BuildContext exportContext;

    for (final crossAxisAlignment in CrossAxisAlignment.values.where(
      (alignment) => alignment != CrossAxisAlignment.baseline)) {
      for (final mainAxisAlignment in MainAxisAlignment.values) {
        await tester.pumpWidget(Builder(
          builder: (BuildContext context) {
            exportContext = context;
            return Column(
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: crossAxisAlignment,
              textDirection: TextDirection.ltr,
              children: [
                Container(
                  width: 400,
                  height: 100,
                  color: Colors.blue,
                ),
                Container(
                  width: 400,
                  height: 100,
                  color: Colors.red,
                ),
                Container(
                  width: 400,
                  height: 100,
                  color: Colors.yellow,
                ),
                Container(
                  width: 400,
                  height: 100,
                  color: Colors.green,
                ),
              ],
            );
          },
        ));

        pdf.addPage(await exportToPdfPage(exportContext));
      }
    }
  });

  testWidgets('Multichild Widgets Stack', (tester) async {
    late BuildContext exportContext;

    for (final fit in StackFit.values) {
      await tester.pumpWidget(Builder(
        builder: (BuildContext context) {
          exportContext = context;
          return Stack(
            fit: fit,
            textDirection: TextDirection.ltr,
            children: [
              Container(
                width: 400,
                height: 400,
                color: Colors.blue,
              ),
              Container(
                width: 200,
                height: 200,
                color: Colors.red,
              ),
              Container(
                width: 100,
                height: 100,
                color: Colors.yellow,
              ),
              Container(
                width: 50,
                height: 50,
                color: Colors.green,
              ),
            ],
          );
        },
      ));

      pdf.addPage(await exportToPdfPage(exportContext));
    }
  });

  testWidgets('Multichild Widgets ListView', (tester) async {
    late BuildContext exportContext;

    for (final scrollDirection in Axis.values) {
      await tester.pumpWidget(Builder(
        builder: (BuildContext context) {
          exportContext = context;
          return Directionality(
            textDirection: TextDirection.ltr,
            child: ListView(
              scrollDirection: scrollDirection,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                ),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                ),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.yellow,
                ),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.green,
                ),
              ],
            ),
          );
        },
      ));

      pdf.addPage(await exportToPdfPage(exportContext));
    }
  });

  testWidgets('Multichild Widgets ListView builder', (tester) async {
    late BuildContext exportContext;

    for (final scrollDirection in Axis.values) {
      await tester.pumpWidget(Builder(
        builder: (BuildContext context) {
          exportContext = context;
          return Directionality(
            textDirection: TextDirection.ltr,
            child: ListView.builder(
              scrollDirection: scrollDirection,
              itemCount: 100,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 10,
                  height: 10,
                  color: index%2 == 0 ?Colors.blue : Colors.red,
                );
              },
            ),
          );
        },
      ));

      pdf.addPage(await exportToPdfPage(exportContext));
    }
  });

  tearDownAll(() async {
    final file = File('./test/output/widgets-multichild.pdf');
    file.writeAsBytesSync(await pdf.save());
  });
}
