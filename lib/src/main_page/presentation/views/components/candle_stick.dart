import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'cyptodata.dart';

class TradingViewWidgetHtml extends StatefulWidget {
  const TradingViewWidgetHtml({
    required this.cryptoName,
    super.key,
  });

  final String cryptoName;
  @override
  State<TradingViewWidgetHtml> createState() => _TradingViewWidgetHtmlState();
}

class _TradingViewWidgetHtmlState extends State<TradingViewWidgetHtml> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('progress');
          },
          onPageStarted: (String url) {
            debugPrint('started');
          },
          onPageFinished: (String url) {
            debugPrint('finished');
          },
        ),
      )
      ..enableZoom(true)
      ..loadHtmlString(
          CryptoNameDataSource.cryptoNameAndSource(widget.cryptoName),);
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
  }
}
