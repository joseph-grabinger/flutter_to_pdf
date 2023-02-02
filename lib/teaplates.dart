library teaplates;

import 'package:flutter/widgets.dart';

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
