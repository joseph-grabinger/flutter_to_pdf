
import 'package:flutter/widgets.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:google_fonts/google_fonts.dart';
import 'package:printing/printing.dart';

import 'package:teaplates/teaplates.dart';


class PfGoogleFont {
  PfGoogleFont.latoRegular(this.textStyle):
    flFont = GoogleFonts.lato(
      fontWeight: FontWeight.w400,
      textStyle: textStyle.toFl(),
    ),
    pwFont = PdfGoogleFonts.latoRegular();

  final PfTextStyle textStyle;
  final TextStyle flFont;
  final Future<pw.Font> pwFont;

  Future<pw.TextStyle> toPw() async {
    return pw.TextStyle(
      font: await pwFont,
      fontSize: textStyle.fontSize,
      color: textStyle.color?.toPw(),
      fontWeight: textStyle.fontWeight?.toPw(),
      fontStyle: textStyle.fontStyle?.toPw(),
      letterSpacing: textStyle.letterSpacing,
      wordSpacing: textStyle.wordSpacing,
      height: textStyle.height,
    );
  }

  TextStyle toFl() {
    return flFont;
  }
}