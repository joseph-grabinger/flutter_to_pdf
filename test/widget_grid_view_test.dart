import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';
import 'package:pdf/widgets.dart' as pw;


late pw.Document pdf;
final ExportDelegate exportDelegate = ExportDelegate();

void main() async {
  setUpAll(() {
    pw.Document.debug = true;
    pdf = pw.Document();
  });

  testWidgets('GridView Widgets Empty', (tester) async {
    await tester.pumpWidget(ExportFrame(
      frameId: 'grid view empty',
      exportDelegate: exportDelegate,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 1,
          ),
          children: const <Widget>[],
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('grid view empty'));
  });

  testWidgets('GridView Widgets Vertical', (tester) async {
    await tester.pumpWidget(ExportFrame(
      frameId: 'grid view vertical',
      exportDelegate: exportDelegate,
      child: Directionality(
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
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('grid view vertical'));
  });

  testWidgets('GridView Widgets Horizontal', (tester) async {
    await tester.pumpWidget(ExportFrame(
      frameId: 'grid view horizontal',
      exportDelegate: exportDelegate,
      child: Directionality(
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
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('grid view horizontal'));
  });

  testWidgets('GridView Widgets Count', (tester) async {
    await tester.pumpWidget(ExportFrame(
      frameId: 'grid view count',
      exportDelegate: exportDelegate,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: GridView.count(
          crossAxisCount: 20,
          children: List<Widget>.generate(40,
            (int index) => Center(child: Text('$index')),
          ),
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('grid view count'));
  });

  testWidgets('GridView Widgets Extent', (tester) async {
    await tester.pumpWidget(ExportFrame(
      frameId: 'grid view extent',
      exportDelegate: exportDelegate,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: GridView.extent(
          maxCrossAxisExtent: 70,
          children: List<Widget>.generate(40,
            (int index) => Center(child: Text('$index')),
          ),
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('grid view extent'));
  });

  tearDownAll(() async {
    final file = File('./test/output/widgets-gridview.pdf');
    file.writeAsBytesSync(await pdf.save());
  });
}
