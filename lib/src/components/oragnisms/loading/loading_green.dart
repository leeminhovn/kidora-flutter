import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoadingGreen extends StatefulWidget {
  const LoadingGreen({super.key});

  @override
  State<LoadingGreen> createState() => _LoadingGreenState();
}

class _LoadingGreenState extends State<LoadingGreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: false);
  }

  @override
  void dispose() {
    // Dispose the animation controller
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: animation.value * 2 * pi,
      child: Image.asset(
        'assets/animations/loading/LoadingGreen.png',
        width: 50,
        height: 50,
      ),
    );
  }
}
