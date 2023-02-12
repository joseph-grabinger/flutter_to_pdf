library teaplates;

import 'package:flutter/material.dart';

import 'package:pdf/widgets.dart' as pw;

import 'widgets/container.dart';
import 'widgets/center.dart';
import 'widgets/sized_box.dart';
import 'widgets/align.dart';
import 'widgets/padding.dart';
import 'widgets/positioned.dart';
import 'widgets/expanded.dart';
import 'widgets/flexible.dart';
import 'widgets/text.dart';
import 'widgets/divider.dart';
import 'widgets/column.dart';
import 'widgets/row.dart';
import 'widgets/stack.dart';
import 'widgets/list_view.dart';
import 'widgets/grid_view.dart';


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
  context.visitChildElements((Element element) async {
    print('Initial: $element');
    pdfWidget = visit(element, context).first;
  });
  
  return pdfWidget;
}

  /// Recursive helper to visit all child elements of the provided [element].
  List<pw.Widget> visit(Element element, BuildContext context) {
    List<pw.Widget> children = [];

    element.visitChildElements((Element element) async {
      print('Element ${element.depth}: ${element.widget}');

      final Widget widget = element.widget;

      switch (widget.runtimeType) {
        case MergeSemantics: //anchor: end of widget tree
          print('Reached Anchor');
          return;
        case Container:
          final List childWidgets = visit(element, context);
          children.add(await (widget as Container).toPdfWidget(
            childWidgets.isNotEmpty ? childWidgets.first : null,
            context));
          break;
        case Center:
          final List childWidgets = visit(element, context);
          children.add((widget as Center).toPdfWidget(
            childWidgets.isNotEmpty ? childWidgets.first : null
          ));
          break;
        case SizedBox:
          final List childWidgets = visit(element, context);
          children.add((widget as SizedBox).toPdfWidget(
            childWidgets.isNotEmpty ? childWidgets.first : null
          ));
          break;
        case Padding:
          final List childWidgets = visit(element, context);
          children.add((widget as Padding).toPdfWidget(
            childWidgets.isNotEmpty ? childWidgets.first : null
          ));
          break;
        case Align:
          final List childWidgets = visit(element, context);
          children.add((widget as Align).toPdfWidget(
            childWidgets.isNotEmpty ? childWidgets.first : null
          ));
          break;
        case Positioned:
          children.add((widget as Positioned).toPdfWidget(visit(element, context).first));
          break;
        case Expanded:
          children.add((widget as Expanded).toPdfWidget(visit(element, context).first));
          break;
        case Flexible:
          children.add((widget as Flexible).toPdfWidget(visit(element, context).first));
          break;
        case Text:
          children.add((widget as Text).toPdfWidget());
          break;
        case Divider:
          children.add((widget as Divider).toPdfWidget());
          break;
        case Column:
          children.add((widget as Column).toPdfWidget(visit(element, context)));
          break;
        case Row:
          children.add((widget as Row).toPdfWidget(visit(element, context)));
          break;
        case Stack:
          children.add((widget as Stack).toPdfWidget(visit(element, context)));
          break;
        case ListView:
          children.add((widget as ListView).toPdfWidget(visit(element, context)));
          break;
        case GridView:
          children.add((widget as GridView).toPdfWidget(visit(element, context)));
          break;
        default:
          print('Uncaught: ${widget.runtimeType}');
          final List childWidgets = visit(element, context);
          if (childWidgets.isNotEmpty) {
            children.addAll(childWidgets.map((e) => e));
          }
          break;
      }
    });

    print('returned: $children');

    return children;
  }
