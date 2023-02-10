import 'package:flutter/material.dart';

import 'package:pdf/widgets.dart' as pw;

import 'package:teaplates/page_format.dart';
import 'package:teaplates/teaplates.dart';


const double pwToFlPx = 0.7;

class PfPage extends StatelessWidget {
  const PfPage({
    Key? key,
    this.pageFormat = PfPageFormat.a4,
    required this.child,
  }) : super(key: key);

  final PfPageFormat pageFormat;
  final PfWidget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics : const ClampingScrollPhysics(),
      child: AspectRatio(
        aspectRatio: pageFormat.width / pageFormat.height,
        child: InteractiveViewer(
          maxScale: 7, 
          child: Container(
            margin: const EdgeInsets.all(10.0),
            height: pageFormat.height,
            width: pageFormat.width,
            padding: EdgeInsets.only(
              left: pageFormat.marginLeft,
              right: pageFormat.marginRight,
              top: pageFormat.marginTop,
              bottom: pageFormat.marginBottom,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x55000000),
                  blurRadius: 2,
                  spreadRadius: 1,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  pw.Page toPage() {
    return pw.Page(
      pageFormat: pageFormat.toPw(),
      build: (pw.Context context) {
        return child.toPw();
      },
    );
  }
}