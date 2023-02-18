library teaplates;

import 'package:flutter/material.dart';

import 'package:pdf/widgets.dart' as pw;

import 'options/text_field_options.dart';

import 'widgets/container.dart';
import 'widgets/center.dart';
import 'widgets/sized_box.dart';
import 'widgets/align.dart';
import 'widgets/padding.dart';
import 'widgets/positioned.dart';
import 'widgets/expanded.dart';
import 'widgets/flexible.dart';
import 'widgets/text.dart';
import 'widgets/text_field.dart';
import 'widgets/divider.dart';
import 'widgets/image.dart';
import 'widgets/column.dart';
import 'widgets/row.dart';
import 'widgets/stack.dart';
import 'widgets/list_view.dart';
import 'widgets/grid_view.dart';


/// Exports the provided [context] to a PDF file.
Future<pw.Document> exportPDF(BuildContext context, {
  TextFieldOptions textFieldOptions = const TextFieldOptions.none(),
}) async {
  final pw.Widget? pdfWidget = await traverseWidgetTree(context, textFieldOptions);

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
Future<pw.Widget?> traverseWidgetTree(BuildContext context, TextFieldOptions options) async {
  pw.Widget? pdfWidget;
  Element? element;
  context.visitChildElements((Element e) async {
    print('Initial: $e');
    element = e;
  });

  pdfWidget = (await visit(element!, options)).first;

  return pdfWidget;
}

  /// Recursive helper to visit all child elements of the provided [element].
  Future<List<pw.Widget>> visit(Element element, TextFieldOptions options) async {
    List<pw.Widget> children = [];
    List<Element> elements = [];

    element.visitChildElements((Element element) async {
      print('Element ${element.depth}: ${element.widget}');
      elements.add(element);
    });

    for (Element e in elements) {
      final Widget widget = e.widget;

      switch (widget.runtimeType) {
        case MergeSemantics: //anchor: end of widget tree
          print('Reached Anchor');
          return [];
        case Container:
          final List childWidgets = await visit(e, options);
          children.add(await (widget as Container).toPdfWidget(
            childWidgets.isNotEmpty ? childWidgets.first : null
          ));
          break;
        case Center:
          final List childWidgets = await visit(e, options);
          children.add((widget as Center).toPdfWidget(
            childWidgets.isNotEmpty ? childWidgets.first : null
          ));
          break;
        case SizedBox:
          final List childWidgets = await visit(e, options);
          children.add((widget as SizedBox).toPdfWidget(
            childWidgets.isNotEmpty ? childWidgets.first : null
          ));
          break;
        case Padding:
          final List childWidgets = await visit(e, options);
          children.add((widget as Padding).toPdfWidget(
            childWidgets.isNotEmpty ? childWidgets.first : null
          ));
          break;
        case Align:
          final List childWidgets = await visit(e, options);
          children.add((widget as Align).toPdfWidget(
            childWidgets.isNotEmpty ? childWidgets.first : null
          ));
          break;
        case Positioned:
          children.add((widget as Positioned).toPdfWidget((await visit(e, options)).first));
          break;
        case Expanded:
          children.add((widget as Expanded).toPdfWidget((await visit(e, options)).first));
          break;
        case Flexible:
          children.add((widget as Flexible).toPdfWidget((await visit(e, options)).first));
          break;
        case Text:
          children.add((widget as Text).toPdfWidget());
          break;
        case TextField:
          children.add((widget as TextField).toPdfWidget(options));
          break;
        case Divider:
          children.add((widget as Divider).toPdfWidget());
          break;
        case Image:
          children.add(await (widget as Image).toPdfWidget());
          break;
        case Column:
          children.add((widget as Column).toPdfWidget(await visit(e, options)));
          break;
        case Row:
          children.add((widget as Row).toPdfWidget(await visit(e, options)));
          break;
        case Stack:
          children.add((widget as Stack).toPdfWidget(await visit(e, options)));
          break;
        case ListView:
          children.add((widget as ListView).toPdfWidget(await visit(e, options)));
          break;
        case GridView:
          children.add((widget as GridView).toPdfWidget(await visit(e, options)));
          break;
        default:
          print('Uncaught: ${widget.runtimeType}');
          final List childWidgets = await visit(e, options);
          if (childWidgets.isNotEmpty) {
            children.addAll(childWidgets.map((x) => x));
          }
          break;
      }
    }

    print('returned: $children');

    return children;
  }
