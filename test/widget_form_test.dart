import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';


late Document pdf;
final ExportDelegate exportDelegate1 = ExportDelegate();
final ExportDelegate exportDelegate2 = ExportDelegate(options: ExportOptions(
  checkboxOptions: CheckboxOptions.uniform(interactive: false),
));


void main() {
  setUpAll(() {
    Document.debug = true;
    pdf = Document();
  });

  testWidgets('Form Widgets Checkbox Basic', (tester) async {
    late BuildContext exportContext;

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: Builder(
          builder: (BuildContext context) {
            exportContext = context;
            return const Row(
              children: <Widget>[
                Checkbox(
                  value: true,
                  onChanged: null,
                ),
                Checkbox(
                  value: false,
                  onChanged: null,
                ),
              ],
            );
          },
        ),
      ),
    ));

    pdf.addPage(await exportDelegate1.exportToPdfPage(exportContext));
    pdf.addPage(await exportDelegate2.exportToPdfPage(exportContext));
  });

  testWidgets('Form Widgets Checkbox Decoration', (tester) async {
    late BuildContext exportContext;

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: Builder(
          builder: (BuildContext context) {
            exportContext = context;
            return const Row(
              children: <Widget>[
                Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  activeColor: Colors.purple,
                  checkColor: Colors.green,
                  value: true,
                  onChanged: null,
                ),
                Checkbox(
                  shape: CircleBorder(
                    side: BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                  activeColor: Colors.purple,
                  checkColor: Colors.green,
                  value: false,
                  onChanged: null,
                ),
              ],
            );
          },
        ),
      ),
    ));

    pdf.addPage(await exportDelegate1.exportToPdfPage(exportContext));
    pdf.addPage(await exportDelegate2.exportToPdfPage(exportContext));
  });

  testWidgets('Form Widgets Button Basic', (tester) async {
    late BuildContext exportContext;

    await tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return const Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton(
                onPressed: null,
                child: Text('TextButton'),
              ),
              ElevatedButton(
                onPressed: null,
                child: Text('ElevatedButton'),
              ),
              OutlinedButton(
                onPressed: null,
                child: Text('OutlinedButton'),
              ),
              FilledButton(
                onPressed: null,
                child: Text('FilledButton'),
                ),
            ],
          ),
        );
      },
    ));

    pdf.addPage(await exportDelegate1.exportToPdfPage(exportContext));
  });

  testWidgets('Form Widgets Button Style', (tester) async {
    late BuildContext exportContext;

    await tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple),
                  foregroundColor: MaterialStateProperty.all(Colors.green),
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                ),
                onPressed: null,
                child: const Text('TextButton'),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple),
                  foregroundColor: MaterialStateProperty.all(Colors.green),
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                ),
                onPressed: null,
                child: const Text('ElevatedButton'),
              ),
              OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple),
                  foregroundColor: MaterialStateProperty.all(Colors.green),
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                ),
                onPressed: null,
                child: const Text('OutlinedButton'),
              ),
              FilledButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple),
                  foregroundColor: MaterialStateProperty.all(Colors.green),
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                ),
                onPressed: null,
                child: const Text('FilledButton'),
                ),
            ],
          ),
        );
      },
    ));

    pdf.addPage(await exportDelegate1.exportToPdfPage(exportContext));
  });

  tearDownAll(() async {
    final file = File('./test/output/widgets-form.pdf');
    file.writeAsBytesSync(await pdf.save());
  });
}
