import 'package:flutter/widgets.dart';
import 'package:pdf/widgets.dart' as pw;

// widgets
export 'package:teaplates/pf/widgets/align.dart';
export 'package:teaplates/pf/widgets/center.dart';
export 'package:teaplates/pf/widgets/column.dart';
export 'package:teaplates/pf/widgets/container.dart';
export 'package:teaplates/pf/widgets/divider.dart';
export 'package:teaplates/pf/widgets/expanded.dart';
export 'package:teaplates/pf/widgets/flexible.dart';
export 'package:teaplates/pf/widgets/padding.dart';
export 'package:teaplates/pf/widgets/row.dart';
export 'package:teaplates/pf/widgets/sized_box.dart';
export 'package:teaplates/pf/widgets/text_field.dart';
export 'package:teaplates/pf/widgets/text.dart';

// args
export 'package:teaplates/pf/args/alignment.dart';
export 'package:teaplates/pf/args/border_radius.dart';
export 'package:teaplates/pf/args/border_side.dart';
export 'package:teaplates/pf/args/border_style.dart';
export 'package:teaplates/pf/args/border.dart';
export 'package:teaplates/pf/args/box_decoration.dart';
export 'package:teaplates/pf/args/box_fit.dart';
export 'package:teaplates/pf/args/box_shadow.dart';
export 'package:teaplates/pf/args/box_shape.dart';
export 'package:teaplates/pf/args/color.dart';
export 'package:teaplates/pf/args/cross_axis_alignment.dart';
export 'package:teaplates/pf/args/edge_insets.dart';
export 'package:teaplates/pf/args/flex_fit.dart';
export 'package:teaplates/pf/args/font_style.dart';
export 'package:teaplates/pf/args/font_weight.dart';
export 'package:teaplates/pf/args/font.dart';
export 'package:teaplates/pf/args/google_font.dart';
export 'package:teaplates/pf/args/main_axis_alignment.dart';
export 'package:teaplates/pf/args/main_axis_size.dart';
export 'package:teaplates/pf/args/point.dart';
export 'package:teaplates/pf/args/radius.dart';
export 'package:teaplates/pf/args/text_style.dart';
export 'package:teaplates/pf/args/vertical_direction.dart';

abstract class PfWidget extends StatelessWidget {
  const PfWidget({
    Key? key,
  }) : super(key: key);

  pw.Widget toPw();
}