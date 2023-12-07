import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kidora/src/components/oragnisms/buttons/shrugs_buttons.dart';
import 'package:kidora/src/components/oragnisms/course_item/CategoryCourse.dart';
import 'package:kidora/src/components/oragnisms/loading/loading_green.dart';
import 'package:kidora/src/data/dtos/courses/courses.dart';
import 'package:kidora/src/general/app_constant.dart';
import 'package:kidora/src/modules/home/bloc/account_cubit.dart';
import 'package:kidora/src/modules/home/bloc/courses_cubit.dart';

class ListBoughtCoursePage extends StatefulWidget {
  const ListBoughtCoursePage({super.key});

  @override
  State<StatefulWidget> createState() => _ListBoughtCoursePage();
}

class _ListBoughtCoursePage extends State<ListBoughtCoursePage> {
  @override
  // TODO: implement wantKeepAlive

  @override
  Widget build(BuildContext context) {
    print('rebuild page 2');
    return BlocBuilder<CoursesCubit, CoursesState>(builder: (context, state) {
      if ((BlocProvider.of<AccountCubit>(context).state.courses.isEmpty)) {
        return SingleChildScrollView(child: screenIsemptyCourse(context));
      }
      final List<CoursesSameCategoryDto> dataBought = [];

      for (var categoryData in state.coursesSameCategoryAll) {
        categoryData.courses.removeWhere((course) => course.status != 1);
        if (categoryData.courses.isNotEmpty) dataBought.add(categoryData);
      }
      return screenHaveCourse(dataBought);
    });
  }

  Widget screenIsemptyCourse(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    Widget componentMain() {
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text.rich(
          TextSpan(children: [
            TextSpan(text: 'Bé không có khóa học nào.\n'),
            TextSpan(text: 'Đăng ký mua khóa học và bắt đầu học cùng\n'),
            TextSpan(text: 'Kidora nhé!')
          ]),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 20,
        ),
        Image.asset(
          'assets/images/angle/angle_male_straight.png',
          width: 170,
        ),
        const SizedBox(
          height: 17,
        ),
        PinkButton(
            onTap: () {
              print('mua khoa hoc');
            },
            width: 170,
            text: 'Mua khoá học',
            height: 40)
      ]);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
      child: screenWidth <= AppConstant.screenWidthTable
          ? componentMain()
          : Transform.scale(scale: 1.3, child: componentMain()),
    );
  }

  Widget screenHaveCourse(List<CoursesSameCategoryDto> dataBoght) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
        physics: const BouncingScrollPhysics(),
        itemCount: dataBoght.length,
        itemBuilder: (context, index) {
          return CategoryCourse(dataBoght[index]);
        });
  }
}
