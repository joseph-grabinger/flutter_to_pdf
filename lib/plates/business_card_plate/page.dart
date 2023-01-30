import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rfw/formats.dart';
import 'package:rfw/rfw.dart';
import 'package:share_plus/share_plus.dart';
import 'package:teaplates/rfw/create_widgets.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:teaplates/rfw/models/dynamic_data.dart';

const businessCardRoute = '/businessCard';
class BusinessCardPage extends StatefulWidget {
  const BusinessCardPage ({Key? key}) : super(key: key);

  @override
  State<BusinessCardPage> createState() => _BusinessCardState();
}

class _BusinessCardState extends State<BusinessCardPage> {
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
  Widget build(BuildContext context) {
    return Scaffold(
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
  }

  void createPdf() async {
    final BuildContext context = state['context'] as BuildContext;
    final DataSource source = state['source'] as DataSource;

    final pdf = pw.Document();

    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context _context) {
        return rfwToPdf(((source as RFWWidgetState).widget.curriedWidget as CurriedLocalWidget), dyDa)!;
      })); // Page

    final output = await getApplicationDocumentsDirectory();
    final file = File("${output.path}/example.pdf");
    await file.writeAsBytes(await pdf.save());

    //Share.shareXFiles([XFile(file.path)],);
  }
}