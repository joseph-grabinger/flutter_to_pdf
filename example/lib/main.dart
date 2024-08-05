import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';

void main() => runApp(const Demo());

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  final ExportDelegate exportDelegate = ExportDelegate();

  Future<void> saveFile(document, String name) async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final File file = File('${dir.path}/$name.pdf');

    await file.writeAsBytes(await document.save());
    debugPrint('Saved exported PDF at: ${file.path}');
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          tabBarTheme: const TabBarTheme(
            labelColor: Colors.black87,
          ),
        ),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: const Text('Flutter to PDF - Demo'),
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
                  final pdf = await exportDelegate.exportToPdfDocument(
                      'Demo',
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
                  final pdf = await exportDelegate
                      .exportToPdfDocument('Demo');
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
            frameId: 'Demo',
            exportDelegate: exportDelegate,
            child: const Body(),
          ),
        ),
      );
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return CaptureWrapper(
        key: const Key('CaptureWraperKey'),
        child: Text("Hello World", key: globalKey),
    );
  }
}
