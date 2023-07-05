import 'package:ethio_calend/model/currency_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyAPI {
  final String apiKey;
  final String baseCurrency;
  final List<String> currencies;

  CurrencyAPI({
    required this.apiKey,
    this.baseCurrency = 'USD',
    this.currencies = const [],
  });

  Future<Map<String, double>> getCurrencyRates() async {
    final apiUrl =
        'https://api.freecurrencyapi.com/v1/latest?apikey=$apiKey&base_currency=$baseCurrency&currencies=${currencies.join(",")}';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final rates = data['data'] as Map<String, dynamic>;

      return rates.map((key, value) => MapEntry(key, value.toDouble()));
    } else {
      throw Exception('Failed to fetch currency rates');
    }
  }

  Future<double> convertCurrency(
      String from,
      String to,
      double amount,
      ) async {
    final rates = await getCurrencyRates();

    final fromRate = rates[from];
    final toRate = rates[to];

    if (fromRate != null && toRate != null) {
      return amount * (toRate / fromRate);
    } else {
      throw Exception('Failed to convert currency');
    }
  }
}
