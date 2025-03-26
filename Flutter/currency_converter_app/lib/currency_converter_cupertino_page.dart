import 'package:flutter/cupertino.dart';

class CurrencyConverterCupertinoPage extends StatefulWidget {
  const CurrencyConverterCupertinoPage({super.key});

  @override
  State<CurrencyConverterCupertinoPage> createState() =>
      _CurrencyConverterCupertinoPage();
}

class _CurrencyConverterCupertinoPage
    extends State<CurrencyConverterCupertinoPage> {
  final TextEditingController textEditingController = TextEditingController();
  double result = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color.fromARGB(255, 28, 35, 42),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: const Color.fromARGB(255, 37, 47, 61),
        middle: const Text(
          'Currency Converter(USD to BDT)',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  result.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                const SizedBox(height: 20),
                CupertinoTextField(
                  controller: textEditingController,
                  placeholder: 'Please enter the amount in USD',
                  placeholderStyle: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 50, 60, 75),
                    border: Border.all(
                      color: const Color.fromARGB(255, 105, 118, 139),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefix: const Icon(
                    CupertinoIcons.money_dollar_circle_fill,
                    color: Color.fromARGB(255, 0, 174, 255),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
                const SizedBox(height: 20),
                CupertinoButton(
                  onPressed: () {
                    double? usdAmount = double.tryParse(
                      textEditingController.text,
                    );
                    if (usdAmount != null) {
                      setState(() {
                        result = usdAmount * 120;
                      });
                    }
                  },
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: const Color.fromARGB(255, 56, 142, 255),
                  child: const Text(
                    'Convert',
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
