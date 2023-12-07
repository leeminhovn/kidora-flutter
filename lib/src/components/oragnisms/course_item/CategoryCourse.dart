import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kidora/src/components/oragnisms/buttons/see_more_button.dart';
import 'package:kidora/src/components/oragnisms/course_item/CourseItemBase.dart';
import 'package:kidora/src/data/dtos/courses/courses.dart';
import 'package:kidora/src/modules/home/bloc/courses_cubit.dart';

class CategoryCourse extends StatefulWidget {
  final CoursesSameCategoryDto categoryCourse;
  const CategoryCourse(this.categoryCourse, {super.key});

  @override
  State<StatefulWidget> createState() => _CategoryCourse();
}

class _CategoryCourse extends State<CategoryCourse>
    with AutomaticKeepAliveClientMixin {
  int showMoreMax = 6;
  late List<CourseDto> listCourse = widget.categoryCourse.courses;

  @override
  void dispose() {
    super.dispose();
  }

  Widget renderCourse(CourseDto dataCourse) {
    switch (dataCourse.status) {
      case 0:
        return CourseItemNotBought(
          courseDto: dataCourse,
          clickButton: () => {
            // openCourse
            BlocProvider.of<CoursesCubit>(context)
                .openCourse(dataCourse, context)
          },
        );
      case 1:
        return CourseItemBought(
            courseDto: dataCourse,
            clickButton: () => {
                  // openCourse
                  BlocProvider.of<CoursesCubit>(context)
                      .openCourse(dataCourse, context)
                });
      case 2:
        return CourseItemIscomming(
            courseDto: dataCourse, clickButton: () => {});
      default:
        return CourseItemBought(
            courseDto: dataCourse,
            clickButton: () => {
                  // openCourse
                  BlocProvider.of<CoursesCubit>(context)
                      .openCourse(dataCourse, context)
                });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final List<Widget> courseWidgets = [];
    for (int index = 0;
        (index < listCourse.length && index < showMoreMax);
        index++) {
      courseWidgets.add(renderCourse(listCourse[index]));
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: Wrap(
          runSpacing: 25,
          spacing: 20,
          // mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.categoryCourse.category != "simple_course")
              categoryTitle(widget.categoryCourse.category),
            ...courseWidgets,
            if (showMoreMax < listCourse.length)
              SeeMoreButton(
                tap: () {
                  setState(() {
                    showMoreMax += 6;
                  });
                },
              ),
          ]),
    );
  }

  Widget categoryTitle(String titleCategory) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/components/icon_course_list.png',
            width: 45,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            titleCategory,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
