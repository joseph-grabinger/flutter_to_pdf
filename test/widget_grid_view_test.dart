import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';


late Document pdf;
final ExportDelegate exportDelegate = ExportDelegate();

void main() async {
  setUpAll(() {
    Document.debug = true;
    pdf = Document();
  });

  testWidgets('GridView Widgets Empty', (tester) async {
    late BuildContext exportContext;

    await tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return Directionality(
          textDirection: TextDirection.ltr,
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 1,
            ),
            children: const <Widget>[],
          ),
        );
      },
    ));

    pdf.addPage(await exportDelegate._exportPage(exportContext));
  });

  testWidgets('GridView Widgets Vertical', (tester) async {
    late BuildContext exportContext;

    await tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return Directionality(
          textDirection: TextDirection.ltr,
          child: GridView(
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
            ),
            children: List<Widget>.generate(20,
              (int index) => Center(child: Text('$index')),
            ),
          ),
        );
      },
    ));

    pdf.addPage(await exportDelegate._exportPage(exportContext));
  });

  testWidgets('GridView Widgets Horizontal', (tester) async {
    late BuildContext exportContext;

    await tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return Directionality(
          textDirection: TextDirection.ltr,
          child: GridView(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 1,
            ),
            children: List<Widget>.generate(20,
              (int index) => Center(child: Text('$index')),
            ),
          ),
        );
      },
    ));

    pdf.addPage(await exportDelegate._exportPage(exportContext));
  });

  testWidgets('GridView Widgets Count', (tester) async {
    late BuildContext exportContext;

    await tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return Directionality(
          textDirection: TextDirection.ltr,
          child: GridView.count(
            crossAxisCount: 20,
            children: List<Widget>.generate(40,
              (int index) => Center(child: Text('$index')),
            ),
          ),
        );
      },
    ));

    pdf.addPage(await exportDelegate._exportPage(exportContext));
  });

  testWidgets('GridView Widgets Extent', (tester) async {
    late BuildContext exportContext;

    await tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return Directionality(
          textDirection: TextDirection.ltr,
          child: GridView.extent(
            maxCrossAxisExtent: 20,
            children: List<Widget>.generate(40,
              (int index) => Center(child: Text('$index')),
            ),
          ),
        );
      },
    ));

    pdf.addPage(await exportDelegate._exportPage(exportContext));
  });

  tearDownAll(() async {
    final file = File('./test/output/widgets-gridview.pdf');
    file.writeAsBytesSync(await pdf.save());
  });
}
