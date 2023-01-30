import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/global/widgets/own_icon_button.dart';
import 'invoice_item.dart';
import 'invoice.dart';

class EditInvoiceDialog extends StatelessWidget {
  final Invoice invoice;

  EditInvoiceDialog(this.invoice, {Key? key}) : super(key: key);

  final dateFormat = DateFormat('dd.MM.yyyy');

  late final editID = TextEditingController(text: invoice.id.value);
  late final editDate = TextEditingController(text: dateFormat.format(invoice.date.value));
  late final editPaymentTime = TextEditingController(text: invoice.paymentTime.value.toString());
  late final editOrderNumber = TextEditingController(text: invoice.orderNumber.value);
  late final editTaxRate = TextEditingController(text: invoice.taxRate.value.toString());

  late final RxList<List<TextEditingController>> editItems = invoice.items.map((item) => [
    TextEditingController(text: item.description.value),
    TextEditingController(text: item.quantity.value.toString()),
    TextEditingController(text: item.unit.value),
    TextEditingController(text: item.price.value.toString()),
  ]).toList().obs;

  late final editHintText = TextEditingController(text: invoice.hintText.value);
  late final editRegards = TextEditingController(text: invoice.regards.value);
  late final editAdditionalText = TextEditingController(text: invoice.additionalText.value);

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
              const Text('Rechnungsdaten bearbeiten'),
              const SizedBox(height: 12),
              TextField(
                controller: editID,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nummer',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: editDate,
                onTap: () => pickDate(context, editDate),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Datum',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: editPaymentTime,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Zahlfrist in Tagen',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: editOrderNumber,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Bestellnummer',
                ),
              ),
              const SizedBox(height: 24),
              const Text('Rechnungspositionen', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Obx(() => Column(
                children: [
                  for (final editItem in editItems)
                    Column(
                      children: [
                        TextField(
                          controller: editItem[0],
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          style: const TextStyle(fontSize: 12.0),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Leistung / Artikel',
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: editItem[1],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Menge',
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: editItem[2],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Mengeneinheit',
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: editItem[3],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Einzelpreis in Cents',
                          ),
                        ),
                        const SizedBox(height: 4),
                        OwnIconButton(
                          icon: Icons.delete,
                          onTap: () {
                            editItems.remove(editItem);
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  Row(mainAxisSize: MainAxisSize.min, children: [
                    OwnIconButton(
                      icon: Icons.add,
                      onTap: () {
                        editItems.add([
                          TextEditingController(text: ''), // Leistung / Artikel
                          TextEditingController(text: '1'), // Menge
                          TextEditingController(text: 'Std.'), // Mengeneinheit
                          TextEditingController(text: '0'), // Einzelpreis in Cents
                        ]);
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text('Rechnungsposition hinzufügen', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600)),
                  ],),
                ],
              )),
              const SizedBox(height: 30),
              TextField(
                controller: editTaxRate,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Betrag MwSt. in %',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: editHintText,
                maxLines: 4,
                style: const TextStyle(fontSize: 12.0),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Hinweistext',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: editRegards,
                minLines: 2,
                maxLines: 4,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Grüße',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: editAdditionalText,
                maxLines: 2,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Zusatztext',
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

  void pickDate(BuildContext context, TextEditingController editDate) async {
    DateTime initialDate = DateTime.now();
    try {
      initialDate = dateFormat.parse(editDate.text);
    } catch (_) {}

    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(2019),
        lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      editDate.text = dateFormat.format(pickedDate);
    }
  }

  void save(BuildContext context) {
    invoice.id.value = editID.text;
    invoice.date.value = dateFormat.parse(editDate.text);
    invoice.paymentTime.value = int.parse(editPaymentTime.text);
    invoice.orderNumber.value = editOrderNumber.text;

    invoice.items.value = editItems.map((editItem) => InvoiceItem(
      description: editItem[0].text.obs,
      quantity: int.parse(editItem[1].text).obs,
      unit: editItem[2].text.obs,
      price: int.parse(editItem[3].text).obs,
    )).toList();

    invoice.taxRate.value = int.parse(editTaxRate.text);
    invoice.hintText.value = editHintText.text;
    invoice.regards.value = editRegards.text;
    invoice.additionalText.value = editAdditionalText.text;

    Navigator.of(context).pop();
  }
}

