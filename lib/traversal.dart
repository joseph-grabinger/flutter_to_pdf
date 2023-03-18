import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:pdf/widgets.dart' as pw;

import 'options/export_options.dart';
import 'widgets/container.dart';
import 'widgets/center.dart';
import 'widgets/sized_box.dart';
import 'widgets/fitted_box.dart';
import 'widgets/limited_box.dart';
import 'widgets/constrained_box.dart';
import 'widgets/clip.dart';
import 'widgets/transform.dart';
import 'widgets/opacity.dart';
import 'widgets/padding.dart';
import 'widgets/align.dart';
import 'widgets/positioned.dart';
import 'widgets/expanded.dart';
import 'widgets/flexible.dart';
import 'widgets/placeholder.dart';
import 'widgets/text.dart';
import 'widgets/text_field.dart';
import 'widgets/divider.dart';
import 'widgets/image.dart';
import 'widgets/checkbox.dart';
import 'widgets/button.dart';
import 'widgets/column.dart';
import 'widgets/row.dart';
import 'widgets/stack.dart';
import 'widgets/list_view.dart';
import 'widgets/grid_view.dart';
import 'widgets/wrap.dart';
import 'widgets/table.dart';


class ExportDelegate {
  final ExportOptions options;

  const ExportDelegate({this.options = const ExportOptions()});

  /// Exports the provided [context] to a PDF [pw.Document].
  Future<pw.Document> exportToPDF(BuildContext context) async {
    final pw.Widget? pdfWidget = await _traverseWidgetTree(context);

    final pw.Document pdf = pw.Document();

    pdf.addPage(pw.Page(
      pageFormat: options.pageFormatOptions.getPageFormat(),
      clip: options.pageFormatOptions.clip,
      build: (pw.Context context) => pdfWidget!,
    ));

    return pdf;
  }

  /// Exports the provided [context] to a [pw.Page].
  Future<pw.Page> exportToPdfPage(BuildContext context) async {
    final pw.Widget? pdfWidget = await _traverseWidgetTree(context);

    return pw.Page(
      pageFormat: options.pageFormatOptions.getPageFormat(),
      clip: options.pageFormatOptions.clip,
      build: (pw.Context context) => pdfWidget!,
    );
  }

  // State is ignored. I.e. textfields will be empty and checkboxes will be unchecked.
  Future<pw.Widget?> exportToPdfWidget(Widget widget) async {
    Element? element = await layoutWidget(widget, const Size(600, 400));

    List<pw.Widget> children = await _matchWidget(element!);

    if (children.isNotEmpty) {
      print('Children: $children');
      return children[1];
    }  else {
      print('No children found');
      return null;
    }
  }

  Future<pw.Page> exportWidgetToPdfPage(Widget widget) async {
    final pw.Widget? pdfWidget = await exportToPdfWidget(widget);
    return pw.Page(
      pageFormat: options.pageFormatOptions.getPageFormat(),
      clip: options.pageFormatOptions.clip,
      build: (pw.Context context) => pdfWidget ?? pw.Container(),
    );
  }

  /// Traverses the widget tree of the provided [context]
  /// and returns the corresponding PDF widget tree.
  Future<pw.Widget?> _traverseWidgetTree(BuildContext context) async {
    Element? element;

    context.visitChildElements((Element e) => element = e);

    pw.Widget? pdfWidget = (await _matchWidget(element!)).first;

    return pdfWidget;
  }

  /// Recursive helper to visit all child elements of the provided [element].
  Future<List<pw.Widget>> _visit(Element element) async {
    List<Element> elements = [];

    element.visitChildElements((Element element) async {
      debugPrint('Element ${element.depth}: ${element.widget}');
      elements.add(element);
    });

    List<pw.Widget> children = [];

    for (Element e in elements) {
      children.addAll(await _matchWidget(e));
    }

    return children;
  }

