import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class VideoTrailer extends StatelessWidget {
  final int idVideo;
  const VideoTrailer(this.idVideo, {super.key});
  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      onLoadStop: (controller, url) async {
        String codeJs =
            "let el = document.querySelector('iframe');el.src = 'https://player.vimeo.com/video/$idVideo'";
        controller.evaluateJavascript(source: codeJs);
      },
      onLoadResource: (controller, url) {},
      onWebViewCreated: (controller) async {
        await controller.loadFile(assetFilePath: 'assets/html/index.html');
      },
    );
  }
}
