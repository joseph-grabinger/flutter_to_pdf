library teaplates;

import 'dart:io';

import 'package:flutter/widgets.dart';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

import 'widgets/container.dart';
import 'widgets/text.dart';


/// Exports the provided [context] to a PDF file.
Future<void> exportPDF(BuildContext context) async {
  final pw.Widget? pdfWidget = visitAll(context);

  final pdf = pw.Document();

  pdf.addPage(pw.Page(
    build: (pw.Context context) {
      return pdfWidget!;
    },
  ));
  Directory dir = await getApplicationDocumentsDirectory();
  final file = File("${dir.path}/example.pdf");
  await file.writeAsBytes(await pdf.save());
  print('Path: ${file.path}');
}

/// Visists all widgets in the widget tree.
pw.Widget? visitAll(BuildContext context) {
  pw.Widget? pdfWidget;
  context.visitChildElements((Element element) {
    print('Initial: $element');
    pdfWidget = visit(element).first;
  });
  
  return pdfWidget;
}

  /// Recursive helper function to visit all widgets in the widget tree.
  List<pw.Widget> visit(Element element) {
    List<pw.Widget> children = [];

    element.visitChildElements((Element element) {
      print('Element ${element.depth}: ${element.widget}');

      Widget widget = element.widget;

      switch (widget.runtimeType) {
        case MergeSemantics: //anchor: end of widget tree
          print('Reached Anchor');
          return;
        case Center:
          print('Adding Center');
          children.add(pw.Center(child: visit(element).first));
          break;
        case Container:
          print('Adding Container');
          children.add((widget as Container).toPDFWidget(visit(element).first));
          // children.add(pw.Container(child: visit(element).first));
          break;
        case Text:
          print('Adding Text');
          children.add((widget as Text).toPDFWidget());
          break;
        case Column:
          print('Adding Column');
          children.add(pw.Column(children: visit(element)));
          break;
        default: 
          print('Uncaught: ${widget.runtimeType}');
          children.add(visit(element).first);
          break;
      }
    });

    print('returned: $children');

    return children;
  }


