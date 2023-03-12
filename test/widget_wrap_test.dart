import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teaplates/teaplates.dart';

import 'utils.dart';


late Document pdf;

void main() {
  setUpAll(() {
    Document.debug = true;
    pdf = Document();
  });

  testWidgets('Wrap Widgets Wrap Horizontal 1', (tester) async {
    final children = <Widget>[];
    for (final direction in VerticalDirection.values) {
      children.add(Text('$direction'));
      for (final alignment in WrapAlignment.values) {
        children.add(Text('$alignment'));
        children.add(Wrap(
          direction: Axis.horizontal,
          alignment: alignment,
          verticalDirection: direction,
          textDirection: TextDirection.ltr,
          children: List<Widget>.generate(30, (int n) => Text('${n + 1}')),
        ));
      }
    }

    late BuildContext exportContext;

    await tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: children,
          ),
        );
      },
    ));

    pdf.addPage(await exportToPdfPage(exportContext));
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
        children: List<Widget>.generate(15, (int n) => SizedBox(
          width: rnd.nextDouble() * 100,
          height: rnd.nextDouble() * 50,
          child: const Placeholder(),
        )),
      ));
    }

    late BuildContext exportContext;

    await tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: children,
          ),
        );
      },
    ));

    pdf.addPage(await exportToPdfPage(exportContext));
  });

  testWidgets('Wrap Widgets Wrap Vertical 1', (tester) async {
    FlutterError.onError = ignoreOverflowErrors;

    final children = <Widget>[];
    for (final direction in VerticalDirection.values) {
      children.add(Transform.rotate(angle: math.pi / 2, child: Text('$direction')));
      for (final alignment in WrapAlignment.values) {
        children.add(Transform.rotate(angle: math.pi / 2, child: Text('$alignment')));
        children.add(Wrap(
          direction: Axis.vertical,
          alignment: alignment,
          verticalDirection: direction,
          textDirection: TextDirection.ltr,
          children: List<Widget>.generate(30, (int n) => Text('${n + 1}')),
        ));
      }
    }

    late BuildContext exportContext;

    await tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: children,
          ),
        );
      },
    ));

    pdf.addPage(await exportToPdfPage(exportContext,
      options: const ExportOptions(
          pageFormatOptions: PageFormatOptions.custom(width: 1000, height: 500),
        ),
    ));
  });

  testWidgets('Wrap Widgets Wrap Vertical 2', (tester) async {
    FlutterError.onError = ignoreOverflowErrors;

    final children = <Widget>[];
    for (final alignment in WrapCrossAlignment.values) {
      final rnd = math.Random(42);
      children.add(Transform.rotate(angle: math.pi / 2, child: Text('$alignment')));
      children.add(Expanded(
        child: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: alignment,
          runSpacing: 20,
          spacing: 20,
          textDirection: TextDirection.ltr,
          children: List<Widget>.generate(10, (int n) => SizedBox(
            width: rnd.nextDouble() * 50,
            height: rnd.nextDouble() * 100,
            child: const Placeholder(),
          )),
        ),
      ));
    }

    late BuildContext exportContext;

    await tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: children,
          ),
        );
      },
    ));

    pdf.addPage(await exportToPdfPage(exportContext, 
      options: const ExportOptions(
        pageFormatOptions: PageFormatOptions.custom(width: 1000, height: 500),
      ),
    ));
  });

  testWidgets('Wrap Widgets Empty', (tester) async {
    late BuildContext exportContext;

    await tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return const Directionality(
          textDirection: TextDirection.ltr,
          child: Wrap(
            children: <Widget>[],
          ),
        );
      },
    ));

    pdf.addPage(await exportToPdfPage(exportContext));
  });

  tearDownAll(() async {
    final file = File('./test/output/widgets-wrap.pdf');
    file.writeAsBytesSync(await pdf.save());
  });
}
