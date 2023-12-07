import 'package:flutter/material.dart';
import 'package:kidora/src/general/app_colors.dart';

class ShrugsButton extends StatefulWidget {
  final Color textColor = AppColors.white;
  final String text;
  final double width;
  final double height;
  final Color oneStFloorColor = Colors.blue;
  final Widget? iconLeft;
  final Color twoStFloorColor = Colors.green;
  final Color oneStFloorClickColor = AppColors.color_6BBE34;
  final Color twoStFloorClickColor = AppColors.color_5CAC27;
  final double textFontSize;
  final void Function() onTap;

  ShrugsButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.textFontSize = 17,
      required this.width,
      this.iconLeft,
      required this.height});
  @override
  State<StatefulWidget> createState() => _ShrugsButton();
}

class _ShrugsButton extends State<ShrugsButton> {
  bool isTap = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: widget.width,
          height: widget.height,
          padding: EdgeInsets.all(widget.height * 0.1),
          decoration: BoxDecoration(
            color: isTap ? widget.twoStFloorClickColor : widget.twoStFloorColor,
            borderRadius:
                BorderRadius.all(Radius.circular(widget.height * 0.3)),
            border: Border.all(
              color: AppColors.white,
              width: widget.height * 0.1,
              style: BorderStyle.solid,
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  spreadRadius: widget.height * 0.01,
                  offset: Offset(0, widget.height * 0.104))
            ],
          ),
        ),
        Positioned.fill(
            child: Align(
          alignment: Alignment.topCenter,
          child: AnimatedContainer(
            onEnd: () {
              setState(() {
                isTap = false;
              });
            },
            duration: const Duration(milliseconds: 100),
            curve: Curves.bounceInOut,
            transform: Matrix4.translationValues(
                0, !isTap ? -(widget.height * 0.1) : 0, 0),
            child: GestureDetector(
              onTap: () {
                Future.delayed(
                    const Duration(milliseconds: 200), () => widget.onTap());

                setState(() {
                  isTap = true;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isTap
                      ? widget.oneStFloorClickColor
                      : widget.oneStFloorColor,
                  borderRadius:
                      BorderRadius.all(Radius.circular(widget.height * 0.25)),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                width: widget.width - (widget.height * 0.2),
                height: widget.height - (widget.height * 0.2),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      if (widget.iconLeft != null) widget.iconLeft as Widget,
                      Text(
                        widget.text,
                        style: TextStyle(
                            height: 1.2,
                            fontWeight: FontWeight.w700,
                            fontSize: widget.textFontSize,
                            color: AppColors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ))
      ],
    );
  }
}

class GreenButton extends ShrugsButton {
  @override
  // ignore: overridden_fields
  final oneStFloorColor = AppColors.color_88C461;
  @override
  // ignore: overridden_fields
  final twoStFloorColor = AppColors.color_6CAE41;

  GreenButton(
      {Key? key,
      required void Function() onTap,
      double textFontSize = 17,
      required double width,
      required String text,
      required double height})
      : super(
            key: key,
            onTap: onTap,
            textFontSize: textFontSize,
            width: width,
            text: text,
            height: height);
}

class PurpleButton extends ShrugsButton {
  @override
  final Color oneStFloorColor = AppColors.color_906CFF;
  @override
  final Color twoStFloorColor = AppColors.color_AF95FE;
  @override
  final Color oneStFloorClickColor = AppColors.color_7956E7;
  @override
  final Color twoStFloorClickColor = AppColors.color_8D74D9;

  PurpleButton(
      {Key? key,
      required void Function() onTap,
      double textFontSize = 17,
      required double width,
      required String text,
      required double height})
      : super(
            key: key,
            onTap: onTap,
            textFontSize: textFontSize,
            width: width,
            text: text,
            height: height);
}

class OrangeButton extends ShrugsButton {
  @override
  final Color oneStFloorColor = AppColors.color_FFB213;
  @override
  final Color twoStFloorColor = AppColors.color_FF8413;
  @override
  final Color oneStFloorClickColor = AppColors.color_FD9E11;
  @override
  final Color twoStFloorClickColor = AppColors.color_FF7D05;

  OrangeButton(
      {Key? key,
      required void Function() onTap,
      double textFontSize = 17,
      required double width,
      required String text,
      required double height})
      : super(
            key: key,
            onTap: onTap,
            textFontSize: textFontSize,
            width: width,
            text: text,
            height: height);
}

class PinkButton extends ShrugsButton {
  @override
  final Color oneStFloorColor = AppColors.color_FF60D2;
  // #FF60D2
  @override
  final Color twoStFloorColor = AppColors.color_FE2AC3;
  // #FE2AC3
  @override
  final Color oneStFloorClickColor = AppColors.color_EC3BBA;
  // #EC3BBA
  @override
  final Color twoStFloorClickColor = AppColors.color_DC26A9;
  // #DC26A9

  PinkButton(
      {Key? key,
      required void Function() onTap,
      double textFontSize = 17,
      required double width,
      required String text,
      required double height})
      : super(
            key: key,
            onTap: onTap,
            textFontSize: textFontSize,
            width: width,
            text: text,
            height: height);
}

class SilverButton extends ShrugsButton {
  @override
  final Color oneStFloorColor = AppColors.color_b8b8b6;
  // #FF60D2
  @override
  final Color twoStFloorColor = AppColors.color_7d7d7d;
  // #FE2AC3
  @override
  final Color oneStFloorClickColor = AppColors.color_b8b8b6;
  // #EC3BBA
  @override
  final Color twoStFloorClickColor = AppColors.color_7d7d7d;
  // #DC26A9

  SilverButton(
      {Key? key,
      double textFontSize = 17,
      required double width,
      required String text,
      required double height})
      : super(
            key: key,
            onTap: () {},
            textFontSize: textFontSize,
            width: width,
            text: text,
            height: height);
}

class BlueButton extends ShrugsButton {
  @override
  final Color oneStFloorColor = AppColors.color_008DF1;
  @override
  final Color twoStFloorColor = AppColors.color_0061D2;
  @override
  final Color oneStFloorClickColor = AppColors.color_0D6EFF;
  @override
  final Color twoStFloorClickColor = AppColors.color_0061D2;

  BlueButton(
      {Key? key,
      double textFontSize = 17,
      required void Function() onTap,
      required double width,
      required String text,
      required double height})
      : super(
            key: key,
            onTap: onTap,
            textFontSize: textFontSize,
            width: width,
            text: text,
            height: height);
}

class BlueButtonIcon extends ShrugsButton {
  @override
  final Color oneStFloorColor = AppColors.color_008DF1;
  @override
  final Color twoStFloorColor = AppColors.color_0061D2;
  @override
  final Color oneStFloorClickColor = AppColors.color_0D6EFF;
  @override
  final Color twoStFloorClickColor = AppColors.color_0061D2;

  BlueButtonIcon(
      {Key? key,
      double textFontSize = 17,
      required iconLeft,
      required void Function() onTap,
      required double width,
      required String text,
      required double height})
      : super(
            key: key,
            onTap: onTap,
            iconLeft: iconLeft,
            textFontSize: textFontSize,
            width: width,
            text: text,
            height: height);
}

class GreenButtonIcon extends ShrugsButton {
  @override
  // ignore: overridden_fields
  final oneStFloorColor = AppColors.color_88C461;
  @override
  // ignore: overridden_fields
  final twoStFloorColor = AppColors.color_6CAE41;
  GreenButtonIcon(
      {Key? key,
      double textFontSize = 17,
      required iconLeft,
      required void Function() onTap,
      required double width,
      required String text,
      required double height})
      : super(
            key: key,
            onTap: onTap,
            iconLeft: iconLeft,
            textFontSize: textFontSize,
            width: width,
            text: text,
            height: height);
}
