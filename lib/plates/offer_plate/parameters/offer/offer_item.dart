import 'package:get/get.dart';

class OfferItem {
  final RxString description;
  final RxInt quantity;
  final RxString unit;
  final RxInt price;

  const OfferItem({
    required this.description,
    required this.quantity,
    required this.unit,
    required this.price,
  });

  int get totalPrice => quantity.value * price.value;
}