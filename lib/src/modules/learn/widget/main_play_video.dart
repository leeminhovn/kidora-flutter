import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kidora/src/components/molecules/video_component.dart';

class MainPlayVideo extends StatefulWidget {
  final StreamController currentControllerProgressCard;
  const MainPlayVideo({super.key, required this.currentControllerProgressCard});

  @override
  State<StatefulWidget> createState() => _MainPlayVideo();
}

class _MainPlayVideo extends State<MainPlayVideo> {
  @override
 
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return VideoComponent(currentControllerProgressCard: widget.currentControllerProgressCard);
  }
}
