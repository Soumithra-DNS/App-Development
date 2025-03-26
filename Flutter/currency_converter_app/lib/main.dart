import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:currency_converter_app/currency_converter_material_page.dart';
import 'package:currency_converter_app/currency_converter_cupertino_page.dart';

void main() {
  runApp(const MyCupertinoApp()); // Use either MyApp or MyCupertinoApp
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CurrencyConverterMaterialPage(),
    );
  }
}

class MyCupertinoApp extends StatelessWidget {
  const MyCupertinoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: CurrencyConverterCupertinoPage(),
    );
  }
}
