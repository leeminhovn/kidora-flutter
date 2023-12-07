import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kidora/src/general/app_colors.dart';

class LoadingPopupWhite extends StatefulWidget {
  const LoadingPopupWhite({super.key});

  @override
  State<StatefulWidget> createState() => _LoadingPoup();
}

class _LoadingPoup extends State<LoadingPopupWhite>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.color_00003A),
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: AnimatedBuilder(
            animation: _controller,
            child: Image.asset(
              'assets/images/components/loading_login.png',
              width: 50,
            ),
            builder: (BuildContext context, Widget? child) {
              return Transform.rotate(
                angle: _controller.value * 2.0 * pi,
                child: child,
              );
            }),
      ),
    );
  }
}
