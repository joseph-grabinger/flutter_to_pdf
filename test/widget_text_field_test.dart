import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';

import 'utils.dart';


late Document pdf;
final ExportDelegate exportDelegate = ExportDelegate();
final ExportOptions overrideOptions = ExportOptions(
  textFieldOptions: TextFieldOptions.uniform(interactive: false),
);

void main() {
  setUpAll(() {
    Document.debug = true;
    pdf = Document();
  });

  testWidgets('TextField Widgets TextField Empty', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: ExportFrame(
          frameId: 'text field empty',
          exportDelegate: exportDelegate,
          child: const TextField(),
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('text field empty'));
    pdf.addPage(await exportDelegate.exportToPdfPage('text field empty',
      overrideOptions: overrideOptions));
  });

  testWidgets('TextField Widgets TextField Value', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: ExportFrame(
          frameId: 'text field value',
          exportDelegate: exportDelegate,
          child: TextField(
            controller: TextEditingController(text: 'Hello World!'),
          ),
        ),
      ),
    ));

    await tester.runAsync(() async {
      pdf.addPage(await exportDelegate.exportToPdfPage('text field value'));
      pdf.addPage(await exportDelegate.exportToPdfPage('text field value'));
    });
  });

  testWidgets('TextField Widgets TextField Style', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: ExportFrame(
          frameId: 'text field style',
          exportDelegate: exportDelegate,
          child: Column(
            children: [
              TextField(
                controller: TextEditingController(text: 'Red, 20, bold'),
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: TextEditingController(text: 'Blue, 25, w600'),
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    ));

    await tester.runAsync(() async {
      pdf.addPage(await exportDelegate.exportToPdfPage('text field style'));
      pdf.addPage(await exportDelegate.exportToPdfPage('text field style'));
    });
  });

  testWidgets('TextField Widgets TextField Decoration', (tester) async {
    FlutterError.onError = ignoreOverflowErrors;

    final radii = <double>[0.0, 5.0, 10.0, 15.0, 20.0, 25.0, 30.0];

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: ExportFrame(
          frameId: 'text field decoration',
          exportDelegate: exportDelegate,
          child: Column(
            children: [
              for (final radius in radii)
                TextField(
                  controller: TextEditingController(text: radius.toString()),
                  decoration: InputDecoration(
                    label: const Text('OutlineInputBorder'), 
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(radius),
                    ),
                  ),
                ),
              for (final radius in radii)
                TextField(
                  controller: TextEditingController(text: radius.toString()),
                  decoration: InputDecoration(
                    label: const Text('UnderlineInputBorder'), 
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(radius),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    ));

    await tester.runAsync(() async {
      pdf.addPage(await exportDelegate.exportToPdfPage('text field decoration'));
      pdf.addPage(await exportDelegate.exportToPdfPage('text field decoration'));
    });
  });

  testWidgets('TextField Widgets TextFormField Empty', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: ExportFrame(
          frameId: 'text form field empty',
          exportDelegate: exportDelegate,
          child: TextFormField(),
        ),
      ),
    ));

    await tester.runAsync(() async {
      pdf.addPage(await exportDelegate.exportToPdfPage('text form field empty'));
      pdf.addPage(await exportDelegate.exportToPdfPage('text form field empty'));
    });
  });

  testWidgets('TextField Widgets TextFormField Value', (tester) async {
    tester.pumpWidget(MaterialApp(
      home: Material(
        child: ExportFrame(
          frameId: 'text form field value',
          exportDelegate: exportDelegate,
          child: TextFormField(
            controller: TextEditingController(text: 'Hello World!'),
          ),
        ),
      ),
    ));

    await tester.runAsync(() async {
      pdf.addPage(await exportDelegate.exportToPdfPage('text form field value'));
      pdf.addPage(await exportDelegate.exportToPdfPage('text form field value'));
    });
  });

  testWidgets('TextField Widgets TextFormField Style', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: ExportFrame(
          frameId: 'text form field style',
          exportDelegate: exportDelegate,
          child: Column(
            children: [
              TextFormField(
                controller: TextEditingController(text: 'Red, 20, bold'),
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: TextEditingController(text: 'Blue, 25, w600'),
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    ));

    await tester.runAsync(() async {
      pdf.addPage(await exportDelegate.exportToPdfPage('text form field style'));
      pdf.addPage(await exportDelegate.exportToPdfPage('text form field style'));
    });
  });

  testWidgets('TextField Widgets TextFormField Decoration', (tester) async {
    FlutterError.onError = ignoreOverflowErrors;

    final radii = <double>[0.0, 5.0, 10.0, 15.0, 20.0, 25.0, 30.0];

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: ExportFrame(
          frameId: 'text form field decoration',
          exportDelegate: exportDelegate,
          child: Column(
            children: [
              for (final radius in radii)
                TextFormField(
                  controller: TextEditingController(text: radius.toString()),
                  decoration: InputDecoration(
                    label: const Text('OutlineInputBorder'), 
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(radius),
                    ),
                  ),
                ),
              for (final radius in radii)
                TextFormField(
                  controller: TextEditingController(text: radius.toString()),
                  decoration: InputDecoration(
                    label: const Text('UnderlineInputBorder'), 
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(radius),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    ));

    await tester.runAsync(() async {
      pdf.addPage(await exportDelegate.exportToPdfPage('text form field decoration'));
      pdf.addPage(await exportDelegate.exportToPdfPage('text form field decoration'));
    });
  });

  tearDownAll(() async {
    final file = File('./test/output/widgets-textfield.pdf');
    file.writeAsBytesSync(await pdf.save());
  });
}
