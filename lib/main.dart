import 'package:flutter/material.dart';
import 'package:barcode_reader/barcode/barcode_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barcode Reader',
      initialRoute: BarcodeScreen.route,
      routes: {
        BarcodeScreen.route: (context) => const BarcodeScreen(),
      },
    );
  }
}
