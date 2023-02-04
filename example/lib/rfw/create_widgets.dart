import 'package:rfw/rfw.dart';
import 'package:pdf/widgets.dart';

import 'package:example/dynamic_data.dart';
import 'widgets/center.dart';
import 'widgets/container.dart';
import 'widgets/root.dart';
import 'widgets/text.dart';

WidgetLibrary createWidgets(dynamic state) => LocalWidgetLibrary(
  Map.fromEntries([
    //RfwAlign.toEntry(),
    //RfwAspectRatio.toEntry(),
    RfwCenter.toEntry(),
    //RfwColumn.toEntry(),
    RfwContainer.toEntry(),
    RfwRoot.toEntry(state),
    RfwText.toEntry(),
  ]),
);




Widget? rfwToPdf(curried, DynamicData dyDa) {
  if (curried == null) return null;
  
  switch (curried.fullName.widget) {
    case 'Center': return RfwCenter.toPdf(curried, dyDa);
    case 'Container': return RfwContainer.toPdf(curried, dyDa);
    case 'Root': return RfwRoot.toPdf(curried, dyDa);
    case 'Text': return RfwText.toPdf(curried, dyDa);
    default:
      return null;
  }
}