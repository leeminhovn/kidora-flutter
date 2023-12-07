import 'package:flutter/material.dart';
import 'package:kidora/src/general/app_colors.dart';

@override
AlertDialog customDialog(BuildContext context, List<Widget> children) {
  final double screenWidth = MediaQuery.of(context).size.width;
  return AlertDialog(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25))),
    insetPadding: EdgeInsets.zero,
    contentPadding: EdgeInsets.zero,
    // title: Text('Học nhảy tiktok  cùng công chúa mây'),
    content: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: screenWidth * 0.98,
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          constraints: const BoxConstraints(minHeight: 310, maxWidth: 500),
          decoration: const BoxDecoration(
            // borderRadius: BorderRadius.all(Radius.circular(20)),
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/backgrounds/bg_popup.png',
                ),
                fit: BoxFit.contain,
                repeat: ImageRepeat.repeatY),
          ),
          // color: Colors.red,
          child: Column(mainAxisSize: MainAxisSize.min, children: children),
        ),
        Positioned(
          right: 10,
          top: -15,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.color_ff4672,
                        spreadRadius: 0,
                        offset: const Offset(0, 3))
                  ]),
              child: Image.asset(
                'assets/images/components/close_btn.png',
                width: 37,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
