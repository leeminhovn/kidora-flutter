import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kidora/src/components/oragnisms/course_item/CategoryCourse.dart';
import 'package:kidora/src/components/oragnisms/loading/loading_green.dart';

import 'package:kidora/src/general/app_colors.dart';
import 'package:kidora/src/general/app_constant.dart';
import 'package:kidora/src/modules/home/bloc/account_cubit.dart';
import 'package:kidora/src/modules/home/bloc/courses_cubit.dart';

class ListCoursePage extends StatefulWidget {
  const ListCoursePage({super.key});

  @override
  State<StatefulWidget> createState() => _ListCoursePage();
}

class _ListCoursePage extends State<ListCoursePage> {
  final ScrollController _scrollController = ScrollController();
  bool isDoneCallAll = false;
  int pageNextCall = 1;
  bool isCrawling = false;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (isCrawling ||
          BlocProvider.of<CoursesCubit>(context).state is CoursesDoneLoadAll ||
          BlocProvider.of<CoursesCubit>(context)
              .state
              .coursesSameCategory
              .isEmpty) {
        return;
      }
      if (_scrollController.position.maxScrollExtent -
              _scrollController.position.pixels <=
          20) {
        isCrawling = true;
        pageNextCall += 1;

        BlocProvider.of<CoursesCubit>(context).getCourses(
            email: BlocProvider.of<AccountCubit>(context).state.email,
            page: pageNextCall,
            limit: 1,
            success: () {
              print('done call Page ${pageNextCall}');
              Future.delayed(
                  const Duration(seconds: 1), () => isCrawling = false);
            });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<CoursesCubit, CoursesState>(builder: (context, state) {
      if (state is CoursesReset) {
        pageNextCall = 1;
      }
      return SizedBox(
          width: screenSize.width,
          height: screenSize.height,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  physics: state.coursesSameCategory.isNotEmpty
                      ? const BouncingScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal:
                          screenSize.width <= AppConstant.screenWidthMobile
                              ? 16
                              : 26),
                  itemCount: state.coursesSameCategory.length + 2,
                  //  + 1 to ren banner + 1 to ren loading
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 700),
                            child: Center(
                              child: Image.asset(
                                screenWidth <= 500
                                    ? "assets/banners/banner_mobile_499k.webp"
                                    : "assets/banners/banner_desktop_499k.webp",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        separatorLine(),
                        const SizedBox(
                          height: 28.73,
                        ),
                      ]);
                    } else if (index == state.coursesSameCategory.length + 1) {
                      return state is CoursesLoading &&
                              state is! CoursesDoneLoadAll
                          ? const LoadingGreen()
                          : const SizedBox.shrink();
                    } else {
                      return CategoryCourse(
                          state.coursesSameCategory[index - 1]);
                    }
                  },
                ),
              ),
            ],
          ));
    });
  }

  Widget separatorLine() {
    return Container(
      width: double.infinity,
      height: 1,
      color: AppColors.color_D8E1E3,
    );
  }
}
