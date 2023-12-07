import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kidora/config/router_name.dart';
import 'package:kidora/src/components/molecules/custom_dialog.dart';
import 'package:kidora/src/components/oragnisms/buttons/shrugs_buttons.dart';
import 'package:kidora/src/components/oragnisms/dialog_login.dart';
import 'package:kidora/src/general/app_colors.dart';
import 'package:kidora/src/general/app_images.dart';
import 'package:kidora/src/modules/home/bloc/account_cubit.dart';
import 'package:kidora/src/modules/home/bloc/courses_cubit.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  const AppBarCustom({super.key}) : preferredSize = const Size.fromHeight(53);

  @override
  Widget build(BuildContext context) {
    bool isDashboardPage = GoRouter.of(context).location.endsWith('dasboad');

    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AppBar(
        actions: [
          isDashboardPage
              ? BlocBuilder<AccountCubit, AccountState>(
                  buildWhen: (previous, current) {
                  return previous.email != current.email;
                }, builder: (context, state) {
                  if (state.email == '') {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: GreenButton(
                          text: 'Đăng nhập',
                          textFontSize: 16,
                          width: 150.72,
                          height: 150.72 * 0.24,
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => dialogLogin(context));
                          }),
                    );
                  } else {
                    return InfoUserLogin(state.email, state.courses);
                  }
                })
              : GestureDetector(
                  onTap: () {
                    print('quay lai');
                    // context.pop();
                    GoRouter.of(context).pop();
                    // print(context.watch<AccountCubit>().close());
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Quay lại',
                        style: TextStyle(
                            color: AppColors.color_88C461,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.color_c0c0c0,
                                  offset: const Offset(0, 3))
                            ]),
                        child: SvgPicture.asset(
                          'assets/icons/arrow_right_green.svg',
                          width: 30,
                        ),
                      )
                    ],
                  ),
                ),
        ],
        elevation: 0,
        backgroundColor: AppColors.white,
        shadowColor: Colors.transparent,
        leadingWidth: 110,
        leading: Image.asset(
          AppImages.logoKidora,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class InfoUserLogin extends StatefulWidget {
  final String email;
  final List<String> courses;
  const InfoUserLogin(this.email, this.courses, {super.key});
  @override
  State<StatefulWidget> createState() => _InfoUserLogin();
}

class _InfoUserLogin extends State<InfoUserLogin> {
  bool isOpen = false;
  late OverlayEntry entry;
  @override
  void initState() {
    super.initState();
  }

  void handleClickUserInfo() {
    if (!isOpen) {
      showOverlay(context);
    } else {
      entry.remove();
    }
    setState(() {
      isOpen = !isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.courses);
    print(widget.email);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: GestureDetector(
        onTap: handleClickUserInfo,
        child: Row(children: [
          const SizedBox(
            width: 20,
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 80),
            child: Text(
              widget.email,
              maxLines: 1,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Image.asset(widget.courses.isNotEmpty
              ? 'assets/images/avatar/avatarPaidUser.png'
              : 'assets/images/avatar/image_guest_user.png'),
          const SizedBox(
            width: 9,
          ),
          AnimatedRotation(
            duration: const Duration(milliseconds: 200),
            turns: isOpen ? -1 / 2 : 0.0,
            child: Image.asset(
              'assets/images/components/icon_arrow_down_green.png',
              width: 17,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
        ]),
      ),
    );
  }

  void showOverlay(context) {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    Offset? offset = renderBox.localToGlobal(Offset.zero);
    double xPosition = offset.dx;
    double yPosition = offset.dy;

    entry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
              child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: handleClickUserInfo,
          )),
          Positioned(
              left: xPosition,
              top: yPosition + size.height + 4,
              width: size.width,
              child: buildOverlay()),
        ],
      ),
    );
    overlay.insert(entry);
  }

  handleClickLogout() {
    BlocProvider.of<CoursesCubit>(context).resetCourse();
    Future.delayed(const Duration(milliseconds: 500),
        () => {BlocProvider.of<AccountCubit>(context).logoutUser()});
  }

  Widget buildOverlay() {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: 49,
        padding: const EdgeInsets.only(bottom: 18),
        clipBehavior: Clip.none,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(blurRadius: 9.0, color: AppColors.color_00002A),
              BoxShadow(offset: const Offset(0, -7), color: AppColors.white),
            ],
            color: AppColors.white,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(17),
                bottomRight: Radius.circular(17))),
        child: GestureDetector(
          onTap: () {
            handleClickLogout();
            handleClickUserInfo();
          },
          child: Center(
              child: Text(
            'Đăng xuất',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.color_88C461,
                decoration: TextDecoration.underline),
          )),
        ),
      ),
    );
  }
}
