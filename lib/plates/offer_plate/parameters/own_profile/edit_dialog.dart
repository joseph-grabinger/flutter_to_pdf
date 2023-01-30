import 'package:flutter/material.dart';

import 'own_profile.dart';

class EditOwnProfileDialog extends StatelessWidget {
  final OwnProfile ownProfile;

  EditOwnProfileDialog(this.ownProfile, {Key? key}) : super(key: key);

  late final editName = TextEditingController(text: ownProfile.name.value);
  late final editStreet = TextEditingController(text: ownProfile.street.value);
  late final editZIPandCity = TextEditingController(text: '${ownProfile.zip} ${ownProfile.city}');
  late final editCountry = TextEditingController(text: ownProfile.country.value);
  late final editPhone = TextEditingController(text: ownProfile.phone.value);
  late final editEmail = TextEditingController(text: ownProfile.email.value);

  late final editBank = TextEditingController(text: ownProfile.bank.value);
  late final editIban = TextEditingController(text: ownProfile.iban.value);
  late final editBic = TextEditingController(text: ownProfile.bic.value);
  late final editBlz = TextEditingController(text: ownProfile.blz.value);
  late final editKto = TextEditingController(text: ownProfile.kto.value);

  late final editVat = TextEditingController(text: ownProfile.vat.value);
  late final editTaxNumber = TextEditingController(text: ownProfile.taxNumber.value);

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
              const Text('Eigene Profildaten bearbeiten'),
              const SizedBox(height: 12),
              TextField(
                controller: editName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
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
              TextField(
                controller: editPhone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Telefonnummer',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: editEmail,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: editBank,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Bank',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: editIban,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'IBAN',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: editBic,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'BIC',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: editBlz,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'BLZ',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: editKto,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'KTO',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: editVat,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'USt-IdNr.',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: editTaxNumber,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Steuernummer',
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

    ownProfile.name.value = editName.text;
    ownProfile.street.value = editStreet.text;
    ownProfile.zip.value = zipAndCity[0];
    ownProfile.city.value = zipAndCity[1];
    ownProfile.country.value = editCountry.text;
    ownProfile.phone.value = editPhone.text;
    ownProfile.email.value = editEmail.text;
    ownProfile.bank.value = editBank.text;
    ownProfile.iban.value = editIban.text;
    ownProfile.bic.value = editBic.text;
    ownProfile.blz.value = editBlz.text;
    ownProfile.kto.value = editKto.text;
    ownProfile.vat.value = editVat.text;
    ownProfile.taxNumber.value = editTaxNumber.text;

    Navigator.of(context).pop();
  }
}