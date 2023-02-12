library teaplates;

import 'package:flutter/material.dart';

import 'package:pdf/widgets.dart' as pw;

import 'widgets/container.dart';
import 'widgets/center.dart';
import 'widgets/sized_box.dart';
import 'widgets/align.dart';
import 'widgets/padding.dart';
import 'widgets/expanded.dart';
import 'widgets/flexible.dart';
import 'widgets/text.dart';
import 'widgets/divider.dart';
import 'widgets/column.dart';
import 'widgets/row.dart';
import 'widgets/stack.dart';


/// Exports the provided [context] to a PDF file.
Future<pw.Document> exportPDF(BuildContext context) async {
  final pw.Widget? pdfWidget = traverseWidgetTree(context);

  final pdf = pw.Document();

  pdf.addPage(pw.Page(
    build: (pw.Context context) {
      return pdfWidget!;
    },
  ));

  return pdf;
}

/// Traverses the widget tree of the provided [context]
/// and returns the corresponding PDF widget tree.
pw.Widget? traverseWidgetTree(BuildContext context) {
  pw.Widget? pdfWidget;
  context.visitChildElements((Element element) {
    print('Initial: $element');
    pdfWidget = visit(element).first;
  });
  
  return pdfWidget;
}

  /// Recursive helper to visit all child elements of the provided [element].
  List<pw.Widget> visit(Element element) {
    List<pw.Widget> children = [];

    element.visitChildElements((Element element) {
      print('Element ${element.depth}: ${element.widget}');

      Widget widget = element.widget;

      switch (widget.runtimeType) {
        case MergeSemantics: //anchor: end of widget tree
          print('Reached Anchor');
          return;
        case Container:
          print('Adding Container');
          children.add((widget as Container).toPdfWidget(visit(element).first));
          break;
        case Center:
          print('Adding Center');
          children.add((widget as Center).toPdfWidget(visit(element).first));
          break;
        case SizedBox:
          print('Adding SizedBox');
          children.add((widget as SizedBox).toPdfWidget(visit(element).first));
          break;
        case Padding:
          print('Adding Padding');
          children.add((widget as Padding).toPdfWidget(visit(element).first));
          break;
        case Align:
          print('Adding Align');
          children.add((widget as Align).toPdfWidget(visit(element).first));
          break;
        case Expanded:
          print('Adding Expanded');
          children.add((widget as Expanded).toPdfWidget(visit(element).first));
          break;
        case Flexible:
          print('Adding Flexible');
          children.add((widget as Flexible).toPdfWidget(visit(element).first));
          break;
        case Text:
          print('Adding Text');
          children.add((widget as Text).toPdfWidget());
          break;
        case Divider:
          print('Adding Divider');
          children.add((widget as Divider).toPdfWidget());
          break;
        case Column:
          print('Adding Column');
          children.add((widget as Column).toPdfWidget(visit(element)));
          break;
        case Row:
          print('Adding Row');
          children.add((widget as Row).toPdfWidget(visit(element)));
          break;
        case Stack:
          print('Adding Stack');
          children.add((widget as Stack).toPdfWidget(visit(element)));
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
