import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ethio_calend/services/currency_api_client.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({Key? key}) : super(key: key);

  @override
  _CurrencyConverterScreenState createState() => _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  double _result = 0.0;

  final String apiKey = 'CHjXAlPvmCyAwA3DYdVHRhuq3bxPVDpXWyp49QQq';

  CurrencyAPI currencyAPI = CurrencyAPI(
    apiKey: 'CHjXAlPvmCyAwA3DYdVHRhuq3bxPVDpXWyp49QQq',
    baseCurrency: 'USD',
  );
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _convertCurrency() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  value: controller.value,
                  semanticsLabel: 'Circular progress indicator',
                  color: HexColor('#093A3E'),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Converting... To $_toCurrency',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          );
        },
      );

      await Future.delayed(Duration(seconds: 1)); // Wait for 3 seconds

      final double amount = double.parse(_amountController.text);

      if (_toCurrency == 'ETB') {
        // Conversion to Ethiopian Birr (ETB)
        final double convertedAmount = amount * 54.35;
        setState(() {
          _result = convertedAmount;
        });
        Navigator.pop(context); // Close the progress dialog
      } else {
        // Conversion using API
        currencyAPI
            .convertCurrency(_fromCurrency, _toCurrency, amount)
            .then((value) {
          setState(() {
            _result = value;
          });
          Navigator.pop(context); // Close the progress dialog
        }).catchError((error) {
          setState(() {
            _result = 0.0;
          });
          Navigator.pop(context); // Close the progress dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Conversion Error'),
                content: Text('Failed to convert currency: $error'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        backgroundColor: HexColor('#093A3E'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _fromCurrency,
                      onChanged: (String? newValue) {
                        setState(() {
                          _fromCurrency = newValue!;
                        });
                      },
                      items: <String>[
                        'USD',
                        'EUR',
                        'GBP',
                        // Add more currencies as needed
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                        labelText: 'From Currency',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _toCurrency,
                      onChanged: (String? newValue) {
                        setState(() {
                          _toCurrency = newValue!;
                        });
                      },
                      items: <String>[
                        'USD',
                        'EUR',
                        'GBP',
                        'ETB', // Add Ethiopian Birr (ETB)
                        // Add more currencies as needed
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                        labelText: 'To Currency',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _convertCurrency,
                child: Text('Convert'),
                style: ElevatedButton.styleFrom(
                  primary: HexColor('#093A3E'),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Result: $_result $_toCurrency',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}