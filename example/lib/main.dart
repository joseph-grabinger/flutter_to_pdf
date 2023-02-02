import 'dart:io';

import 'package:flutter/material.dart';

import 'package:rfw/rfw.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Teaplate Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
      ),
      useMaterial3: true,
    ),
    home: const MyHomePage(),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Runtime _runtime = Runtime();
  final FullyQualifiedWidgetName _fullyWidget = const FullyQualifiedWidgetName(
    LibraryName(<String>['main']), 'root',
  );
  final DynamicContent content = DynamicContent();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(widget.toStringShort()),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => null, //createPdf(),
      child: const Icon(Icons.save),
    ),
    body: RemoteWidget(
      runtime: _runtime,
      data: content,
      widget: _fullyWidget,
      onEvent: (String name, DynamicMap arguments) {
        debugPrint('user triggered event "$name" with data: $arguments');
      },
    ),
  );

  // void createPdf() async {
  //   // final BuildContext context = state['context'] as BuildContext;
  //   final DataSource source = state['source'] as DataSource;

  //   final pdf = pw.Document();

  //   pdf.addPage(pw.Page(
  //     pageFormat: PdfPageFormat.a4,
  //     build: (pw.Context _context) {
  //       return rfwToPdf(((source as RFWWidgetState).widget.curriedWidget as CurriedLocalWidget), dyDa)!;
  //     })); // Page

  //   final output = await getApplicationDocumentsDirectory();
  //   final file = File("${output.path}/example.pdf");
  //   await file.writeAsBytes(await pdf.save());

  //   //Share.shareXFiles([XFile(file.path)],);
  // }
}
