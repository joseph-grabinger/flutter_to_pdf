library teaplates;

import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// widgets
export 'package:teaplates/widgets/align.dart';
export 'package:teaplates/widgets/center.dart';
export 'package:teaplates/widgets/column.dart';
export 'package:teaplates/widgets/container.dart';
export 'package:teaplates/widgets/divider.dart';
export 'package:teaplates/widgets/expanded.dart';
export 'package:teaplates/widgets/flexible.dart';
export 'package:teaplates/widgets/padding.dart';
export 'package:teaplates/widgets/row.dart';
export 'package:teaplates/widgets/sized_box.dart';
export 'package:teaplates/widgets/text_field.dart';
export 'package:teaplates/widgets/text.dart';

// args
export 'package:teaplates/args/alignment.dart';
export 'package:teaplates/args/border_radius.dart';
export 'package:teaplates/args/border_side.dart';
export 'package:teaplates/args/border_style.dart';
export 'package:teaplates/args/border.dart';
export 'package:teaplates/args/box_decoration.dart';
export 'package:teaplates/args/box_fit.dart';
export 'package:teaplates/args/box_shadow.dart';
export 'package:teaplates/args/box_shape.dart';
export 'package:teaplates/args/color.dart';
export 'package:teaplates/args/cross_axis_alignment.dart';
export 'package:teaplates/args/edge_insets.dart';
export 'package:teaplates/args/flex_fit.dart';
export 'package:teaplates/args/font_style.dart';
export 'package:teaplates/args/font_weight.dart';
export 'package:teaplates/args/font.dart';
export 'package:teaplates/args/google_font.dart';
export 'package:teaplates/args/main_axis_alignment.dart';
export 'package:teaplates/args/main_axis_size.dart';
export 'package:teaplates/args/point.dart';
export 'package:teaplates/args/radius.dart';
export 'package:teaplates/args/text_style.dart';
export 'package:teaplates/args/vertical_direction.dart';


abstract class PfWidget extends StatelessWidget {
  const PfWidget({
    Key? key,
  }) : super(key: key);

  pw.Widget toPw();
}

extension ContainerChild on pw.Container {
  pw.Container setChild(pw.Widget? child) {
    return pw.Container(
      alignment: alignment,
      padding: padding,
      decoration: decoration,
      foregroundDecoration: foregroundDecoration,
      margin: margin,
      transform: transform,
      constraints: constraints,
      child: child,
    );
  }
}

extension CenterChild on pw.Center {
  pw.Center setChild(pw.Widget? child) {
    return pw.Center(
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      child: child,
    );
  }
}

extension WidgetChild on pw.Widget {
  pw.Widget setChild(pw.Widget? child) {
    print('Setting child of $runtimeType to: $child');
    switch (runtimeType) {
      case pw.Container:
        return (this as pw.Container).setChild(child);
      case pw.Center:
        return (this as pw.Center).setChild(child);
      default:
        print('Uncaught setter Type: $runtimeType');
        return this;
    }
  }
}

pw.Widget? widgetTree;

/// Exports the provided [context] to a PDF file.
Future<void> exportPDF(BuildContext context) async {
  final pw.Widget pdfWidget = visitAll(context);
  print('Found: ${pdfWidget.toString()}');
  pw.Container cont = (pdfWidget as pw.Container);
  print('Found2: ${cont.child}'); // Why is this null?!?!?!? ---------
  // print('Found3: ${(cont.child as pw.Container).child}');

  final pdf = pw.Document();

  pdf.addPage(pw.Page(
    build: (pw.Context context) {
      return pdfWidget;
    },
  ));
  Directory dir = await getApplicationDocumentsDirectory();
  final file = File("${dir.path}/example.pdf");
  await file.writeAsBytes(await pdf.save());
  print('Path: ${file.path}');

  pw.Widget test = pw.Container();
  print('Test: $test');
  test = test.setChild(pw.Center());
  pw.Widget test2 = (test as pw.Container).child!;
  print('Test2: $test2');
  test2 = test2.setChild(pw.Text('asdf'));
  pw.Widget test3 = (test2 as pw.Center).child!;
  print('Test3: $test3');
}

/// Visists all widgets in the widget tree
/// and builds the corresponding PDF widget tree.
pw.Widget visitAll(BuildContext context) {
  pw.Widget rootWidget = pw.Container();
  context.visitChildElements((Element element) {
    print('Initial: $element');
    visit(element, rootWidget);
  });
  
  return rootWidget;
}

