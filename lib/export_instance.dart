import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:pdf/widgets.dart' as pw;

import 'traversal.dart';
import 'utils.dart';
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

class ExportInstance {
  final ExportDelegate exportDelegate;

  const ExportInstance(this.exportDelegate);

  /// Recursive helper to visit all child elements of the provided [element].
  Future<List<pw.Widget>> _visit(Element element, BuildContext? context) async {
    List<Element> elements = [];

    element.visitChildElements((Element element) async {
      debugPrint('Element ${element.depth}: ${element.widget}');
      elements.add(element);
    });

    List<pw.Widget> children = [];
    for (Element e in elements) {
      children.addAll(await matchWidget(e, context));
    }

    return children;
  }

  /// Matches the widget provided as [element]
  /// and returns the corresponding [pw.Widget].
  Future<List<pw.Widget>> matchWidget(Element element, BuildContext? context) async {
    final Widget widget = element.widget;

    switch (widget.runtimeType) {
      case MergeSemantics: //anchor: end of widget tree
        debugPrint('Reached Anchor');
        return [];
      case Container:
        final List children = await _visit(element, context);
        return [await (widget as Container).toPdfWidget(
          children.isNotEmpty ? children.first : null
        )];
      case Center:
        final List children = await _visit(element, context);
        return [(widget as Center).toPdfWidget(
          children.isNotEmpty ? children.first : null
        )];
      case SizedBox:
        final List children = await _visit(element, context);
        return [(widget as SizedBox).toPdfWidget(
          children.isNotEmpty ? children.first : null
        )];
      case FittedBox:
        final List children = await _visit(element, context);
        return [(widget as FittedBox).toPdfWidget(
          children.isNotEmpty ? children.first : null
        )];
      case LimitedBox:
        final List children = await _visit(element, context);
        return [(widget as LimitedBox).toPdfWidget(
          children.isNotEmpty ? children.first : null
        )];
      case ConstrainedBox:
        final List children = await _visit(element, context);
        return [(widget as ConstrainedBox).toPdfWidget(
          children.isNotEmpty ? children.first : null
        )];
      case ClipRect:
        final List children = await _visit(element, context);
        return [(widget as ClipRect).toPdfWidget(
          children.isNotEmpty ? children.first : null
        )];
      case ClipRRect:
        final List children = await _visit(element, context);
        return [(widget as ClipRRect).toPdfWidget(
          children.isNotEmpty ? children.first : null
        )];
      case ClipOval:
        final List children = await _visit(element, context);
        return [(widget as ClipOval).toPdfWidget(
          children.isNotEmpty ? children.first : null
        )];
      case Transform:
        final List children = await _visit(element, context);
        return [(widget as Transform).toPdfWidget(
          children.isNotEmpty ? children.first : null
        )];
      case Opacity:
        final List children = await _visit(element, context);
        return [(widget as Opacity).toPdfWidget(
          children.isNotEmpty ? children.first : null
        )];
      case Padding:
        final List children = await _visit(element, context);
        return [(widget as Padding).toPdfWidget(
          children.isNotEmpty ? children.first : null
        )];
      case Align:
        final List children = await _visit(element, context);
        return [(widget as Align).toPdfWidget(
          children.isNotEmpty ? children.first : null
        )];
      case Positioned:
        final List children = await _visit(element, context);
        return [(widget as Positioned).toPdfWidget(
          children.isNotEmpty ? children.first : pw.Container(),
        )];
      case Expanded:
        final List children = await _visit(element, context);
        return[(widget as Expanded).toPdfWidget(
          children.isNotEmpty ? children.first : pw.Container(),
        )];
      case Flexible:
        final List children = await _visit(element, context);
        return [(widget as Flexible).toPdfWidget(
          children.isNotEmpty ? children.first : pw.Container(),
        )];
      case Placeholder:
        return [(widget as Placeholder).toPdfWidget()];
      case Text:
        return [(widget as Text).toPdfWidget()];
      case TextField:
      TextField? contextWidget;
        if (context != null) {
          Element? contextElement = findElement(context,
            (TextField e) => e.decoration!.label == (widget as TextField).decoration!.label);
          contextWidget = contextElement!.widget as TextField;
        }
        return [await (widget as TextField).toPdfWidget(exportDelegate, contextWidget)];
      case Divider:
        return [(widget as Divider).toPdfWidget()];
      case Image:
        return [await (widget as Image).toPdfWidget()];
      case Checkbox:
        Checkbox? contextWidget;
        if (context != null) {
          Element? contextElement = findElement(context,
            (Checkbox e) => true); // TODO find a way to match checkboxes
          contextWidget = contextElement!.widget as Checkbox;
        }
        return [await (widget as Checkbox).toPdfWidget(exportDelegate.options.checkboxOptions, contextWidget)];
      case TextButton:
      case ElevatedButton:
      case OutlinedButton:
      case FilledButton:
        return [(widget as ButtonStyleButton).toPdfWidget((await _visit(element, context)).first)];
      case Column:
        return [(widget as Column).toPdfWidget(await _visit(element, context))];
      case Row:
        return [(widget as Row).toPdfWidget(await _visit(element, context))];
      case Stack:
        return [(widget as Stack).toPdfWidget(await _visit(element, context))];
      case ListView:
          return [(widget as ListView).toPdfWidget(await _visit(element, context))];
      case GridView:
        final BoxConstraints constraints = (element.renderObject! as RenderRepaintBoundary).constraints;
        return [(widget as GridView).toPdfWidget(await _visit(element, context), constraints)];
      case Wrap:
        return [(widget as Wrap).toPdfWidget(await _visit(element, context))];
      case Table:
        return [await (widget as Table).toPdfWidget(await _visit(element, context))];
      default:
        debugPrint('Uncaught: ${widget.runtimeType}');
        return await _visit(element, context);
    }
  }
}