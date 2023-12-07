import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kidora/src/components/utils/printColor.dart';
import 'package:kidora/src/data/dtos/courses/courses.dart';
import 'package:kidora/src/general/app_colors.dart';
import 'package:kidora/src/general/app_constant.dart';
import 'package:kidora/src/modules/home/bloc/lessons_cubit.dart';
import 'package:kidora/src/modules/learn/components/streamControllerManager.dart';
import 'package:kidora/src/modules/learn/widget/card_lesson.dart';

class LearnPageTop extends StatefulWidget {
  final CourseDto? currentCourse;
  final List<InfoProcess> processLearnLessons;

  final ManagerStreamBuilder managerStream;
  const LearnPageTop(
      this.currentCourse, this.managerStream, this.processLearnLessons,
      {super.key});

  @override
  State<StatefulWidget> createState() => _LearnPageTop();
}

class _LearnPageTop extends State<LearnPageTop> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.managerStream.disposeStreams();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int countDone =
        widget.processLearnLessons.where((element) => element.isDone).length;
    if (widget.processLearnLessons[0].isDone == true) countDone--;

    return Column(children: [
      LearnPageTopHeader(
          widget.currentCourse?.title, widget.currentCourse?.description),
      LearnPageTopMain(widget.currentCourse?.lessons ?? [], countDone),
      LearnPageTopFooter(
          currentCourse: widget.currentCourse!,
          managerStream: widget.managerStream,
          processLearnLessons: widget.processLearnLessons),
    ]);
  }
}

class LearnPageTopHeader extends StatelessWidget {
  final String? title;
  final String? description;
  const LearnPageTopHeader(this.title, this.description, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
      padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10, top: 5),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.color_88c461,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        children: [
          Text(
            title ?? '',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            description ?? '',
            style: TextStyle(
                color: AppColors.white,
                fontSize: 17,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

class LearnPageTopMain extends StatelessWidget {
  final List<LessonDto> lessons;
  final int? countDoneCourse;
  const LearnPageTopMain(this.lessons, this.countDoneCourse, {super.key});
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth <= AppConstant.screenWidthMobile ? 0 : 10),
      child: Column(children: [
        Container(
          height: 46,
          decoration: BoxDecoration(color: AppColors.white, boxShadow: [
            BoxShadow(blurRadius: 15, color: AppColors.color_00002A)
          ]),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              'assets/icons/ic_learned.png',
              width: 40,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              'Đã học ${countDoneCourse ?? 0} / ${lessons.length - 1}',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.color_88c461),
            )
          ]),
        )
      ]),
    );
  }
}

class LearnPageTopFooter extends StatefulWidget {
  final CourseDto currentCourse;
  final ManagerStreamBuilder managerStream;
  final List<InfoProcess> processLearnLessons;
  const LearnPageTopFooter(
      {super.key,
      required this.currentCourse,
      required this.managerStream,
      required this.processLearnLessons});

  @override
  State<StatefulWidget> createState() => _LearnPageTopFooter();
}

class _LearnPageTopFooter extends State<LearnPageTopFooter> {
  final PageController _pageController = PageController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final int itemCount = widget.currentCourse.lessons.length;
    int countItemGeneral = screenWidth <= AppConstant.screenWidthMobile
        ? 1
        : screenWidth <= AppConstant.screenWidthTable
            ? 2
            : 3;
    final int currentIndexLesson =
        context.watch<LessonsCubit>().state.currentLessonIdx;
    handleClickNext() {}

    handleClickPrev() {}

    handleClickLesson(int idx) {
      if (currentIndexLesson != idx) {
        // chuyển sang lesson khác và update lịch sử học của lesson cũ
        // điều kiện update là phải lớn hơn initial value process
        context.read<LessonsCubit>().changeLesson(idx);
      }
    }

    return Container(
        decoration: BoxDecoration(color: AppColors.color_F4F5FB, boxShadow: [
          BoxShadow(color: AppColors.color_00002A, blurRadius: 10)
        ]),
        constraints: const BoxConstraints(maxHeight: 220),
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth <= AppConstant.screenWidthMobile ? 0 : 10),
        height: screenWidth *
            (screenWidth <= AppConstant.screenWidthMobile ? 0.43 : 0.25),
        child: Row(children: [
          _buttonControll(
              screenWidth, "back", _pageController, handleClickNext),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                itemCount: (itemCount / countItemGeneral).ceil(),
                itemBuilder: (BuildContext context, int pageIndex) {
                  return LayoutBuilder(
                      builder: (_, BoxConstraints constraints) {
                    return Padding(
                        padding: EdgeInsets.only(
                            top: screenWidth > AppConstant.screenWidthTable
                                ? 10
                                : 0,
                            bottom: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: renderListLesson(
                                pageIndex,
                                countItemGeneral,
                                itemCount,
                                constraints,
                                widget.currentCourse,
                                widget.processLearnLessons,
                                handleClickLesson,
                                currentIndexLesson)));
                  });
                },
              ),
            ),
          ),
          _buttonControll(
              screenWidth, "next", _pageController, handleClickPrev),
        ]));
  }

  List<Widget> renderListLesson(
    int pageIndex,
    int countItemGeneral,
    int itemCount,
    BoxConstraints constraints,
    CourseDto currentCourse,
    List<InfoProcess> listProgressLearn,
    Function handleClickLesson,
    int currentLessonIdx,
  ) {
    List<Widget> listWidget = [];
    for (int i = 0; i < countItemGeneral; i++) {
      final int itemIndex = pageIndex * countItemGeneral + i;
      if (itemIndex >= itemCount) {
      } else {
        listWidget.add(CardLesson(
          progressController: widget.managerStream.listStreamBuilder[itemIndex],
          lesson: currentCourse.lessons[itemIndex],
          isActive: currentLessonIdx == itemIndex,
          widthContainer: constraints.minWidth,
          processValue: listProgressLearn[itemIndex].process,
          onTap: () => handleClickLesson(itemIndex),
        ));
      }
    }
    return listWidget;
  }

  Widget _buttonControll(double screenWidth, String type,
      PageController _pageController, Function() handleClick) {
    return SizedBox(
      width: (screenWidth <= AppConstant.screenWidthMobile
          ? screenWidth * 0.14
          : 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LayoutBuilder(builder: (context, constraint) {
            return GestureDetector(
              onTap: () {
                type == "next"
                    ? _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease)
                    : _pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease);
              },
              child: Container(
                constraints: screenWidth <= AppConstant.screenWidthMobile
                    ? const BoxConstraints()
                    : const BoxConstraints(minWidth: 37, minHeight: 37),
                padding: EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                    left: type == "back" ? 0 : 5,
                    right: type == "back" ? 5 : 0),
                width: 37 / 76 * constraint.maxWidth,
                height: 37 / 76 * constraint.maxWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.color_88c461),
                child: FittedBox(
                    child: Transform(
                        alignment: Alignment.center,
                        transform:
                            Matrix4.rotationY(type == "back" ? 0 : pi), //
                        child: SvgPicture.asset(
                            "assets/icons/ic_back_white.svg"))),
              ),
            );
          })
        ],
      ),
    );
  }
}
