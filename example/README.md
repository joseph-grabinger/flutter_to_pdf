## Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';

// create instance of ExportDelegate
final ExportDelegate exportDelegate = ExportDelegate();

// wrap the widget you want to export with a ExportFrame widget
ExportFrame(
  frameId: 'someFrameId', // identifies the frame
  child: SomeWidget(), // the widget you want to export
)

// export the frame to a PDF Document
final pdf = await exportDelegate.exportToPdfDocument('someFrameId');
```

## Save the PDF Document

```dart
import 'dart:io';

// set the path and name of the file
final File file = File('somePath/someName.pdf');

// save the PDF Document
await file.writeAsBytes(pdf.save());
```
