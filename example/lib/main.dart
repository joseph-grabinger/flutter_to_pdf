import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:rfw/rfw.dart';
import 'package:rfw/formats.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:example/dynamic_data.dart';
import 'package:example/rfw/create_widgets.dart';


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
  final FullyQualifiedWidgetName _fullyWidget = const FullyQualifiedWidgetName(LibraryName(<String>['main']), 'root');
  final DynamicData dyDa = DynamicData(data: {
    'firstname': 'John',
  });

  final edits = <String, TextEditingController>{};

  dynamic state = {};
  
  @override
  void initState() {
    super.initState();
    _update();
  }

  @override
  void reassemble() {
    super.reassemble();
    _update();
  }


  void _update() async {
    _runtime.update(const LibraryName(<String>['widgets']), createWidgets(state));
    final rfwFile = await rootBundle.loadString('assets/rfw/business_card.rfw');
    _runtime.update(const LibraryName(<String>['main']), parseLibraryFile(rfwFile));

    dyDa.update('firstname', "Nick3");
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(widget.toStringShort()),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => createPdf(),
      child: const Icon(Icons.save),
    ),
    body: RemoteWidget(
      runtime: _runtime,
      data: dyDa.content,
      widget: _fullyWidget,
      onEvent: (String name, DynamicMap arguments) {
        debugPrint('user triggered event "$name" with data: $arguments');
      },
    ),
  );

  void createPdf() async {
    final DataSource source = state['source'] as DataSource;

    final pdf = pw.Document();

    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context ctx) => rfwToPdf(source, dyDa)!),
    ); // Page

    final output = await getApplicationDocumentsDirectory();
    final file = File("${output.path}/example.pdf");
    await file.writeAsBytes(await pdf.save());

    //Share.shareXFiles([XFile(file.path)],);
  }
}
