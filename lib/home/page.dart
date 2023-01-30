import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teaplates/plates/business_card_plate/page.dart';
import 'package:teaplates/plates/invoice_plate/page.dart';
import 'package:teaplates/plates/offer_plate/page.dart';
import 'package:teaplates/plates/staff_time_recording_plate/page.dart';

import 'widgets/tearow/tearow.dart';
import 'widgets/tearow/tearow_item.dart';

import 'controller.dart';

const homeRoute = '/home';
class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Teaplates'),
    ),
    body: ListView(
      children: [
        TeaRow(
          title: 'Staff Time Recording',
          height: 250.0,
          aspectRatio: invoiceAspectRatio,
          items: [
            TeaRowItem(
              imageURL: 'assets/teaplates/invoices/invoice1.png',
              onTap: () => Get.toNamed(staffTimeRecordingRoute),
            ),
            TeaRowItem(
              imageURL: 'assets/teaplates/invoices/invoice2.jpeg',
              onTap: () => Get.toNamed(staffTimeRecordingRoute),
            ),
          ],
        ),
        TeaRow(
          title: 'Invoices',
          height: 250.0,
          aspectRatio: invoiceAspectRatio,
          items: [
            TeaRowItem(
              imageURL: 'assets/teaplates/invoices/invoice1.png',
              onTap: () => Get.toNamed(invoiceRoute),
            ),
            TeaRowItem(
              imageURL: 'assets/teaplates/invoices/invoice2.jpeg',
              onTap: () => Get.toNamed(invoiceRoute),
            ),
          ],
        ),
        TeaRow(
          title: 'Offers',
          height: 250.0,
          aspectRatio: offerAspectRatio,
          items: [
            TeaRowItem(
              imageURL: 'assets/teaplates/offers/offer1.png',
              onTap: () => Get.toNamed(offerRoute),
            ),
            TeaRowItem(
              imageURL: 'assets/teaplates/offers/offer2.jpeg',
              onTap: () => Get.toNamed(offerRoute),
            ),
          ],
        ),
        TeaRow(
          title: 'Business Cards',
          height: 150.0,
          aspectRatio: 3.5 / 2.0,
          items: [
            TeaRowItem(
              imageURL: 'assets/teaplates/business_cards/business_card1.jpeg',
              onTap: () => Get.toNamed(businessCardRoute),
            ),
            TeaRowItem(
              imageURL: 'assets/teaplates/business_cards/business_card2.jpeg',
              onTap: () => Get.toNamed(businessCardRoute),
            ),
          ],
        ),
      ],
    ),
  );
}