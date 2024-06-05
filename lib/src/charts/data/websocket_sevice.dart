import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ravenpay_assessment/src/charts/domain/order_model.dart';

Future<OrderBook> fetchOrderBook() async {
  final response = await http.get(Uri.parse(
      'https://api.binance.com/api/v3/depth?symbol=BTCUSDT&limit=10'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse =
        json.decode(response.body) as Map<String, dynamic>;
    return OrderBook.fromJson(jsonResponse);
  } else {
    throw Exception('Failed to load order book');
  }
}
