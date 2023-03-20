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

  testWidgets('Multichild Widgets Row', (tester) async {
    for (final crossAxisAlignment in CrossAxisAlignment.values.where(
      (alignment) => alignment != CrossAxisAlignment.baseline)) {
      for (final mainAxisAlignment in MainAxisAlignment.values) {
        await tester.pumpWidget(ExportFrame(
          frameId: 'row $mainAxisAlignment $crossAxisAlignment',
          exportDelegate: exportDelegate,
          child: Row(
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
          ),
        ));

        pdf.addPage(await exportDelegate.exportToPdfPage('row $mainAxisAlignment $crossAxisAlignment'));
      }
    }
  });

  testWidgets('Multichild Widgets Column', (tester) async {
    for (final crossAxisAlignment in CrossAxisAlignment.values.where(
      (alignment) => alignment != CrossAxisAlignment.baseline)) {
      for (final mainAxisAlignment in MainAxisAlignment.values) {
        await tester.pumpWidget(ExportFrame(
          frameId: 'column $mainAxisAlignment $crossAxisAlignment',
          exportDelegate: exportDelegate,
          child: Column(
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
          ),
        ));

        pdf.addPage(await exportDelegate.exportToPdfPage('column $mainAxisAlignment $crossAxisAlignment'));
      }
    }
  });

  testWidgets('Multichild Widgets Stack', (tester) async {
    for (final fit in StackFit.values) {
      await tester.pumpWidget(ExportFrame(
        frameId: 'stack $fit',
        exportDelegate: exportDelegate,
        child: Stack(
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
        ),
      ));

      pdf.addPage(await exportDelegate.exportToPdfPage('stack $fit'));
    }
  });

  testWidgets('Multichild Widgets ListView', (tester) async {
    for (final scrollDirection in Axis.values) {
      await tester.pumpWidget(ExportFrame(
        frameId: 'listview $scrollDirection',
        exportDelegate: exportDelegate,
        child: Directionality(
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
        ),
      ));

      pdf.addPage(await exportDelegate.exportToPdfPage('listview $scrollDirection'));
    }
  });

  testWidgets('Multichild Widgets ListView Builder', (tester) async {
    for (final scrollDirection in Axis.values) {
      await tester.pumpWidget(ExportFrame(
        frameId: 'listview builder $scrollDirection',
        exportDelegate: exportDelegate,
        child: Directionality(
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
        ),
      ));

      pdf.addPage(await exportDelegate.exportToPdfPage('listview builder $scrollDirection'));
    }
  });

  testWidgets('Multichild Widgets ListView Separated', (tester) async {
    for (final scrollDirection in Axis.values) {
      await tester.pumpWidget(ExportFrame(
        frameId: 'listview separated $scrollDirection',
        exportDelegate: exportDelegate,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: ListView.separated(
            scrollDirection: scrollDirection,
            itemCount: 100,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(height: 10);
            },
            itemBuilder: (BuildContext context, int index) {
              return Text(index.toString());
            },
          ),
        ),
      ));

      pdf.addPage(await exportDelegate.exportToPdfPage('listview separated $scrollDirection'));
    }
  });

  tearDownAll(() async {
    final file = File('./test/output/widgets-multichild.pdf');
    file.writeAsBytesSync(await pdf.save());
  });
}
