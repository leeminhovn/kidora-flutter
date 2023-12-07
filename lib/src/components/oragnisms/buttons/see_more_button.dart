import 'package:flutter/material.dart';
import 'package:kidora/src/general/app_colors.dart';

class SeeMoreButton extends StatelessWidget {
  final void Function() tap;
  const SeeMoreButton({required this.tap, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 35),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(blurRadius: 10, color: Colors.black.withAlpha(30))
      ], color: AppColors.white, borderRadius: BorderRadius.circular(10)),
      width: 180,
      child: InkWell(
        onTap: tap,
        child: Row(children: [
          const SizedBox(
            width: 15,
          ),
          Image.asset(
            'assets/images/components/bottom_arrow_green.png',
            width: 24,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "Xem thêm",
            style: TextStyle(
                color: AppColors.color_88C461,
                fontWeight: FontWeight.bold,
                fontSize: 19,
                decoration: TextDecoration.underline),
          )
        ]),
      ),
    );
  }
}
