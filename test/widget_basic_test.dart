import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';


late Document pdf;

void main() {
  setUpAll(() {
    Document.debug = true;
    pdf = Document();
  });

  testWidgets('Basic Widgets Align 1', (tester) async {
    late BuildContext exportContext;

    tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return Align(
          alignment: Alignment.bottomRight,
          child: Container(
            width: 200,
            height: 400,
            color: Colors.blue,
          ),
        );
      },
    ));

    pdf.addPage(await exportToPdfPage(exportContext));
  });

  testWidgets('Basic Widgets Align 2', (tester) async {
    late BuildContext exportContext;

    tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return Align(
          alignment: const Alignment(0.8, 0.2),
          child: Container(
            width: 200,
            height: 400,
            color: Colors.blue,
          ),
        );
      },
    ));

    pdf.addPage(await exportToPdfPage(exportContext));
  });

  testWidgets('Basic Widgets AspectRatio', (tester) async {
    late BuildContext exportContext;

    tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return const AspectRatio(
          aspectRatio: 1.618,
          child: Placeholder(),
        );
      },
    ));

    pdf.addPage(await exportToPdfPage(exportContext));
  });

  testWidgets('Basic Widgets Center', (tester) async {
    late BuildContext exportContext;

    tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return Center(
          child: Container(
            width: 200,
            height: 400,
            color: Colors.blue,
          ),
        );
      },
    ));

    pdf.addPage(await exportToPdfPage(exportContext));
  });

  testWidgets('Basic Widgets ConstrainedBox', (tester) async {
    late BuildContext exportContext;

    tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return ConstrainedBox(
          constraints: const BoxConstraints.tightFor(height: 300),
          child: const Placeholder(),
        );
      },
    ));

    pdf.addPage(await exportToPdfPage(exportContext));
  });

  testWidgets('Basic Widgets FittedBox', (tester) async {
    late BuildContext exportContext;

    tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            for (final fit in BoxFit.values) SizedBox(
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
        );
      },
    ));

    pdf.addPage(await exportToPdfPage(exportContext));
  });

  testWidgets('Basic Widgets LimitedBox', (tester) async {
    late BuildContext exportContext;

    tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return Directionality(
          textDirection: TextDirection.ltr,
          child: ListView(
            children: const [
              LimitedBox(
                maxHeight: 40,
                child: Placeholder(),
              ),
            ],
          ),
        );
      },
    ));

    pdf.addPage(await exportToPdfPage(exportContext));
  });

  testWidgets('Basic Widgets Padding', (tester) async {
    late BuildContext exportContext;

    tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: 200,
            height: 400,
            color: Colors.blue,
          ),
        );
      },
    ));

    pdf.addPage(await exportToPdfPage(exportContext));
  });

  testWidgets('Basic Widgets SizedBox', (tester) async {
    late BuildContext exportContext;

    tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return const SizedBox(
          width: 200,
          height: 100,
          child: Placeholder(),
        );
      },
    ));

    pdf.addPage(await exportToPdfPage(exportContext));
  });

  testWidgets('Basic Widgets Transform', (tester) async {
    late BuildContext exportContext;

    tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return Transform.scale(
          scale: 0.5,
          child: Transform.rotate(
            angle: 0.1,
            child: const Placeholder(),
          ),
        );
      },
    ));

    pdf.addPage(await exportToPdfPage(exportContext));
  });

  testWidgets('Basic Widgets Opacity', (tester) async {
    late BuildContext exportContext;

    tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return  Directionality(
          textDirection: TextDirection.ltr,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Text('Background', textScaleFactor: 5),
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
        );
      },
    ));

    pdf.addPage(await exportToPdfPage(exportContext));
  });

  testWidgets('Basic Widgets Positioned', (tester) async {
    late BuildContext exportContext;

    tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return  const Directionality(
          textDirection: TextDirection.ltr,
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 10,
                  child: Text('Top Left', textScaleFactor: 3),
              ),
              Positioned(
                top: 10,
                right: 10,
                  child: Text('Top Right', textScaleFactor: 3),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                  child: Text('Bottom Left', textScaleFactor: 3),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                  child: Text('Bottom Right', textScaleFactor: 3),
              ),
            ],
          ),
        );
      },
    ));

    pdf.addPage(await exportToPdfPage(exportContext));
  });

  tearDownAll(() async {
    final file = File('./test/output/widgets-basic.pdf');
    file.writeAsBytesSync(await pdf.save());
  });
}
