import 'package:get/get.dart';

class OwnProfile {
  final RxString name;
  final RxString street;
  final RxString city;
  final RxString zip;
  final RxString country;
  final RxString phone;
  final RxString email;
  final RxString website;
  final RxString bank;
  final RxString iban;
  final RxString bic;
  final RxString blz;
  final RxString kto;
  final RxString taxNumber;
  final RxString vat;
  final RxString logoURL;

  const OwnProfile({
    required this.name,
    required this.street,
    required this.city,
    required this.zip,
    required this.country,
    required this.phone,
    required this.email,
    required this.website,
    required this.bank,
    required this.iban,
    required this.bic,
    required this.blz,
    required this.kto,
    required this.taxNumber,
    required this.vat,
    required this.logoURL,
  });
}