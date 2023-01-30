import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home/controller.dart';
import 'home/page.dart';
import 'plates/offer_plate/controller.dart';
import 'plates/offer_plate/page.dart';
import 'plates/invoice_plate/controller.dart';
import 'plates/invoice_plate/page.dart';
import 'plates/business_card_plate/page.dart';
import 'plates/business_card_plate/controller.dart';
import 'plates/staff_time_recording_plate/page.dart';
import 'plates/staff_time_recording_plate/controller.dart';


void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GetMaterialApp(
    title: 'Teaplates',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: const Color(0xffffffff),
      primaryColor: const Color.fromRGBO(77, 30, 117, 1),
      primaryColorDark: const Color.fromRGBO(47, 35, 64, 1),
      textTheme: TextTheme(
        // used for page titles
        displayLarge: GoogleFonts.lato(
          fontSize: 32.0,
          fontWeight: FontWeight.w700,
          color: const Color(0xff222222),
        ),
        // used for dialog titles
        displayMedium: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
    initialRoute: homeRoute,
    getPages: [
      GetPage(
        name: homeRoute,
        page: () => const HomePage(),
        binding: HomeBinding(),
      ),
      GetPage(
        name: staffTimeRecordingRoute,
        page: () => const StaffTimeRecordingPage(),
        binding: StaffTimeRecordingBinding(),
      ),
      GetPage(
        name: invoiceRoute,
        page: () => const InvoicePage(),
        binding: InvoiceBinding(),
      ),
      GetPage(
        name: offerRoute,
        page: () => const OfferPage(),
        binding: OfferBinding(),
      ),
      GetPage(
        name: businessCardRoute,
        page: () => const BusinessCardPage(),
        //binding: BusinessCardBinding(),
      ),
    ],
  );
}