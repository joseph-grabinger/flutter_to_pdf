



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdfx/pdfx.dart';
import 'package:teaplates/pf/page.dart';
import 'package:teaplates/pf/pf_widget.dart';

import 'controller.dart';

const staffTimeRecordingRoute = '/staffTimeRecording';
class StaffTimeRecordingPage extends GetView<StaffTimeRecordingController> {
  const StaffTimeRecordingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PfText smText(String text) => PfText(
      text,
      style: PfTextStyle(
        fontSize: 6,
      )
    );

    PfText infoText(String text) => PfText(
      text,
      style: PfTextStyle(
        color: const PfColor(0xff999999),
        fontSize: 6,
      )
    );


    PfText descText(String text) => PfText(
      text,
      style: PfTextStyle(
        fontSize: 5,
        color: const PfColor(0xff333333),
        height: 1.4,
      )
    );

    var quantityFormat = NumberFormat();

    quantityFormat.minimumFractionDigits = 0;
    quantityFormat.maximumFractionDigits = 1;


    controller.pfPage = PfPage(
      child: PfColumn(
        crossAxisAlignment: PfCrossAxisAlignment.start,
        mainAxisSize: PfMainAxisSize.max,
        children: [
          PfRow(
            children: [
              PfExpanded(
                child: PfColumn(
                  crossAxisAlignment: PfCrossAxisAlignment.start,
                  children: [
                    PfText(
                      'Kessler & Co. GmbH',
                      style: PfTextStyle(
                        fontSize: 11,
                        fontWeight: PfFontWeight.bold,
                      )
                    ),
                    const PfSizedBox(height: 2.0),
                    PfText(
                      'Hauptstraße 1',
                      style: PfTextStyle(
                        fontSize: 8,
                      )
                    ),
                    PfText(
                      '12345 Musterstadt',
                      style: PfTextStyle(
                        fontSize: 8,
                      )
                    ),
                    PfText(
                      'Deutschland',
                      style: PfTextStyle(
                        fontSize: 8,
                      )
                    ),
                    const PfSizedBox(height: 3.0,),
                    PfText(
                      'Ihre Kundennummer',
                      style: PfTextStyle(
                        fontSize: 8,
                        color: const PfColor(0xff888888),
                      )
                    ),
                    PfText(
                      '60003',
                      style: PfTextStyle(
                        fontSize: 8,
                      )
                    ),
                  ],
                ),
              ),
              const PfSizedBox(width: 26),
              PfColumn(
                children: [
                  PfSizedBox(
                    width: 70,
                    // child: Image.asset('assets/branding/logo.png'),
                  ),     
                ]
              ),
            ],
          ),
          const PfSizedBox(height: 26),
          PfColumn(
            crossAxisAlignment: PfCrossAxisAlignment.start,
            mainAxisSize: PfMainAxisSize.min,
            children: [
              PfText(
                'Rechnung',
                style: PfTextStyle(
                  fontSize: 11,
                  fontWeight: PfFontWeight.bold,
                ),
              ),
              const PfSizedBox(height: 6.0),
              PfRow(
                children: [
                  PfExpanded(
                    flex: 1,
                    child: PfColumn(
                      crossAxisAlignment: PfCrossAxisAlignment.start,
                      children: [
                        PfText(
                          'Nummer',
                          style: PfTextStyle(
                            fontSize: 8,
                            color: const PfColor(0xff555555),
                          ),
                        ),
                        const PfSizedBox(height: 1.0),
                        PfText(
                          '122000043',
                          style: PfTextStyle(
                            fontSize: 7,
                          ),
                        ),
                      ]
                    ),
                  ),
                  PfExpanded(
                    flex: 1,
                    child: PfColumn(
                      crossAxisAlignment: PfCrossAxisAlignment.start,
                      children: [
                        PfText(
                          'Datum',
                          style: PfTextStyle(
                            fontSize: 8,
                            color: const PfColor(0xff555555),
                          ),
                        ),
                        const PfSizedBox(height: 1.0),
                        PfText(
                          '22.10.2022',
                          style: PfTextStyle(
                            fontSize: 7,
                          ),
                        ),
                      ]
                    ),
                  ),
                  PfExpanded(
                    flex: 1,
                    child: PfColumn(
                      crossAxisAlignment: PfCrossAxisAlignment.start,
                      children: [
                        PfText(
                          'Fälligkeitsdatum',
                          style: PfTextStyle(
                            fontSize: 8,
                            color: const PfColor(0xff555555),
                          ),
                        ),
                        const PfSizedBox(height: 1.0),
                        PfText(
                          '01.11.2022',
                          style: PfTextStyle(
                            fontSize: 7,
                          ),
                        ),
                      ]
                    ),
                  ),
                  PfExpanded(
                    flex: 1,
                    child: PfColumn(
                      crossAxisAlignment: PfCrossAxisAlignment.start,
                      children: [
                        PfText(
                          'Ihre Bestellnummer',
                          style: PfTextStyle(
                            fontSize: 8,
                            color: const PfColor(0xff555555),
                          ),
                        ),
                        const PfSizedBox(height: 1.0),
                        PfText(
                          'adf 123',
                          style: PfTextStyle(
                            fontSize: 7,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          const PfSizedBox(height: 20),

          // Tabelle mit Angeboten
          PfColumn(
            children: [
              PfRow(
                mainAxisSize: PfMainAxisSize.max,
                children: [
                  PfExpanded(
                    flex: 6,
                    child: PfText(
                      'Leistung / Artikel',
                      style: PfTextStyle(
                        fontSize: 7,
                        fontWeight: PfFontWeight.bold,
                        color: const PfColor(0xff888888),
                      ),
                    ),
                  ),
                  PfExpanded(
                    flex: 1,
                    child: PfAlign(
                      alignment: PfAlignment.topCenter,
                      child: PfText(
                        'Menge',
                        style: PfTextStyle(
                          fontSize: 7,
                          fontWeight: PfFontWeight.bold,
                          color: const PfColor(0xff888888),
                        ),
                      )
                    ),
                  ),
                  PfExpanded(
                    flex: 2,
                    child: PfAlign(
                      alignment: PfAlignment.topRight,
                      child: PfText(
                        'Einzelpreis',
                        style: PfTextStyle(
                          fontSize: 7,
                          fontWeight: PfFontWeight.bold,
                          color: const PfColor(0xff888888),
                        ),
                      )
                    ),
                  ),
                  PfExpanded(
                    flex: 2,
                    child: PfAlign(
                      alignment: PfAlignment.topRight,
                      child: PfText(
                        'Gesamtpreis',
                        style: PfTextStyle(
                          fontSize: 7,
                          fontWeight: PfFontWeight.bold,
                          color: const PfColor(0xff888888),
                        ),
                      )
                    ),
                  ),
                ],
              ),

              const PfDivider(height: 8.0, color: PfColor(0xffaaaaaa)),
              
              PfColumn(
                children: [
                  {
                    'description': 'Leistung 1',
                    'quantity': 1,
                    'unit': 'Std.',
                    'price': 10000,
                  },
                  {
                    'description': 'Leistung 2',
                    'quantity': 2,
                    'unit': 'Std.',
                    'price': 20000,
                  },
                  {
                    'description': 'Leistung 3',
                    'quantity': 3,
                    'unit': 'Std.',
                    'price': 30000,
                  },
                ].map((item) {
                  return PfPadding(
                    padding: const PfEdgeInsets.only(bottom: 8),
                    child: PfRow(
                      crossAxisAlignment: PfCrossAxisAlignment.start,
                      mainAxisSize: PfMainAxisSize.max,
                      children: [
                        PfExpanded(
                          flex: 6,
                          child: descText(item['description'].toString()),
                        ),
                        PfExpanded(
                          flex: 1,
                          child: PfAlign(
                            alignment: PfAlignment.topCenter,
                            child: smText('blaba'),
                          ),
                        ),
                        PfExpanded(
                          flex: 2,
                          child: PfAlign(
                            alignment: PfAlignment.topRight,
                            child: smText(toMoneyString(item['price'] as int))
                          ),
                        ),
                        PfExpanded(
                          flex: 2,
                          child: PfAlign(
                            alignment: PfAlignment.topRight,
                            child: smText(toMoneyString((item['price'] as int) * (item['quantity'] as int)))
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          const PfSizedBox(height: 10),

          PfRow(
            children: [
              PfExpanded(
                flex: 3,
                child: PfColumn(
                  crossAxisAlignment: PfCrossAxisAlignment.start,
                  children: [
                    PfText(
                      'Bitte überweisen Sie den Betrag auf folgendes Konto:',
                        //.replaceAll('{{dueDate}}', DateFormat('dd.MM.yyyy').format(controller.invoice.date.value.add(Duration(days: controller.invoice.paymentTime.value))))
                        //.replaceAll('{{id}}', controller.invoice.id.value),
                      style: PfTextStyle(
                        fontSize: 5,
                      )
                    ),
                    const PfSizedBox(height: 6,),
                    PfText(
                      'Mit freundlichen Grüßen',
                      style: PfTextStyle(
                        fontSize: 5,
                      )
                    ),
                  ],
                ),
              ),
              const PfSizedBox(width: 40),
              PfExpanded(
                flex: 1,
                child: PfColumn(
                  crossAxisAlignment: PfCrossAxisAlignment.start,
                  children: [
                    const PfDivider(height: 6.0, color: PfColor(0xffaaaaaa),),
                    const PfSizedBox(height: 2),
                    smText('   Nettobetrag'),
                    const PfSizedBox(height: 3),
                    smText('+ 19% MwSt.'),
                    const PfSizedBox(height: 2),
                    const PfDivider(height: 6.0, color: PfColor(0xff444444),),
                    smText('Rechnungsbetrag'),
                    const PfDivider(height: 6.0, color: PfColor(0xff444444),),
                  ]
                ),
              ),
              PfExpanded(
                flex: 1,
                child: PfColumn(
                  crossAxisAlignment: PfCrossAxisAlignment.end,
                  children: [
                    const PfDivider(height: 6.0, color: PfColor(0xffaaaaaa),),
                    const PfSizedBox(height: 2),
                    smText(toMoneyString(50000)),
                    const PfSizedBox(height: 3),
                    smText('${(50000/(100*19)).toStringAsFixed(2).replaceAll('.',',')} EUR'),
                    const PfSizedBox(height: 2),
                    const PfDivider(height: 6.0, color: PfColor(0xff444444),),
                    smText('${(400).toStringAsFixed(2).replaceAll('.',',')} EUR'),
                    const PfDivider(height: 6.0, color: PfColor(0xff444444),),
                  ],
                ),
              ),
            ],
          ),

          const PfSizedBox(height: 10),

          PfText(
            'Zusatztext',
            style: PfTextStyle(
              fontSize: 6,
            )
          ),

          const PfExpanded(child: PfSizedBox()),

          PfContainer(
            padding: const PfEdgeInsets.all(6.0),
            decoration: PfBoxDecoration(
              color: const PfColor(0xfff3f3f3),
              border: PfBorder.all(color: const PfColor(0xffdddddd)),
              borderRadius: PfBorderRadius.circular(6),
              boxShadow: const [
                PfBoxShadow(
                  color: PfColor(0xffaaaaaa),
                  blurRadius: 10.0,
                  spreadRadius: 10.0,
                  offset: PfPoint(0, 0),
                ),
              ],
            ),
            child: PfColumn(
              crossAxisAlignment: PfCrossAxisAlignment.start,
              children: [
                PfText(
                  'Dunef GmbH',
                  style: PfTextStyle(
                    fontWeight: PfFontWeight.bold,
                    fontSize: 10,
                  )
                ),
                const PfSizedBox(height: 4),
                PfRow(
                  crossAxisAlignment: PfCrossAxisAlignment.start,
                  children: [
                    PfFlexible(
                      flex: 3,
                      fit: PfFlexFit.tight,
                      child: PfColumn(
                        crossAxisAlignment: PfCrossAxisAlignment.start,
                        children: [
                          PfSizedBox(height: 8, child: smText('Am Sand 1')),
                          PfSizedBox(height: 8, child: smText('12345 Musterstadt')),
                          PfSizedBox(height: 8, child: smText('Deutschland')),
                          PfSizedBox(height: 8, child: smText('+49 123 4567890')),
                          PfSizedBox(height: 8, child: smText('rechnung@dunef.com')),
                        ]
                      )
                    ),
                    PfFlexible(
                      flex: 4,
                      fit: PfFlexFit.tight,
                      child: PfColumn(
                        crossAxisAlignment: PfCrossAxisAlignment.start,
                        children: [
                          PfSizedBox(height: 8, child: smText('Fidor Bank AG')),
                          PfSizedBox(height: 8, child: smText('IBAN aaa')),
                          PfSizedBox(height: 8, child: smText('SWIFT aaa')),
                          PfSizedBox(height: 8, child: smText('BLZ aaa')),
                          PfSizedBox(height: 8, child: smText('KTO aaa')),
                        ]
                      )
                    ),
                    PfFlexible(
                      flex: 2,
                      fit: PfFlexFit.tight,
                      child: PfColumn(
                        crossAxisAlignment: PfCrossAxisAlignment.start,
                        children: [
                          PfSizedBox(height: 8, child: infoText('USt IdNr')),
                          PfSizedBox(height: 9, child: smText('aaa')),
                          const PfSizedBox(height: 9),
                          PfSizedBox(height: 8, child: infoText('Steuernummer')),
                          PfSizedBox(height: 8, child: smText('aaa')),
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
    );

    controller.createPdf(controller.pfPage);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.createPdf(controller.pfPage);
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: controller.pfPage,
          ),
          const Divider(),
          Expanded(
            child: PdfViewPinch(
              controller: controller.pdfControllerPinch,
            ),
          ),
        ],
      ),
    );
  }
}


String toMoneyString(int value) {
  return '${(value/100).toStringAsFixed(2).replaceAll('.',',')} EUR';
}