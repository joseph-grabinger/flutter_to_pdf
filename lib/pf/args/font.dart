
import 'package:pdf/widgets.dart' as pw;

class PfFont {

  PfFont(this.flFont, this.pwFont);

  static PfFont courier = PfFont('Courier', pw.Font.courier());
  static PfFont helvetica = PfFont('Helvetica', pw.Font.helvetica());
  static PfFont times = PfFont('Times', pw.Font.times());
  static PfFont zapfDingbats = PfFont('ZapfDingbats', pw.Font.zapfDingbats());
  static PfFont symbol = PfFont('Symbol', pw.Font.symbol());

  final String flFont;
  final pw.Font pwFont;

  String toFl() {
    return flFont;
  }

  pw.Font toPw() {
    return pwFont;
  }
}