import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';


late Document pdf;

void main() async {
  setUpAll(() {
    Document.debug = true;
    pdf = Document();
  });

  testWidgets('Text Widgets Quotes', (tester) async {
    late BuildContext exportContext;

    await tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return const Directionality(
          textDirection: TextDirection.ltr,
          child: Text('Text containing \' or " works!'),
        );
      },
    ));

    pdf.addPage(await exportToPdfPage(exportContext));
  });

  testWidgets('Text Widgets SoftWrap', (tester) async {
    late BuildContext exportContext;

    String lore = 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor';

    await tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return  Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: [
              const Expanded(child: Text('Text with\nsoft wrap\nenabled', softWrap: true)),
              const Expanded(child: Text('Text with\nsoft wrap\nenabled', softWrap: false)),
              Expanded(
                child: SizedBox(
                  width: 120,
                  child: Text(lore,
                    softWrap: false,
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 120,
                  child: Text(lore,
                    softWrap: true,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ));

    pdf.addPage(await exportToPdfPage(exportContext));
  });

  testWidgets('Text Widgets Alignment', (tester) async {
    final children = <Widget>[];
    for (final align in TextAlign.values.where((element) => element != TextAlign.end)) {
      children.add(
        SizedBox(
          width: 120,
          child: Text('Text with alignment $align',
            textAlign: align,
          ),
        ),
      );
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

  testWidgets('Text Widgets WordSpacing', (tester) async {
    final children = <Widget>[];
    for (var spacing = 0.0; spacing < 10.0; spacing += 2.0) {
      children.add(
        Text('Text with WordSpacing $spacing',
          style: TextStyle(
            wordSpacing: spacing,
          ),
        ),
      );
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

  testWidgets('Text Widgets LetterSpacing', (tester) async {
    final children = <Widget>[];
    for (var spacing = 0.0; spacing < 10.0; spacing += 2.0) {
      children.add(
        Text('Text with LetterSpacing $spacing',
          style: TextStyle(
            letterSpacing: spacing,
          ),
        ),
      );
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

  testWidgets('Text Widgets Font', (tester) async {
    final children = <Widget>[];
    for (final font in ['Courier', 'Helvetica', 'Times', 'ZapfDingbats', 'Symbol']) {
      children.add(
        Text('Text with FontFamily $font',
          style: TextStyle(
            fontFamily: font,
          ),
        ),
      );
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

  testWidgets('Text Widgets FontStyle', (tester) async {
    final children = <Widget>[];
    for (final fontStyle in FontStyle.values) {
      children.add(
        Text('Text with FontStyle $fontStyle',
          style: TextStyle(
            fontStyle: fontStyle,
          ),
        ),
      );
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
        Text('Text with TextDecoration $decoration',
          style: TextStyle(
            decoration: decoration,
          ),
        ),
      );
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

  testWidgets('Text Widgets Overflow', (tester) async {
    final children = <Widget>[];
    for (final overflow in TextOverflow.values) {
      children.add(
        Text('Text with TextOverflow $overflow',
          style: TextStyle(
            overflow: overflow,
          ),
        ),
      );
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

  testWidgets('Text Widgets Direction', (tester) async {
    late BuildContext exportContext;

    await tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        exportContext = context;
        return const Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Text with TextDirection ltr',
              textDirection: TextDirection.ltr,
            ),
            Text('Text with TextDirection rtl',
              textDirection: TextDirection.rtl,
            ),
          ],
        );
      },
    ));

    pdf.addPage(await exportToPdfPage(exportContext));
  });

tearDownAll(() async {
    final file = File('./test/output/widgets-text.pdf');
    file.writeAsBytesSync(await pdf.save());
  });
}
