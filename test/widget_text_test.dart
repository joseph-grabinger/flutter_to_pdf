import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'utils.dart';

late pw.Document pdf;
final ExportDelegate exportDelegate = ExportDelegate(ttfFonts: {
  'LoveDays': './example/assets/fonts/LoveDays-Regular.ttf',
  'OpenSans': './example/assets/fonts/OpenSans-Regular.ttf',
});

void main() async {
  setUpAll(() {
    pw.Document.debug = true;
    pdf = pw.Document();
  });

  testWidgets('Text Widgets Quotes', (tester) async {
    await tester.pumpWidget(ExportFrame(
      frameId: 'text quotes',
      exportDelegate: exportDelegate,
      child: const Directionality(
        textDirection: TextDirection.ltr,
        child: Text('Text containing \' or " works!'),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('text quotes'));
  });

  testWidgets('Text Widgets SoftWrap', (tester) async {
    String lore =
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor';

    await tester.pumpWidget(ExportFrame(
      frameId: 'text soft wrap',
      exportDelegate: exportDelegate,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          children: [
            const Expanded(
                child: Text('Text with\nsoft wrap\nenabled', softWrap: true)),
            const Expanded(
                child: Text('Text with\nsoft wrap\nenabled', softWrap: false)),
            Expanded(
              child: SizedBox(
                width: 120,
                child: Text(
                  lore,
                  softWrap: false,
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: 120,
                child: Text(
                  lore,
                  softWrap: true,
                ),
              ),
            ),
          ],
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('text soft wrap'));
  });

  testWidgets('Text Widgets Alignment', (tester) async {
    final children = <Widget>[];
    for (final align in TextAlign.values) {
      children.add(
        SizedBox(
          width: 120,
          child: Text(
            'Text with alignment $align',
            textAlign: align,
          ),
        ),
      );
    }

    await tester.pumpWidget(ExportFrame(
      frameId: 'text alignment',
      exportDelegate: exportDelegate,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: children,
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('text alignment'));
  });

  testWidgets('Text Widgets WordSpacing', (tester) async {
    final children = <Widget>[];
    for (var spacing = 0.0; spacing < 10.0; spacing += 2.0) {
      children.add(
        Text(
          'Text with WordSpacing $spacing',
          style: TextStyle(
            wordSpacing: spacing,
          ),
        ),
      );
    }

    await tester.pumpWidget(ExportFrame(
      frameId: 'text word spacing',
      exportDelegate: exportDelegate,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: children,
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('text word spacing'));
  });

  testWidgets('Text Widgets LetterSpacing', (tester) async {
    final children = <Widget>[];
    for (var spacing = 0.0; spacing < 10.0; spacing += 2.0) {
      children.add(
        Text(
          'Text with LetterSpacing $spacing',
          style: TextStyle(
            letterSpacing: spacing,
          ),
        ),
      );
    }

    await tester.pumpWidget(ExportFrame(
      frameId: 'text letter spacing',
      exportDelegate: exportDelegate,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: children,
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('text letter spacing'));
  });

  testWidgets('Text Widgets Font', (tester) async {
    final children = <Widget>[];
    for (final font in [
      'Courier',
      'Helvetica',
      'Times',
      'ZapfDingbats',
      'Symbol'
    ]) {
      children.add(
        Text(
          'Text with FontFamily $font',
          style: TextStyle(
            fontFamily: font,
          ),
        ),
      );
    }

    await tester.pumpWidget(ExportFrame(
      frameId: 'text font',
      exportDelegate: exportDelegate,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: children,
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('text font'));
  });

  testWidgets('Text Widgets custom TTF Font', (tester) async {
    final children = <Widget>[];
    for (final font in [
      'LoveDays',
      'OpenSans',
    ]) {
      children.add(
        Text(
          'Text with FontFamily $font',
          style: TextStyle(
            fontFamily: font,
          ),
        ),
      );
    }

    await tester.pumpWidget(MaterialApp(
      home: DefaultAssetBundle(
        bundle: TestAssetBundle(),
        child: ExportFrame(
          frameId: 'text custom font',
          exportDelegate: exportDelegate,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: children,
            ),
          ),
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('text custom font'));
  });

  testWidgets('Text Widgets FontStyle', (tester) async {
    final children = <Widget>[];
    for (final fontStyle in FontStyle.values) {
      children.add(
        Text(
          'Text with FontStyle $fontStyle',
          style: TextStyle(
            fontStyle: fontStyle,
          ),
        ),
      );
    }

    await tester.pumpWidget(ExportFrame(
      frameId: 'text font style',
      exportDelegate: exportDelegate,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: children,
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('text font style'));
  });

  testWidgets('Text Widgets Decoration', (tester) async {
    final children = <Widget>[];
    final decorations = <TextDecoration>[
      TextDecoration.lineThrough,
      TextDecoration.overline,
      TextDecoration.underline,
      TextDecoration.none,
    ];
    for (final decoration in decorations) {
      children.add(
        Text(
          'Text with TextDecoration $decoration',
          style: TextStyle(
            decoration: decoration,
          ),
        ),
      );
    }

    await tester.pumpWidget(ExportFrame(
      frameId: 'text decoration',
      exportDelegate: exportDelegate,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: children,
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('text decoration'));
  });

  testWidgets('Text Widgets Overflow', (tester) async {
    final children = <Widget>[];
    for (final overflow in TextOverflow.values) {
      children.add(
        Text(
          'Text with TextOverflow $overflow',
          style: TextStyle(
            overflow: overflow,
          ),
        ),
      );
    }

    await tester.pumpWidget(ExportFrame(
      frameId: 'text overflow',
      exportDelegate: exportDelegate,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: children,
        ),
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('text overflow'));
  });

  testWidgets('Text Widgets Direction', (tester) async {
    await tester.pumpWidget(ExportFrame(
      frameId: 'text direction',
      exportDelegate: exportDelegate,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Text with TextDirection ltr',
            textDirection: TextDirection.ltr,
          ),
          Text(
            'Text with TextDirection rtl',
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    ));

    pdf.addPage(await exportDelegate.exportToPdfPage('text direction'));
  });

  tearDownAll(() async {
    final file = File('./test/output/widgets-text.pdf');
    file.writeAsBytesSync(await pdf.save());
  });
}
