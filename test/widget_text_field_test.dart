import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';

import 'utils.dart';


late Document pdf;

void main() {
  setUpAll(() {
    Document.debug = true;
    pdf = Document();
  });

  testWidgets('TextField Widgets TextField Empty', (tester) async {
    late BuildContext exportContext;

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: Builder(
          builder: (BuildContext context) {
            exportContext = context;
            return const TextField();
          },
        ),
      ),
    ));

    pdf.addPage(await exportToPdfPage(exportContext));
    pdf.addPage(await exportToPdfPage(exportContext, options: ExportOptions(
      textFieldOptions: TextFieldOptions.uniform(interactive: false),
    )));
  });

  testWidgets('TextField Widgets TextField Value', (tester) async {
    late BuildContext exportContext;

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: Builder(
          builder: (BuildContext context) {
            exportContext = context;
            return TextField(
              controller: TextEditingController(text: 'Hello World!'),
            );
          },
        ),
      ),
    ));

    pdf.addPage(await exportToPdfPage(exportContext));
    pdf.addPage(await exportToPdfPage(exportContext, options: ExportOptions(
      textFieldOptions: TextFieldOptions.uniform(interactive: false),
    )));
  });

  testWidgets('TextField Widgets TextField Style', (tester) async {
    late BuildContext exportContext;

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: Builder(
          builder: (BuildContext context) {
            exportContext = context;
            return Column(
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
            );
          },
        ),
      ),
    ));

    pdf.addPage(await exportToPdfPage(exportContext));
    pdf.addPage(await exportToPdfPage(exportContext, options: ExportOptions(
      textFieldOptions: TextFieldOptions.uniform(interactive: false),
    )));
  });

  testWidgets('TextField Widgets TextField Decoration', (tester) async {
    FlutterError.onError = ignoreOverflowErrors;

    late BuildContext exportContext;

    final radii = <double>[0.0, 5.0, 10.0, 15.0, 20.0, 25.0, 30.0];

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: Builder(
          builder: (BuildContext context) {
            exportContext = context;
            return Column(
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
            );
          },
        ),
      ),
    ));

    pdf.addPage(await exportToPdfPage(exportContext));
    pdf.addPage(await exportToPdfPage(exportContext, options: ExportOptions(
      textFieldOptions: TextFieldOptions.uniform(interactive: false),
    )));
  });

  testWidgets('TextField Widgets TextFormField Empty', (tester) async {
    late BuildContext exportContext;

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: Builder(
          builder: (BuildContext context) {
            exportContext = context;
            return TextFormField();
          },
        ),
      ),
    ));

    pdf.addPage(await exportToPdfPage(exportContext));
    pdf.addPage(await exportToPdfPage(exportContext, options: ExportOptions(
      textFieldOptions: TextFieldOptions.uniform(interactive: false),
    )));
  });

  testWidgets('TextField Widgets TextFormField Value', (tester) async {
    late BuildContext exportContext;

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: Builder(
          builder: (BuildContext context) {
            exportContext = context;
            return TextFormField(
              controller: TextEditingController(text: 'Hello World!'),
            );
          },
        ),
      ),
    ));

    pdf.addPage(await exportToPdfPage(exportContext));
    pdf.addPage(await exportToPdfPage(exportContext, options: ExportOptions(
      textFieldOptions: TextFieldOptions.uniform(interactive: false),
    )));
  });

  testWidgets('TextField Widgets TextFormField Style', (tester) async {
    late BuildContext exportContext;

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: Builder(
          builder: (BuildContext context) {
            exportContext = context;
            return Column(
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
            );
          },
        ),
      ),
    ));

    pdf.addPage(await exportToPdfPage(exportContext));
    pdf.addPage(await exportToPdfPage(exportContext, options: ExportOptions(
      textFieldOptions: TextFieldOptions.uniform(interactive: false),
    )));
  });

  testWidgets('TextField Widgets TextFormField Decoration', (tester) async {
    FlutterError.onError = ignoreOverflowErrors;

    late BuildContext exportContext;

    final radii = <double>[0.0, 5.0, 10.0, 15.0, 20.0, 25.0, 30.0];

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: Builder(
          builder: (BuildContext context) {
            exportContext = context;
            return Column(
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
            );
          },
        ),
      ),
    ));

    pdf.addPage(await exportToPdfPage(exportContext));
    pdf.addPage(await exportToPdfPage(exportContext, options: ExportOptions(
      textFieldOptions: TextFieldOptions.uniform(interactive: false),
    )));
  });

  tearDownAll(() async {
    final file = File('./test/output/widgets-textfield.pdf');
    file.writeAsBytesSync(await pdf.save());
  });
}
