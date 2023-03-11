## Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:teaplates/teaplates.dart';

Builder(
  builder: (BuildContext context) {
    return Container(); // any Flutter Widgets can be used here
  }
)

// export the view to a PDF Document
final Document pdf = await exportToPDF(context);
```

## Save the PDF Document

```dart
import 'dart:io';

// set the path and name of the file
final File file = File('somePath/someName.pdf');

// save the PDF Document
await file.writeAsBytes(pdf.save());
```
