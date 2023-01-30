import 'package:get/get.dart';

import 'offer_item.dart';

class Offer {
  final RxString id;
  final Rx<DateTime> date;
  final RxInt paymentTime;
  final RxString orderNumber;
  final RxList<OfferItem> items;
  final RxInt taxRate;

  final RxString hintText;
  final RxString regards;
  final RxString additionalText;

  const Offer({
    required this.id,
    required this.date,
    required this.paymentTime,
    required this.orderNumber,
    required this.items,
    required this.taxRate,

    required this.hintText,
    required this.regards,
    required this.additionalText,
  });

  int totalPrice() {
    return items.fold(0, (sum, item) => sum + item.totalPrice);
  }

  double taxAmount() {
    return totalPrice() * taxRate.value / 100;
  }
}