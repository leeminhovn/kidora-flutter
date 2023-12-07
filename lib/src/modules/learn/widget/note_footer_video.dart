import 'package:flutter/material.dart';
import 'package:kidora/src/general/app_colors.dart';

class NoteFooterVideo extends StatefulWidget {
  final String note;
  const NoteFooterVideo({super.key, required this.note});

  @override
  State<StatefulWidget> createState() => _NoteFooterVideo();
}

class _NoteFooterVideo extends State<NoteFooterVideo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 70),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              constraints: (const BoxConstraints(minWidth: 200)),
              padding: const EdgeInsets.fromLTRB(20, 20, 80, 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  border: Border.all(
                      color: AppColors.color_f68e00, strokeAlign: 2)),
              child: Text(
                widget.note,
                style:
                    const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: SizedBox(
              width: 79,
              child:
                  Image.asset("assets/images/angle/angle_male_not_start.png"),
            ),
          )
        ],
      ),
    );
  }
}
