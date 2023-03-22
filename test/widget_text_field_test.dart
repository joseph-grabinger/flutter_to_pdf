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
          child: const TextField(
            key: Key('text field empty'),
          ),
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
            key: const Key('text field value'),
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
                key: const Key('text field red'),
                controller: TextEditingController(text: 'Red, 20, bold'),
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                key: const Key('text field blue'),
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
                  key: Key('text field outline $radius'),
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
                  key: Key('text field underline $radius'),
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
          child: TextFormField(
            key: const Key('text form field empty'),
          ),
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
            key: const Key('text form field value'),
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
                key: const Key('text form field red'),
                controller: TextEditingController(text: 'Red, 20, bold'),
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                key: const Key('text form field blue'),
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
                  key: Key('text form field outline $radius'),
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
                  key: Key('text form field underline $radius'),
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
