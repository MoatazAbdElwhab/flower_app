import 'package:flower_app/features/checkout/domain/entities/check_out_session_detailes.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final OnlinePaymentDetails onlinePaymentDetails;

  const WebViewPage({
    super.key,
    required this.onlinePaymentDetails,
  });

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  void _initWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains(widget.onlinePaymentDetails.successUrl)) {
              Navigator.pop(context, true);
              return NavigationDecision.prevent;
            } else if (request.url
                .contains(widget.onlinePaymentDetails.cancelUrl)) {
              Navigator.pop(context, false);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.onlinePaymentDetails.sessionUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(controller: _controller),
    );
  }
}
