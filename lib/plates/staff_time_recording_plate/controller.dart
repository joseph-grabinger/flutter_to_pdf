

import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import 'package:share_plus/share_plus.dart';
import 'package:teaplates/pf/page.dart';
import 'package:teaplates/pf/pf_widget.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart' show PdfPageFormat;

class StaffTimeRecordingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StaffTimeRecordingController>(() => StaffTimeRecordingController());
  }
}

class StaffTimeRecordingController extends GetxController {

  late final PdfControllerPinch pdfControllerPinch = PdfControllerPinch(document: PdfDocument.openAsset('assets/pdf.pdf'));
  late final File pdfFile;

  PfPage pfPage = const PfPage(
    child: PfSizedBox.shrink(),
  );

  @override
  void onInit() async {
    super.onInit();

    final output = await getApplicationDocumentsDirectory();
    pdfFile = File("${output.path}/example.pdf");

    pdfControllerPinch.loadDocument(PdfDocument.openFile(pdfFile.path));
  }


  void createPdf(PfPage pfPage) async {
    final pdf = pw.Document();

    pdf.addPage(pfPage.toPage()); // Page

    await pdfFile.writeAsBytes(await pdf.save());

    pdfControllerPinch.loadDocument(PdfDocument.openFile(pdfFile.path));

    Share.shareXFiles([XFile(pdfFile.path)]);
  }

  
}