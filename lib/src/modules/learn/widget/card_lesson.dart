import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kidora/src/data/dtos/courses/courses.dart';
import 'package:kidora/src/general/app_colors.dart';
import 'package:kidora/src/general/app_constant.dart';

import 'package:kidora/src/modules/learn/widget/progress_card_lesson.dart';

class CardLesson extends StatefulWidget {
  final double widthContainer;
  final bool isActive;
  final LessonDto lesson;
  final StreamController<double> progressController;
  final double processValue;
  final Function onTap;
  const CardLesson({
    required this.widthContainer,
    required this.lesson,
    required this.isActive,
    required this.progressController,
    required this.processValue,
    required this.onTap,
    super.key,
  });

  @override
  State<CardLesson> createState() => _CardLessonState();
}

class _CardLessonState extends State<CardLesson> {
  bool isShown = false;
 @override
  
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double widthOfItem = widget.widthContainer *
        (screenWidth <= AppConstant.screenWidthMobile
            ? 1
            : screenWidth <= AppConstant.screenWidthTable
                ? 0.48
                : 0.3);
    final double widthOfItemTitle = widthOfItem * (111.26 / 271.38);
    return GestureDetector(
      onTapUp: (value) {
        widget.onTap();
        if (isShown) {
          setState(() {
            isShown = false;
          });
        }
      },
      onPanDown: ((value) {
        if (!isShown) {
          setState(() {
            isShown = true;
          });
        }
      }),
      onPanStart: ((d) {
        if (isShown) {
          setState(() {
            isShown = false;
          });
        }
      }),
      child: AnimatedContainer(
        duration: Duration.zero,
        transform: isShown
            ? Matrix4.translationValues(0, 6, 0)
            : Matrix4.translationValues(0, 0, 0),
        child: SizedBox(
          width: widthOfItem,
          child: AspectRatio(
              aspectRatio: 247 / 100,
              child: Stack(
                // fit: StackFit.expand,
                children: [
                  Container(
                      width: double.infinity,
                      height: double.infinity,
                      padding: EdgeInsets.only(
                          top: 14.55 / 271.379 * widthOfItem,
                          left: 10.69 / 271.379 * widthOfItem,
                          right: 10.69 / 271.379 * widthOfItem,
                          bottom: 8.26 / 271.379 * widthOfItem),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, isShown ? 0 : 6),
                              color: AppColors.color_D0D0D6)
                        ],
                        color: widget.isActive
                            ? AppColors.color_FAE4C6
                            : AppColors.white,
                        borderRadius: BorderRadius.circular(widthOfItem * 0.05),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 69.338 / 271.379 * widthOfItem,
                                height: 69.338 / 271.379 * widthOfItem,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(widthOfItem * 0.02),
                                  child: Image.network(
                                    "https://api-test.kidora.vn/images/baihoc/${widget.lesson.image}",
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: widthOfItem * 0.05,
                              ),
                              Flexible(
                                  child: Text(widget.lesson.description,
                                      style: TextStyle(
                                          fontSize: screenWidth <=
                                                  AppConstant.screenWidthTable
                                              ? 15
                                              : 19,
                                          fontWeight: FontWeight.w600),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis))
                            ],
                          ),
                          ProgresCardLesson(
                            progressController: widget.progressController,
                            initalValue: widget.processValue / 100,
                          )
                        ],
                      )),
                  Align(
                      alignment: Alignment.topCenter,
                      child: Transform.translate(
                        offset: Offset(0, -widthOfItemTitle * 0.12),
                        child: Stack(
                          children: [
                            Image.asset(
                              'assets/images/components/${widget.isActive ? "Union_title_lesson.png" : "top_title_testActive.png"}',
                              width: widthOfItemTitle,
                            ),
                            Positioned.fill(
                                child: Padding(
                              padding: const EdgeInsets.only(bottom: 6, top: 4),
                              child: FittedBox(
                                alignment: Alignment.center,
                                child: Text(
                                  widget.lesson.title,
                                  style: TextStyle(
                                      color: widget.isActive
                                          ? AppColors.white
                                          : AppColors.color_f68e00,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ))
                          ],
                        ),
                      )),
                  if (widget.isActive)
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Transform.translate(
                         offset: const Offset(0, 15),
                          child: SizedBox(
                              width: 20,
                              child: Image.asset(
                                  'assets/icons/icon_down_orange.png')),
                        ))
                ],
              )),
        ),
      ),
    );
  }
}
