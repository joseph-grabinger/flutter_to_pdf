import 'dart:io';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:ui' as ui;

import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

const double inch = 72.0;
const double cm = inch / 2.54;
const double mm = inch / 25.4;

enum ExportType { pdf, png }

class ExportDialogController extends GetxController{

  final RenderObject renderObject;

  late final editTitle = TextEditingController();
  late final Rx<ExportType> exportType;
  late final RxInt quality;

  ExportDialogController({
    required this.renderObject,
    required String title,
    ExportType exportType = ExportType.pdf,
    int quality = 4,
  }) {
    editTitle.text = title;
    this.exportType = exportType.obs;
    this.quality = quality.obs;
  }

  void export() async {
    RenderRepaintBoundary boundary = renderObject as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: quality.toDouble());
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData byteData = (await image.toByteData(format: ui.ImageByteFormat.png))!;
    Uint8List pngBytes = byteData.buffer.asUint8List();

    switch (exportType.value) {
      case ExportType.pdf: {
        final pdf = pw.Document(
          title: editTitle.text,
          author: 'Nick Westendorf',
          creator: 'Dunef UG (haftungsbeschränkt)',
          subject: editTitle.text,
          producer: 'Dunef UG (haftungsbeschränkt)',
        );
        pdf.addPage(pw.Page(
          margin: pw.EdgeInsets.zero,
          pageFormat: const PdfPageFormat(21.0 * cm, 29.7 * cm, marginAll: 0),
          build: (pw.Context context) {
            return pw.Image(
              pw.MemoryImage(
                pngBytes,
              ),
            ); // Center
          }
        ));

        final file = File('$directory/${editTitle.text}.pdf');
        await file.writeAsBytes(await pdf.save());

        Share.shareXFiles([XFile(file.path)],);
      } break;

      case ExportType.png: {
        final file = File('$directory/${editTitle.text}.png');
        await file.writeAsBytes(pngBytes);

        Share.shareXFiles([XFile(file.path)],);
      } break;
    }
  }
}

class ExportDialog extends StatelessWidget {

  final ExportDialogController controller;

  const ExportDialog({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(30.0),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10.0,),
              TextField(
                controller: controller.editTitle,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(14.0),
                  labelText: 'Titel',
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 20.0,),
              const Text('Export Type:', style: TextStyle(fontWeight: FontWeight.w600),),
              const SizedBox(height: 4.0,),
              Obx(() => RadioListTile<ExportType>(
                title: const Text('PDF', style: TextStyle(fontWeight: FontWeight.w600),),
                value: ExportType.pdf,
                groupValue: controller.exportType.value,
                onChanged: (value) => controller.exportType.value = value!,
                visualDensity: VisualDensity.compact,
              )),
              Obx(() => RadioListTile<ExportType>(
                title: const Text('PNG', style: TextStyle(fontWeight: FontWeight.w600),),
                value: ExportType.png,
                groupValue: controller.exportType.value,
                onChanged: (value) => controller.exportType.value = value!,
                visualDensity: VisualDensity.compact,
              )),
              const SizedBox(height: 16.0,),
              Obx(() => Text('Resolution Quality (${controller.quality}):', style: const TextStyle(fontWeight: FontWeight.w600),)),
              Obx(() => Slider(
                value: controller.quality.value.toDouble(),
                min: 1,
                max: 10,
                divisions: 9,
                label: controller.quality.value.toString(),
                onChanged: (value) => controller.quality.value = value.round(),
              )),
              const SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xffeebbbb),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text('Abbrechen', style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0,),
                  Expanded(
                    child: InkWell(
                      onTap: controller.export,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xfff0f8ff),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x55000000),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        child: const Text('Exportieren', style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}