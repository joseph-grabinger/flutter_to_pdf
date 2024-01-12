import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'utils.dart';

late pw.Document pdf;
final ExportDelegate exportDelegate = ExportDelegate();
final ExportOptions overrideOptions = ExportOptions(
  pageFormatOptions: PageFormatOptions.custom(width: 1000, height: 500),
);

void main() {
  setUpAll(() {
    pw.Document.debug = true;
    pdf = pw.Document();
  });

  testWidgets('Wrap Widgets Wrap Horizontal 1', (tester) async {
    final children = <Widget>[];
    for (final direction in VerticalDirection.values) {
      children.add(Text('$direction'));
      for (final alignment in WrapAlignment.values) {
        children.add(Text('$alignment'));
        children.add(Expanded(
          child: Wrap(
            direction: Axis.horizontal,
            alignment: alignment,
            verticalDirection: direction,
            textDirection: TextDirection.ltr,
            children: List<Widget>.generate(30, (int n) => Text('${n + 1}')),
          ),
        ));
      }
    }

    await tester.pumpWidget(ExportFrame(
      frameId: 'wrap horizontal 1',
      exportDelegate: exportDelegate,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: children,
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('wrap horizontal 1'));
  });

  testWidgets('Wrap Widgets Wrap Horizontal 2', (tester) async {
    final children = <Widget>[];
    for (final alignment in WrapCrossAlignment.values) {
      final rnd = math.Random(42);
      children.add(Text('$alignment'));
      children.add(Wrap(
        direction: Axis.horizontal,
        crossAxisAlignment: alignment,
        runSpacing: 20,
        spacing: 20,
        textDirection: TextDirection.ltr,
        children: List<Widget>.generate(
            15,
            (int n) => SizedBox(
                  width: rnd.nextDouble() * 100,
                  height: rnd.nextDouble() * 50,
                  child: const Placeholder(),
                )),
      ));
    }

    await tester.pumpWidget(ExportFrame(
      frameId: 'wrap horizontal 2',
      exportDelegate: exportDelegate,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: children,
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('wrap horizontal 2'));
  });

  testWidgets('Wrap Widgets Wrap Vertical 1', (tester) async {
    FlutterError.onError = ignoreOverflowErrors;

    final children = <Widget>[];
    for (final direction in VerticalDirection.values) {
      children
          .add(Transform.rotate(angle: math.pi / 2, child: Text('$direction')));
      for (final alignment in WrapAlignment.values) {
        children.add(
            Transform.rotate(angle: math.pi / 2, child: Text('$alignment')));
        children.add(Wrap(
          direction: Axis.vertical,
          alignment: alignment,
          verticalDirection: direction,
          textDirection: TextDirection.ltr,
          children: List<Widget>.generate(30, (int n) => Text('${n + 1}')),
        ));
      }
    }

    await tester.pumpWidget(ExportFrame(
      frameId: 'wrap vertical 1',
      exportDelegate: exportDelegate,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: children,
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('wrap vertical 1',
        overrideOptions: overrideOptions));
  });

  testWidgets('Wrap Widgets Wrap Vertical 2', (tester) async {
    FlutterError.onError = ignoreOverflowErrors;

    final children = <Widget>[];
    for (final alignment in WrapCrossAlignment.values) {
      final rnd = math.Random(42);
      children
          .add(Transform.rotate(angle: math.pi / 2, child: Text('$alignment')));
      children.add(Expanded(
        child: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: alignment,
          runSpacing: 20,
          spacing: 20,
          textDirection: TextDirection.ltr,
          children: List<Widget>.generate(
              10,
              (int n) => SizedBox(
                    width: rnd.nextDouble() * 50,
                    height: rnd.nextDouble() * 100,
                    child: const Placeholder(),
                  )),
        ),
      ));
    }

    await tester.pumpWidget(ExportFrame(
      frameId: 'wrap vertical 2',
      exportDelegate: exportDelegate,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: children,
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('wrap vertical 2',
        overrideOptions: overrideOptions));
  });

  testWidgets('Wrap Widgets Empty', (tester) async {
    await tester.pumpWidget(ExportFrame(
      frameId: 'wrap empty',
      exportDelegate: exportDelegate,
      child: const Directionality(
        textDirection: TextDirection.ltr,
        child: Wrap(
          children: <Widget>[],
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('wrap empty'));
  });

  tearDownAll(() async {
    final file = File('./test/output/widgets-wrap.pdf');
    file.writeAsBytesSync(await pdf.save());
  });
}
