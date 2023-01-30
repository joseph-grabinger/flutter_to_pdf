import 'package:flutter/material.dart';

import 'customer.dart';

class EditCustomerDialog extends StatelessWidget {
  final Customer customer;

  EditCustomerDialog(this.customer, {Key? key}) : super(key: key);

  late final editCompany = TextEditingController(text: customer.company.value);
  late final editID = TextEditingController(text: customer.id.value.toString());
  late final editStreet = TextEditingController(text: customer.street.value);
  late final editZIPandCity = TextEditingController(text: '${customer.zip} ${customer.city}');
  late final editCountry = TextEditingController(text: customer.country.value);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Kundendaten bearbeiten'),
              const SizedBox(height: 12),
              TextField(
                controller: editCompany,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Unternehmen',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: editID,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Kundennummer',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: editStreet,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Straße und Hausnummer',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: editZIPandCity,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'PLZ und Ort',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: editCountry,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Land',
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xffeebbbb),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text('Abbrechen', style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0,),
                  Expanded(
                    child: InkWell(
                      onTap: () => save(context),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xfff0f8ff),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x55000000),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        child: const Text('Speichern', style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void save(BuildContext context) {
    final zipAndCity = editZIPandCity.text.split(' ');

    customer.company.value = editCompany.text;
    customer.id.value = int.parse(editID.text);
    customer.street.value = editStreet.text;
    customer.zip.value = zipAndCity[0];
    customer.city.value = zipAndCity[1];
    customer.country.value = editCountry.text;

    Navigator.of(context).pop();
  }
}