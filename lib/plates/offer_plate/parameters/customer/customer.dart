
import 'package:get/get.dart';

class Customer {
  final RxInt id;
  final RxString company;
  final RxString name;
  final RxString street;
  final RxString zip;
  final RxString city;
  final RxString country;

  const Customer({
    required this.id,
    required this.company,
    required this.name,
    required this.street,
    required this.zip,
    required this.city,
    required this.country,
  });
}