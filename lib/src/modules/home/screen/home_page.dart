import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kidora/src/components/molecules/custom_dialog.dart';
import 'package:kidora/src/components/oragnisms/appBarCustom.dart';
import 'package:kidora/src/components/utils/printColor.dart';
import 'package:kidora/src/data/data_source/local/user_local_storge.dart';
import 'package:kidora/src/general/app_colors.dart';
import 'package:kidora/src/modules/home/bloc/account_cubit.dart';
import 'package:kidora/src/modules/home/bloc/courses_cubit.dart';
import 'package:kidora/src/modules/home/screen/list_bought_course_page.dart';
import 'package:kidora/src/modules/home/screen/list_course_page.dart';

import '../../../components/oragnisms/navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activePage = 0;
  final PageController _pageController = PageController();
  TextEditingController controllerTextRefreshToken = TextEditingController();
  TextEditingController controllerTextToken = TextEditingController();

  @override
  void dispose() {
    controllerTextRefreshToken.dispose();
    controllerTextToken.dispose();

    _pageController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarCustom(),
        body: Container(
          color: AppColors.color_F4F5FB,
          width: double.infinity,
          height: double.infinity,
          child: Column(children: [
            NavigationBarKidora(page: activePage, goToPage: goToPage),
            Expanded(
                child: BlocListener<AccountCubit, AccountState>(
              listenWhen: (previous, current) {
                if (previous.email != current.email) {
                  return true;
                } else if (current is AccountStateLogout) {
                  return true;
                } else if (previous is AccountStateInitial &&
                    current is AccountStateLoaded) {
                  return true;
                }
                return false;
              },
              listener: (context, state) {
                BlocProvider.of<CoursesCubit>(context)
                    .getCoursesAll(email: state.email);
                BlocProvider.of<CoursesCubit>(context)
                    .getCourses(email: state.email, page: 1, limit: 1);
              },
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    activePage = page;
                  });
                },
                scrollDirection: Axis.horizontal,
                children: const [ListCoursePage(), ListBoughtCoursePage()],
              ),
            ))
          ]),
        ),
      ),
    );
  }
}
