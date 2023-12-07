import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:kidora/src/components/utils/printColor.dart';
import 'package:kidora/src/modules/learn/components/streamControllerManager.dart';
import 'package:webview_flutter/webview_flutter.dart';



class VideoComponent extends StatefulWidget {
  final StreamController currentControllerProgressCard;

  const VideoComponent(
      {super.key, required this.currentControllerProgressCard});

  @override
  State<StatefulWidget> createState() => _VideoComponent();
}

class _VideoComponent extends State<VideoComponent> {
  int teo = Random().nextBool() ? 839199639 : 839199623;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    teo == 839199639 ? teo = 839199623 : teo = 839199639;
    return InAppWebView(
      
      // initialFile: 'assets/html/index.html',
      onLoadStop: (controller, url) async {
        await controller.evaluateJavascript(
            source:
                "localStorage.link='https://player.vimeo.com/video/$teo';localStorage.indexVideo=0");

        await controller.injectJavascriptFileFromAsset(
            assetFilePath: "assets/js/controller.js");
      },
      onWebViewCreated: (controller) async {
        controller.addJavaScriptHandler(
            handlerName: "updateProgress",
            callback: (args) {
              print(args);
              widget.currentControllerProgressCard.add(args[1]);
            });
        // then load your URL
        await controller.loadFile(assetFilePath: 'assets/html/index.html');
      },
    );
  }
}
