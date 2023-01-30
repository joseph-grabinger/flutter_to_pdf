import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:teaplates/global/widgets/export_dialog.dart';
import 'package:teaplates/global/widgets/own_icon_button.dart';

import 'controller.dart';
import 'parameters/customer/edit_dialog.dart';
import 'parameters/invoice/edit_dialog.dart';
import 'parameters/own_profile/edit_dialog.dart';

const invoiceAspectRatio = 1 / 1.414;

const invoiceRoute = '/invoice';
class InvoicePage extends GetView<InvoiceController> {
  const InvoicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget smText(String text) => Text(
      text,
      style: const TextStyle(
        fontSize: 6,
      )
    );

    Widget infoText(String text) => Text(
      text,
      style: const TextStyle(
        fontSize: 6,
        color: Color(0xff999999)
      )
    );


    Widget descText(String text) => Text(
      text,
      style: const TextStyle(
        fontSize: 5,
        color: Color(0xff333333),
        fontWeight: FontWeight.w500,
        height: 1.4,
      )
    );

    var quantityFormat = NumberFormat();

    quantityFormat.minimumFractionDigits = 0;
    quantityFormat.maximumFractionDigits = 1;
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomSheet: Container(
        height: 120,
        width: double.infinity,
        padding: const EdgeInsets.all(6.0),
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
          boxShadow: [
            BoxShadow(
              color: Color(0x33000000),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(width: 20.0),
              OwnIconButton(
                icon: Icons.download,
                size: 60.0,
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => ExportDialog(
                      controller: Get.put(ExportDialogController(
                        renderObject: controller.genKey.currentContext!.findRenderObject()!,
                        title: 'Rechnung-${controller.invoice.id}'
                      )),
                    ),
                  );
                }
              ),
              const SizedBox(width: 20.0),
              OwnIconButton(
                icon: Icons.group,
                size: 60.0,
                onTap: () => Get.dialog(EditCustomerDialog(controller.customer)),
              ),
              const SizedBox(width: 20.0),
              OwnIconButton(
                icon: Icons.receipt_long,
                size: 60.0,
                onTap: () => Get.dialog(EditInvoiceDialog(controller.invoice)),
              ),
              const SizedBox(width: 20.0),
              OwnIconButton(
                icon: Icons.badge,
                size: 60.0,
                onTap: () => Get.dialog(EditOwnProfileDialog(controller.ownProfile)),
              ),
            ],
          ),
        )
      ),
      body: Column(
        children: [
          const SizedBox(height: 50.0),
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x22000000),
                      spreadRadius: 5,
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: InteractiveViewer(
                  child: RepaintBoundary(
                    key: controller.genKey,
                    child: AspectRatio(
                      aspectRatio: invoiceAspectRatio,
                      child: Container(
                        padding: const EdgeInsets.only(top: 40.0, left: 30.0, right: 30.0, bottom: 30.0),
                        color: const Color(0xffffffff),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Obx(() => Text(
                                        controller.customer.company.value,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        )
                                      )),
                                      const SizedBox(height: 2.0),
                                      Obx(() =>
                                        controller.customer.name.isEmpty ? const SizedBox.shrink() : Text(
                                          controller.customer.name.value,
                                          style: const TextStyle(
                                            fontSize: 8,
                                          )
                                        )
                                      ),
                                      Obx(() => Text(
                                        controller.customer.street.value,
                                        style: const TextStyle(
                                          fontSize: 8,
                                        )
                                      )),
                                      Obx(() => Text(
                                        '${controller.customer.zip} ${controller.customer.city}',
                                        style: const TextStyle(
                                          fontSize: 8,
                                        )
                                      )),
                                      Obx(() => Text(
                                        controller.customer.country.value,
                                        style: const TextStyle(
                                          fontSize: 8,
                                        )
                                      )),
                                      const SizedBox(height: 3.0,),
                                      const Text(
                                        'Ihre Kundennummer',
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: Color(0xff888888),
                                          fontWeight: FontWeight.w500,
                                        )
                                      ),
                                      Obx(() => Text(
                                        controller.customer.id.toString(),
                                        style: const TextStyle(
                                          fontSize: 8,
                                        )
                                      )),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 26),
                                Column(
                                  children: [
                                    SizedBox(
                                      width: 70,
                                      child: Image.asset('assets/branding/logo.png'),
                                    ),     
                                  ]
                                ),
                              ],
                            ),
                            const SizedBox(height: 26),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Rechnung',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6.0),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Nummer',
                                            style: TextStyle(
                                              fontSize: 8,
                                              color: Color(0xff555555),
                                            ),
                                          ),
                                          const SizedBox(height: 1.0),
                                          Obx(() => Text(
                                            controller.invoice.id.value,
                                            style: const TextStyle(
                                              fontSize: 7,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )),
                                        ]
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Datum',
                                            style: TextStyle(
                                              fontSize: 8,
                                              color: Color(0xff555555),
                                            ),
                                          ),
                                          const SizedBox(height: 1.0),
                                          Obx(() => Text(
                                            DateFormat('dd.MM.yyyy').format(controller.invoice.date.value),
                                            style: const TextStyle(
                                              fontSize: 7,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )),
                                        ]
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Fälligkeitsdatum',
                                            style: TextStyle(
                                              fontSize: 8,
                                              color: Color(0xff555555),
                                            ),
                                          ),
                                          const SizedBox(height: 1.0),
                                          Obx(() => Text(
                                            DateFormat('dd.MM.yyyy').format(controller.invoice.date.value.add(Duration(days: controller.invoice.paymentTime.value))),
                                            style: const TextStyle(
                                              fontSize: 7,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )),
                                        ]
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Obx(() =>controller.invoice.orderNumber.isEmpty ? const SizedBox()
                                      : Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Ihre Bestellnummer',
                                              style: TextStyle(
                                                fontSize: 8,
                                                color: Color(0xff555555),
                                              ),
                                            ),
                                            const SizedBox(height: 1.0),
                                            Text(
                                              controller.invoice.orderNumber.value,
                                              style: const TextStyle(
                                                fontSize: 7,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ]
                                        )
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
              
                            const SizedBox(height: 20),
              
                            // Tabelle mit Angeboten
                            Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: const [
                                    Expanded(
                                      flex: 6,
                                      child: Text(
                                        'Leistung / Artikel',
                                        style: TextStyle(
                                          fontSize: 7,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff888888),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          'Menge',
                                          style: TextStyle(
                                            fontSize: 7,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff888888),
                                          ),
                                        )
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          'Einzelpreis',
                                          style: TextStyle(
                                            fontSize: 7,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff888888),
                                          ),
                                        )
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          'Gesamtpreis',
                                          style: TextStyle(
                                            fontSize: 7,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff888888),
                                          ),
                                        )
                                      ),
                                    ),
                                  ],
                                ),
              
                                const Divider(height: 8.0, color: Color(0xffaaaaaa),),
                                
                                Obx(() => Column(
                                  children: controller.invoice.items.map((item) {
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            flex: 6,
                                            child: descText(item.description.value),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Align(
                                              alignment: Alignment.topCenter,
                                              child: smText('${quantityFormat.format(item.quantity.value).replaceAll(".", ",")} ${item.unit}'),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: smText(toMoneyString(item.price.value))
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: smText(toMoneyString(item.totalPrice))
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                )),
                              ],
                            ),
              
                            const SizedBox(height: 10),
              
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Obx(() => Text(
                                        controller.invoice.hintText
                                          .replaceAll('{{dueDate}}', DateFormat('dd.MM.yyyy').format(controller.invoice.date.value.add(Duration(days: controller.invoice.paymentTime.value))))
                                          .replaceAll('{{id}}', controller.invoice.id.value),
                                        style: const TextStyle(
                                          fontSize: 5,
                                          fontWeight: FontWeight.w400,
                                        )
                                      )),
                                      const SizedBox(height: 6,),
                                      Obx(() => Text(
                                        controller.invoice.regards.value,
                                        style: const TextStyle(
                                          fontSize: 5,
                                          fontWeight: FontWeight.w400,
                                        )
                                      )),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 40),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Divider(height: 6.0, color: Color(0xffaaaaaa),),
                                      const SizedBox(height: 2),
                                      smText('   Nettobetrag'),
                                      const SizedBox(height: 3),
                                      Obx(() => smText('+ ${controller.invoice.taxRate}% MwSt.')),
                                      const SizedBox(height: 2),
                                      const Divider(height: 6.0, color: Color(0xff444444),),
                                      smText('Rechnungsbetrag'),
                                      const Divider(height: 6.0, color: Color(0xff444444),),
                                    ]
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Divider(height: 6.0, color: Color(0xffaaaaaa),),
                                      const SizedBox(height: 2),
                                      Obx(() => smText(toMoneyString(controller.invoice.totalPrice()))),
                                      const SizedBox(height: 3),
                                      Obx(() => smText('${(controller.invoice.taxAmount()/100).toStringAsFixed(2).replaceAll('.',',')} €')),
                                      const SizedBox(height: 2),
                                      const Divider(height: 6.0, color: Color(0xff444444),),
                                      Obx(() => smText('${(controller.invoice.totalPrice() * (1+controller.invoice.taxRate/100) / 100).toStringAsFixed(2).replaceAll('.',',')} €')),
                                      const Divider(height: 6.0, color: Color(0xff444444),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
              
                            const SizedBox(height: 10),
              
                            Obx(() {
                              if (controller.invoice.additionalText.value.isNotEmpty) {
                                return Text(
                                  controller.invoice.additionalText.value,
                                  style: const TextStyle(
                                    fontSize: 6,
                                    fontWeight: FontWeight.w400,
                                  )
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            }),
              
                            const Expanded(child: SizedBox()),
              
                            Container(
                              padding: const EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                color: const Color(0xfff3f3f3),
                                border: Border.all(color: const Color(0xffdddddd)),
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xffcccccc),
                                    blurRadius: 4,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(() => Text(
                                    controller.ownProfile.name.value,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 10,
                                    )
                                  )),
                                  const SizedBox(height: 4),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        flex: 3,
                                        fit: FlexFit.tight,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Obx(() => SizedBox(height: 8, child: smText(controller.ownProfile.street.value))),
                                            Obx(() => SizedBox(height: 8, child: smText('${controller.ownProfile.zip} ${controller.ownProfile.city}'))),
                                            Obx(() => SizedBox(height: 8, child: smText(controller.ownProfile.country.value))),
                                            Obx(() => SizedBox(height: 8, child: smText(controller.ownProfile.phone.value))),
                                            Obx(() => SizedBox(height: 8, child: smText(controller.ownProfile.email.value))),
                                          ]
                                        )
                                      ),
                                      Flexible(
                                        flex: 4,
                                        fit: FlexFit.tight,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Obx(() => SizedBox(height: 8, child: smText(controller.ownProfile.bank.value))),
                                            Obx(() => SizedBox(height: 8, child: smText('IBAN ${controller.ownProfile.iban}'))),
                                            Obx(() => SizedBox(height: 8, child: smText('SWIFT ${controller.ownProfile.bic}'))),
                                            Obx(() => SizedBox(height: 8, child: smText('BLZ ${controller.ownProfile.blz}'))),
                                            Obx(() => SizedBox(height: 8, child: smText('KTO ${controller.ownProfile.kto}'))),
                                          ]
                                        )
                                      ),
                                      Flexible(
                                        flex: 2,
                                        fit: FlexFit.tight,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 8, child: infoText('USt IdNr')),
                                            Obx(() => SizedBox(height: 9, child: smText(controller.ownProfile.vat.value))),
                                            const SizedBox(height: 9),
                                            SizedBox(height: 8, child: infoText('Steuernummer')),
                                            Obx(() => SizedBox(height: 8, child: smText(controller.ownProfile.taxNumber.value))),
                                          ]
                                        )
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Transform.translate(
                offset: const Offset(10, 0),
                child: OwnIconButton(
                  icon: Icons.arrow_back,
                  onTap: Get.back,
                ),
              ),
            ],
          ),
    
        ],
      ),
    );
  }
}

String toMoneyString(int value) {
  return '${(value/100).toStringAsFixed(2).replaceAll('.',',')} €';
}