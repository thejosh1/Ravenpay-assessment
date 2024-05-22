import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OrderBook extends StatefulWidget {
  const OrderBook({super.key});

  @override
  _OrderBookState createState() => _OrderBookState();
}

class _OrderBookState extends State<OrderBook> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..loadHtmlString('''
        <!DOCTYPE html>
        <html>
        <head>
          <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
        </head>
        <body>
          <div id="tradingview_orderbook" style="height: 100%;"></div>
          <script type="text/javascript">
            new TradingView.widget({
              "container_id": "tradingview_orderbook",
              "width": "100%",
              "height": "100%",
              "symbol": "BINANCE:BTCUSDT",
              "interval": "D",
              "theme": "light",
              "style": "1",
              "locale": "en",
              "toolbar_bg": "#f1f3f6",
              "enable_publishing": false,
              "allow_symbol_change": true,
              "save_image": false,
              "studies": [
                "Depth@tv-basicstudies"
              ]
            });
          </script>
        </body>
        </html>
      ''');
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
