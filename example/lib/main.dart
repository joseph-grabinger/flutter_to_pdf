import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';

import 'examples/document_example.dart';
import 'examples/image_example.dart';
import 'examples/table_example.dart';
import 'examples/button_example.dart';


void main() => runApp(const Demo());

class Demo extends StatelessWidget {
  const Demo({super.key});

  static final Map<String, Widget> examples = {
    'Document Example': const DocumentExample(),
    'Image Example': imageExample,
    'Table Example': tableExample,
    'Button Example': buttonExample,
    'Responsize Layout Example': const DocumentExample(),
  };

  @override
  Widget build(BuildContext context) => MaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Flutter to PDF - Demo'),
      ),
      body: ListView.builder(
        itemCount: examples.length,
        itemBuilder: (BuildContext context, int index) {
          final MapEntry<String, Widget> example = examples.entries.toList()[index];
          return ListTile(
            title: Text(example.key),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => ExamplePage(
                title: example.key,
                example: example.value,
              )),
            ),
          );
        },
      ),
    ),
  );
}

class ExamplePage extends StatefulWidget {
  final String title;
  final Widget example;

  const ExamplePage({
    required this.title, 
    required this.example, 
    super.key,
  });

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  final ExportDelegate exportDelegate = ExportDelegate();

  Future<void> saveFile(Document doc, String name) async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final File file = File('${dir.path}/$name.pdf');

    await file.writeAsBytes(await doc.save());
    debugPrint('Saved exported PDF at: ${file.path}');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(widget.title),
    ),
    bottomSheet: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () async {
            final ExportOptions overrideOptions = ExportOptions(
              textFieldOptions: TextFieldOptions.uniform(
                interactive: false, 
              ),
              checkboxOptions: CheckboxOptions.uniform(
                interactive: false,
              ),
            );
            final Document pdf = await exportDelegate.exportToPdfDocument('test',
              overrideOptions: overrideOptions);
            saveFile(pdf, 'static-example');
          },
          child: const Row(
            children: [
              Text('Export as static'),
              Icon(Icons.save_alt_outlined),
            ],
          ),
        ),
        TextButton(
          onPressed: () async {
            final Document pdf = await exportDelegate.exportToPdfDocument('test');
            saveFile(pdf, 'interactive-example');
          },
          child: const Row(
            children: [
              Text('Export as interactive'),
              Icon(Icons.save_alt_outlined),
            ],
          ),
        ),
      ],
    ),
    body: ExportFrame(
      frameId: 'test',
      exportDelegate: exportDelegate,
      child: widget.example
    ),
  );
}
