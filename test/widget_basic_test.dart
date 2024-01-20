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

  testWidgets('Basic Widgets Align 1', (tester) async {
    await tester.pumpWidget(ExportFrame(
      frameId: 'align 1',
      exportDelegate: exportDelegate,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          width: 200,
          height: 400,
          color: Colors.blue,
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('align 1'));
  });

  testWidgets('Basic Widgets Align 2', (tester) async {
    await tester.pumpWidget(ExportFrame(
      frameId: 'align 2',
      exportDelegate: exportDelegate,
      child: Align(
        alignment: const Alignment(0.8, 0.2),
        child: Container(
          width: 200,
          height: 400,
          color: Colors.blue,
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('align 2'));
  });

  testWidgets('Basic Widgets AspectRatio', (tester) async {
    await tester.pumpWidget(ExportFrame(
      frameId: 'aspect ratio',
      exportDelegate: exportDelegate,
      child: const AspectRatio(
        aspectRatio: 1.618,
        child: Placeholder(),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('aspect ratio'));
  });

  testWidgets('Basic Widgets Center', (tester) async {
    await tester.pumpWidget(ExportFrame(
      frameId: 'center',
      exportDelegate: exportDelegate,
      child: Center(
        child: Container(
          width: 200,
          height: 400,
          color: Colors.blue,
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('center'));
  });

  testWidgets('Basic Widgets ConstrainedBox', (tester) async {
    await tester.pumpWidget(ExportFrame(
      frameId: 'constrained box',
      exportDelegate: exportDelegate,
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(height: 300),
        child: const Placeholder(),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('constrained box'));
  });

  testWidgets('Basic Widgets FittedBox', (tester) async {
    await tester.pumpWidget(ExportFrame(
      frameId: 'fitted box',
      exportDelegate: exportDelegate,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          for (final fit in BoxFit.values)
            SizedBox(
              height: 80,
              width: 80,
              child: FittedBox(
                fit: fit,
                child: const SizedBox(
                  width: 100,
                  height: 50,
                  child: Placeholder(),
                ),
              ),
            ),
        ],
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('fitted box'));
  });

  testWidgets('Basic Widgets LimitedBox', (tester) async {
    await tester.pumpWidget(ExportFrame(
      frameId: 'limited box',
      exportDelegate: exportDelegate,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: ListView(
          children: const [
            LimitedBox(
              maxHeight: 40,
              child: Placeholder(),
            ),
          ],
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('limited box'));
  });

  testWidgets('Basic Widgets Padding', (tester) async {
    await tester.pumpWidget(ExportFrame(
      frameId: 'padding',
      exportDelegate: exportDelegate,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: 200,
          height: 400,
          color: Colors.blue,
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('padding'));
  });

  testWidgets('Basic Widgets SizedBox', (tester) async {
    await tester.pumpWidget(ExportFrame(
      frameId: 'sized box',
      exportDelegate: exportDelegate,
      child: const SizedBox(
        width: 200,
        height: 100,
        child: Placeholder(),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('sized box'));
  });

  testWidgets('Basic Widgets Transform', (tester) async {
    await tester.pumpWidget(ExportFrame(
      frameId: 'transform',
      exportDelegate: exportDelegate,
      child: Transform.scale(
        scale: 0.5,
        child: Transform.rotate(
          angle: 0.1,
          child: const Placeholder(),
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('transform'));
  });

  testWidgets('Basic Widgets Opacity', (tester) async {
    await tester.pumpWidget(ExportFrame(
      frameId: 'opacity',
      exportDelegate: exportDelegate,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Text('Background', textScaler: TextScaler.linear(5)),
            Opacity(
              opacity: 0.5,
              child: Container(
                height: 100,
                width: 100,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('opacity'));
  });

  testWidgets('Basic Widgets Positioned', (tester) async {
    await tester.pumpWidget(ExportFrame(
      frameId: 'positioned',
      exportDelegate: exportDelegate,
      child: const Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: Text('Top Left', textScaler: TextScaler.linear(3)),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Text('Top Right', textScaler: TextScaler.linear(3)),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Text('Bottom Left', textScaler: TextScaler.linear(3)),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Text('Bottom Right', textScaler: TextScaler.linear(3)),
            ),
          ],
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('positioned'));
  });

  tearDownAll(() async {
    final file = File('./test/output/widgets-basic.pdf');
    file.writeAsBytesSync(await pdf.save());
  });
}
