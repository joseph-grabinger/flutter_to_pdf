import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teaplates/teaplates.dart';


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

  testWidgets('Text Widgets Alignement', (tester) async {
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

tearDownAll(() async {
    final file = File('./test/output/widgets-text.pdf');
    file.writeAsBytesSync(await pdf.save());
  });
}
