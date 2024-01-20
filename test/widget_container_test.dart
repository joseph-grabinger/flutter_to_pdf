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

  testWidgets('Container Widget Flat', (tester) async {
    await tester.pumpWidget(ExportFrame(
      frameId: 'flat',
      exportDelegate: exportDelegate,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(30),
        padding: const EdgeInsets.all(20),
        color: Colors.blue,
        width: 200,
        height: 400,
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('flat'));
  });

  testWidgets('Container Widget BoxShape Border', (tester) async {
    await tester.pumpWidget(ExportFrame(
      frameId: 'box shape border',
      exportDelegate: exportDelegate,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.red,
                  width: 3,
                ),
              ),
            ),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.red,
                  width: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('box shape border'));
  });

  testWidgets('Container Widget Image', (tester) async {
    final image = MemoryImage(getImageBytes());

    final widgets = <Widget>[];
    for (final shape in BoxShape.values) {
      for (final fit in BoxFit.values) {
        widgets.add(Container(
          width: 100,
          height: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              shape: shape,
              image: DecorationImage(
                image: image,
              )),
          child: Container(
            width: 70,
            color: Colors.yellow,
            child: Text(
              '$fit\n$shape',
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
              textScaler: const TextScaler.linear(0.6),
            ),
          ),
        ));
      }
    }

    await tester.pumpWidget(ExportFrame(
      frameId: 'image',
      exportDelegate: exportDelegate,
      child: Wrap(
        textDirection: TextDirection.ltr,
        children: widgets,
      ),
    ));

    await tester.runAsync(() async {
      pdf.addPage(await exportDelegate.exportToPdfPage('image'));
    });
  });

  testWidgets('Container Widget LinearGradient', (tester) async {
    await tester.pumpWidget(ExportFrame(
      frameId: 'linear gradient',
      exportDelegate: exportDelegate,
      child: Container(
        width: 200,
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.red,
            width: 3,
          ),
          gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: <double>[0, 0.8, 1.0],
            tileMode: TileMode.clamp,
            colors: [
              Colors.blue,
              Colors.red,
              Colors.yellow,
            ],
          ),
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('linear gradient'));
  });

  testWidgets('Container Widget RadialGradient', (tester) async {
    await tester.pumpWidget(ExportFrame(
      frameId: 'radial gradient',
      exportDelegate: exportDelegate,
      child: Container(
        width: 200,
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.red,
            width: 3,
          ),
          gradient: const RadialGradient(
            stops: <double>[0.0, 0.2, 1.0],
            center: FractionalOffset(0.7, 0.2),
            focal: FractionalOffset(0.7, 0.45),
            focalRadius: 1,
            colors: [
              Colors.blue,
              Colors.red,
              Colors.yellow,
            ],
          ),
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('radial gradient'));
  });

  testWidgets('Container Widget BoxShadow Rectangle', (tester) async {
    await tester.pumpWidget(ExportFrame(
      frameId: 'box shadow rectangle',
      exportDelegate: exportDelegate,
      child: Container(
        width: 200,
        height: 400,
        margin: const EdgeInsets.all(30),
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.blue,
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 4,
              spreadRadius: 10,
              offset: Offset(2, 2),
            ),
          ],
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('box shadow rectangle'));
  });

  testWidgets('Container Widget BoxShadow Ellipse', (tester) async {
    await tester.pumpWidget(ExportFrame(
      frameId: 'box shadow ellipse',
      exportDelegate: exportDelegate,
      child: Container(
        width: 200,
        height: 400,
        margin: const EdgeInsets.all(30),
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 4,
              spreadRadius: 10,
              offset: Offset(2, 2),
            ),
          ],
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('box shadow ellipse'));
  });

  tearDownAll(() async {
    final file = File('./test/output/widgets-container.pdf');
    file.writeAsBytesSync(await pdf.save());
  });
}
