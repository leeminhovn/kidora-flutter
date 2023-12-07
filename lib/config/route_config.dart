import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kidora/config/router_name.dart';
import 'package:kidora/src/components/utils/printColor.dart';
import 'package:kidora/src/modules/home/bloc/lessons_cubit.dart';
import 'package:kidora/src/modules/home/screen/home_page.dart';
import 'package:kidora/src/modules/learn/screen/learn_page.dart';
import 'package:kidora/src/modules/login/screen/login_screen.dart';
import 'package:kidora/src/modules/splase/screen/splase_screen.dart';

import '../src/modules/home/bloc/account_cubit.dart';
import '../src/modules/home/bloc/courses_cubit.dart';

final GoRouter routerConfig =
    GoRouter(initialLocation: ApplicationRouteName.splash,
    errorBuilder: (context, state) => printColor.red(state.error.toString()),
     routes: <RouteBase>[
  GoRoute(
      path: ApplicationRouteName.splash,
      name: ApplicationRouteName.splash,
      builder: (BuildContext context, GoRouterState state) {
        return const SplaseScreen();
      }),
  GoRoute(
      path: ApplicationRouteName.dashboard,
      name: ApplicationRouteName.dashboard,
      builder: (BuildContext context, GoRouterState state) {
        // return SplaseScreen();

        return MultiBlocProvider(
          providers: [
            BlocProvider<AccountCubit>.value(
              value: context.read<AccountCubit>(),
            ),
            BlocProvider<CoursesCubit>.value(
              value: context.read<CoursesCubit>(),
            ),
          ],
          child: const HomePage(),
        );
      }),
  GoRoute(
    path: ApplicationRouteName.login,
    name: ApplicationRouteName.login,
    builder: ((BuildContext context, GoRouterState state) =>
        BlocProvider<AccountCubit>.value(
          value: context.read<AccountCubit>(),
          child: const LoginScreen(),
        )),
  ),
  GoRoute(
      path: ApplicationRouteName.learn,
      name: ApplicationRouteName.learn,
      builder: ((BuildContext context, GoRouterState state) =>
          MultiBlocProvider(
            providers: [
              BlocProvider<CoursesCubit>.value(
                value: context.read<CoursesCubit>(),
              ),
              BlocProvider(create: (ctx) => LessonsCubit()),
              BlocProvider<AccountCubit>.value(
                value: context.read<AccountCubit>(),
                child: const LoginScreen(),
              )
            ],
            child: const LearnPage(),
          )))
]);
