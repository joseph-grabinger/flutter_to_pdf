<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

The [teaplates](https://dunef.io/de) package lets you export any Flutter view to PDF Documents and is written natively in Dart.

## Installing
### Depend on it 

Run this command:

```shell
$ flutter pub add teaplates
```

This will add a line like this to your package's pubspec.yaml (and run an implicit `flutter pub get`):

```yaml
dependencies:
    teaplates: ^0.0.1
```

Alternatively, your editor might support `flutter pub get`. Check the docs for your editor to learn more.

### Import it
Now in your Dart code, you can use:

```dart
import 'package:teaplates/teaplates.dart';
```

## Features

- basic export to PDF by `BuildContext`
- export with options
    - Page format options
    - Text field options
    - Checkbox options


## Usage

Call the `exportToPDF` function with the `BuildContext` of the view you want to export to PDF. The function will return a `Document` object which can be used to save the PDF Document to a file or to display it in a PDF Viewer.

```dart
Builder(
  builder: (BuildContext context) => Column(
    children: [
        // any Flutter Widgets can be used here
    ],
  );
)

// export the view to a PDF Document
final Document pdf = await exportToPDF(context);
```