  /// Matches the widget provided as [element]
  /// and returns the corresponding [pw.Widget].
  Future<List<pw.Widget>> _matchWidget(Element element) async {
    final Widget widget = element.widget;

    switch (widget.runtimeType) {
      case MergeSemantics: //anchor: end of widget tree
        debugPrint('Reached Anchor');
        return [];
      case Container:
        final List children = await _visit(element);
        return [await (widget as Container).toPdfWidget(
          children.isNotEmpty ? children.first : null
        )];
      case Center:
        final List children = await _visit(element);
        return [(widget as Center).toPdfWidget(
          children.isNotEmpty ? children.first : null
        )];
      case SizedBox:
        final List children = await _visit(element);
        return [(widget as SizedBox).toPdfWidget(
          children.isNotEmpty ? children.first : null
        )];
      case FittedBox:
        final List children = await _visit(element);
        return [(widget as FittedBox).toPdfWidget(
          children.isNotEmpty ? children.first : null
        )];
      case LimitedBox:
        final List children = await _visit(element);
        return [(widget as LimitedBox).toPdfWidget(
          children.isNotEmpty ? children.first : null
        )];
      case ConstrainedBox:
        final List children = await _visit(element);
        return [(widget as ConstrainedBox).toPdfWidget(
          children.isNotEmpty ? children.first : null
        )];
      case ClipRect:
        final List children = await _visit(element);
        return [(widget as ClipRect).toPdfWidget(
          children.isNotEmpty ? children.first : null
        )];
      case ClipRRect:
        final List children = await _visit(element);
        return [(widget as ClipRRect).toPdfWidget(
          children.isNotEmpty ? children.first : null
        )];
      case ClipOval:
        final List children = await _visit(element);
        return [(widget as ClipOval).toPdfWidget(
          children.isNotEmpty ? children.first : null
        )];
      case Transform:
        final List children = await _visit(element);
        return [(widget as Transform).toPdfWidget(
          children.isNotEmpty ? children.first : null
        )];
      case Opacity:
        final List children = await _visit(element);
        return [(widget as Opacity).toPdfWidget(
          children.isNotEmpty ? children.first : null
        )];
      case Padding:
        final List children = await _visit(element);
        return [(widget as Padding).toPdfWidget(
          children.isNotEmpty ? children.first : null
        )];
      case Align:
        final List children = await _visit(element);
        return [(widget as Align).toPdfWidget(
          children.isNotEmpty ? children.first : null
        )];
      case Positioned:
        final List children = await _visit(element);
        return [(widget as Positioned).toPdfWidget(children.isNotEmpty ? children.first : pw.Container())];
      case Expanded:
        return[(widget as Expanded).toPdfWidget((await _visit(element)).first)];
      case Flexible:
        return [(widget as Flexible).toPdfWidget((await _visit(element)).first)];
      case Placeholder:
        return [(widget as Placeholder).toPdfWidget()];
      case Text:
        return [(widget as Text).toPdfWidget()];
      case TextField:
        return [await (widget as TextField).toPdfWidget(this)];
      case Divider:
        return [(widget as Divider).toPdfWidget()];
      case Image:
        return [await (widget as Image).toPdfWidget()];
      case Checkbox:
        return [await (widget as Checkbox).toPdfWidget(options.checkboxOptions)];
      case TextButton:
      case ElevatedButton:
      case OutlinedButton:
      case FilledButton:
        return [(widget as ButtonStyleButton).toPdfWidget((await _visit(element)).first)];
      case Column:
        return [(widget as Column).toPdfWidget(await _visit(element))];
      case Row:
        return [(widget as Row).toPdfWidget(await _visit(element))];
      case Stack:
        return [(widget as Stack).toPdfWidget(await _visit(element))];
      case ListView:
          return [(widget as ListView).toPdfWidget(await _visit(element))];
      case GridView:
        final BoxConstraints constraints = (element.renderObject! as RenderRepaintBoundary).constraints;
        return [(widget as GridView).toPdfWidget(await _visit(element), constraints)];
      case Wrap:
        return [(widget as Wrap).toPdfWidget(await _visit(element))];
      case Table:
        return [await (widget as Table).toPdfWidget(await _visit(element))];
      default:
        debugPrint('Uncaught: ${widget.runtimeType}');
        return await _visit(element);
    }
  }

}

/// Lays out the provided [widget] in a view of [size] and returns it as [Element].
Future<Element?> layoutWidget(Widget widget, Size size) async {
  RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();

  RenderView renderView = RenderView(
    configuration: ViewConfiguration(
      size: size,
      devicePixelRatio: 1.0,
    ),
    window: WidgetsBinding.instance.platformDispatcher.views.first,
    child: RenderPositionedBox(
      alignment: Alignment.center,
      child: repaintBoundary,
    ),
  );

  PipelineOwner pipelineOwner = PipelineOwner();
  pipelineOwner.rootNode = renderView;
  renderView.prepareInitialFrame();

  BuildOwner buildOwner = BuildOwner(focusManager: FocusManager());
  RenderObjectToWidgetElement rootElement = RenderObjectToWidgetAdapter(
    container: repaintBoundary,
    child: MediaQuery(
      data: MediaQueryData(size: size),
      child: MaterialApp(
        home: Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: widget,
          ),
        ),
      ),
    ),
  ).attachToRenderTree(buildOwner);
  buildOwner.buildScope(rootElement);
  buildOwner.finalizeTree();

  pipelineOwner.flushLayout();
  pipelineOwner.flushCompositingBits();
  pipelineOwner.flushPaint();

  Element? element;

  rootElement.visitChildren((Element child) => element = child);

  return element;
}
