import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'parameters/customer/customer.dart';
import 'parameters/invoice/invoice.dart';
import 'parameters/invoice/invoice_item.dart';
import 'parameters/own_profile/own_profile.dart';

class InvoiceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvoiceController>(() => InvoiceController());
  }
}

class InvoiceController extends GetxController {
  final GlobalKey genKey = GlobalKey();

  final ownProfile = OwnProfile(
    name: 'Dunef UG (haftungsbeschränkt)'.obs,
    street: 'Am Birkenhügel 19'.obs,
    city: 'Stahnsdorf'.obs,
    zip: '14532'.obs,
    country: 'Deutschland'.obs,
    phone: '+49 171 8867539'.obs,
    email: 'angebot@dunef.com'.obs,
    website: 'www.dunef.com'.obs,
    bank: 'Fidor Bank AG'.obs,
    iban: 'DE56 7002 2200 0020 4466 41'.obs,
    bic: 'FDDODEMMXXX'.obs,
    blz: '700 222 00'.obs,
    kto: '020 4466 4'.obs,
    taxNumber: '046/107/13152'.obs,
    vat: 'DE324944245'.obs,
    logoURL: 'assets/branding/logo.png'.obs,
  );

  final customer = Customer(
    id: 60003.obs,
    name: ''.obs,
    company: 'Kessler & Co.GmbH & Co.KG'.obs,
    street: 'Hüttlingerstr. 18-20'.obs,
    zip: '73453'.obs,
    city: 'Abtsgmünd'.obs,
    country: 'Deutschland'.obs,
  );

  final invoice = Invoice(
    id: '12200132'.obs,
    date: DateTime.now().obs,
    paymentTime: 30.obs,
    orderNumber: ''.obs,
    items: [
      InvoiceItem(
        description:
'''Nick Westendorf
- Rapport-Nr. 11943 vom 04.07.2022'''.obs,
        quantity: 17.obs,
        unit: 'Std.'.obs,
        price: 3500.obs,
      ),
    ].obs,
    taxRate: 19.obs,

    hintText: '''Bitte überweisen Sie bis zum {{dueDate}} den Rechnungsbetrag unter Angabe der Rechnungsnummer {{id}} auf das unten stehende Konto. Wir danken Ihnen für Ihr Vertrauen und freuen uns auf eine weiterhin gute Zusammenarbeit.'''.obs,
    regards: '''Mit freundlichen Grüßen,
Ihr Dunef-Team'''.obs,
    additionalText: ''.obs,
  );
}