void visit(Element element, pw.Widget parent) {
  print('visit- Element: $element, PDFParent: $parent');

  pw.Widget? childWidget;
  Element? childElement;
  element.visitChildElements((Element element) {
    print('Child: $element');
    childElement = element;
    switch (element.widget.runtimeType) {
      case Center:
        childWidget = pw.Center();
        parent = parent.setChild(childWidget);
        break;
      case Container:
        childWidget = pw.Container();
        parent = parent.setChild(childWidget);
        break;
      case Text:
        childWidget = pw.Text('ACAB');
        parent = parent.setChild(childWidget);
        childElement = null;
        break;
      default:
        print('Uncaught Widget Type: ${parent.runtimeType}');
        childElement = null;
        break;
    }
  });

  if (childElement != null && childWidget != null) {
    visit(childElement!, childWidget!);
  } else {
    print('Done!');
    return;
  }
}

// pw.Widget? visitChild(Element element) {
//   pw.Widget? pdfWidget;
//   print('VisitChild: $element');
//   // element.visitChildElements((Element element) {
//   //   print('VisitChild Found: $element');
//     switch (element.widget.runtimeType) {
//       case MergeSemantics:
//         pdfWidget = null;
//         break;
//       case Center:
//         pdfWidget = pw.Center();
//         break;
//       case Container:
//         pdfWidget = pw.Container();
//         break;
//       case Text:
//         pdfWidget = pw.Text((element.widget as Text).data!);
//         break;
//       default:
//         print('Uncaught Widget Type: ${element.widget.runtimeType}');
//         break;
//     }
//   // });
//   return pdfWidget;
// }



// pw.Widget? matchWidget(Element element, pw.Widget? widget) {
//   if (widget == null) return null;

//   switch (widget.runtimeType) {
//     case pw.Center:
//       return visitSingleChildWidget(element, widget as pw.Center);
//     case pw.Container:
//       return visitSingleChildWidget(element, widget as pw.SingleChildWidget);
//     case pw.Column:
//       return visitMutiChildWidget(element, widget as pw.Column);
//     case pw.Row:
//       return visitMutiChildWidget(element, widget as pw.Row);
//     case pw.Text:
//       return widget as pw.Text;
//     default:
//       print('Uncaught Widget Type: ${widget.runtimeType}');
//       return null;
//   }
// }


  // /// Recursive helper function to visit all widgets in the widget tree.
  // pw.Widget visit(Element element) {
  //   List<pw.Widget> children = [];

  //   element.visitChildElements((Element element) {
  //     print('Element ${element.depth}: ${element.widget}');

  //     switch (element.widget.runtimeType) {
  //       case MergeSemantics: //anchor: end of widget tree
  //         return;
  //       case Center:
  //         children.add(pw.Center(child: visit(element).first));
  //         break;
  //       case Container:
  //         print('Color:${(element.widget as Container).color!.value}');
  //         children.add(pw.Container(child: visit(element).first));
  //         break;
  //       case Text:
  //         children.add(pw.Text((element.widget as Text).data!));
  //         break;
  //       case Column:
  //         children.add(pw.Column(children: visit(element)));
  //         break;
  //       default: 
  //         print('Uncaught: ${element.widget.runtimeType}');
  //         children.add(visit(element).first);
  //         break;
  //     }
  //   });

  //   print('returned: $children');

  //   return children;
  // }





// /// Exports the provided [context] to a PDF file.
// Future<void> exportPDF(BuildContext context) async {
//   final pw.Widget? pdfWidget = visitAll(context);
//   print('Found: ${pdfWidget.toString()}');

//   final pdf = pw.Document();

//   pdf.addPage(pw.Page(
//     build: (pw.Context context) {
//       return pdfWidget!;
//     },
//   ));
//   Directory dir = await getApplicationDocumentsDirectory();
//   final file = File("${dir.path}/example.pdf");
//   await file.writeAsBytes(await pdf.save());
//   print('Path: ${file.path}');
// }

// /// Visists all widgets in the widget tree.
// pw.Widget? visitAll(BuildContext context) {
//   pw.Widget? pdfWidget;
//   context.visitChildElements((Element element) {
//     print('Initial: $element');
//     pdfWidget = pw.Center(child: visit(element).first);
//   });
  
//   return pdfWidget;
// }

//   /// Recursive helper function to visit all widgets in the widget tree.
//   List<pw.Widget> visit(Element element) {
//     List<pw.Widget> children = [];

//     element.visitChildElements((Element element) {
//       print('Element ${element.depth}: ${element.widget}');

//       switch (element.widget.runtimeType) {
//         case MergeSemantics: //anchor: end of widget tree
//           return;
//         case Center:
//           children.add(pw.Center(child: visit(element).first));
//           break;
//         case Container:
//           print('Color:${(element.widget as Container).color!.value}');
//           children.add(pw.Container(child: visit(element).first));
//           break;
//         case Text:
//           children.add(pw.Text((element.widget as Text).data!));
//           break;
//         case Column:
//          ren.add(pw.Column(children: visit(element)));
//           break;
//         default: 
//           print('Uncaught: ${element.widget.runtimeType}');
//           children.add(visit(elemerst);
//           break;
//       }
//     });

//     print('returned: $children');

//     return children;
//   }

