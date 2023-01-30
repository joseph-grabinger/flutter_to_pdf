import 'package:get/get.dart';

class InvoiceItem {
  final RxString description;
  final RxInt quantity;
  final RxString unit;
  final RxInt price;

  const InvoiceItem({
    required this.description,
    required this.quantity,
    required this.unit,
    required this.price,
  });

  int get totalPrice => quantity.value * price.value;
}