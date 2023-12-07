import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kidora/src/components/molecules/custom_dialog.dart';
import 'package:kidora/src/components/oragnisms/appBarCustom.dart';
import 'package:kidora/src/components/oragnisms/buttons/shrugs_buttons.dart';
import 'package:kidora/src/components/oragnisms/loading/loading_popup_white.dart';
import 'package:kidora/src/general/app_colors.dart';
import 'package:kidora/src/general/app_constant.dart';
import 'package:kidora/src/modules/home/bloc/account_cubit.dart';
import 'package:kidora/src/modules/home/bloc/courses_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  TextEditingController controllerTextEmail = TextEditingController();
  TextEditingController controllerTextPassword = TextEditingController();

  bool isShowPassword = false;
  bool isShowLoading = false;

  Map<String, dynamic> errorMessage = {
    "email": true,
    "password": true,
    "message": "",
  };

  void handleCheckEmail() {
    Map<String, dynamic> errorMessageNew = {
      "email": false,
      "message": "",
    };

    if (controllerTextEmail.text.isEmpty) {
      errorMessageNew["email"] = true;
      errorMessageNew["message"] = "Không được bỏ trống tên đăng nhập";
    }

    setState(() {
      errorMessage = {...errorMessage, ...errorMessageNew};
    });
  }

  void handleCheckPassword() {
    Map<String, dynamic> errorMessageNew = {
      "password": false,
      "message": "",
    };
    if (controllerTextPassword.text.isEmpty) {
      errorMessageNew["password"] = true;
      errorMessageNew["message"] = "Không được bỏ trống mật khẩu";
    }

    setState(() {
      errorMessage = {...errorMessage, ...errorMessageNew};
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    controllerTextEmail.addListener(() {
      handleCheckEmail();
    });
    controllerTextPassword.addListener(() {
      handleCheckPassword();
    });
    super.initState();
  }

  @override
  void dispose() {
    controllerTextPassword.dispose();
    controllerTextEmail.dispose();
    
    super.dispose();
  }

  handleLogin() {
    BlocProvider.of<AccountCubit>(context).loginByEmailPassword(
        controllerTextEmail.text,
        controllerTextPassword.text,
        () => BlocProvider.of<CoursesCubit>(context).resetCourse());
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double widthPopupContainer;
    if (screenWidth <= AppConstant.screenWidthMobile) {
      widthPopupContainer = 468 / 500 * screenWidth;
    } else if (screenWidth <= AppConstant.screenWidthTable) {
      widthPopupContainer = 625;
    } else {
      widthPopupContainer = 625;
    }

    return BlocListener<AccountCubit, AccountState>(
        listener: (BuildContext context, AccountState state) {
          if (state is AccountStateLoginLoading) {
            setState(() {
              isShowLoading = true;
            });
          } else if (state is AccountStateLoginFaile) {
            String message = state.errorMessage["message"];

            if (message == "Thieu tai khoan hoac mat khau") {
              message = "Thiếu tài khoản hoặc mật khẩu";
            }
            setState(() {
              errorMessage["message"] = message;
            });
          }
          if (state is AccountStateLoginSuccess) {
            context.pop();
          }
          if (state is! AccountStateLoginLoading && isShowLoading) {
            setState(() {
              isShowLoading = false;
            });
          }
        },
        child: SafeArea(
          child: Scaffold(
            appBar: const AppBarCustom(),
            body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/backgrounds/bg_cloud.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Center(
                  child: SingleChildScrollView(
                    child: Container(
                      width: widthPopupContainer,
                      padding: const EdgeInsets.only(top: 30, bottom: 20),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(25)),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Image.asset(
                          "assets/logo/kidora_logo.png",
                          width: 150,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Xin chào!',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        FractionallySizedBox(
                          widthFactor: 412 / 492,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      13), // Adjust the radius as per your needs
                                  border: Border.all(
                                    color: AppColors.color_ececec,
                                    width: 3,
                                  ),
                                ),
                                height: 54,
                                child: TextField(
                                  keyboardType: TextInputType.multiline,
                                  // cursorColor: AppColors.color_88C461,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.color_2f2f2f,
                                    fontWeight: FontWeight.w500,
                                    // letterSpacing: 0.4,
                                  ),
                                  // autofocus: true,
                                  controller: controllerTextEmail,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 15),
                                    border: InputBorder.none,
                                    hintText: 'Nhập tên đăng nhập',
                                    hintStyle: TextStyle(
                                        color: AppColors.color_c0c0c0,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      13), // Adjust the radius as per your needs
                                  border: Border.all(
                                    color: AppColors.color_ececec,
                                    width: 3,
                                  ),
                                ),
                                height: 54,
                                child: Stack(
                                  children: [
                                    TextField(
                                      obscureText: !isShowPassword,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.color_2f2f2f,
                                        fontWeight: FontWeight.w500,
                                        // letterSpacing: 0.4,
                                      ),
                                      // autofocus: true,
                                      controller: controllerTextPassword,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.only(left: 15),
                                        border: InputBorder.none,
                                        hintText: 'Nhập mật khẩu',
                                        hintStyle: TextStyle(
                                            color: AppColors.color_c0c0c0,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Positioned(
                                        right: 20,
                                        height: 50,
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: GestureDetector(
                                            onTap: () => setState(() {
                                              isShowPassword = !isShowPassword;
                                            }),
                                            child: Image.asset(
                                              'assets/images/components/${(!isShowPassword ? 'eye_slash' : "eye")}.png',
                                              width: 25,
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    errorMessage["message"],
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              (errorMessage['email'] ||
                                      errorMessage['password'])
                                  ? SilverButton(
                                      width: screenWidth <=
                                              AppConstant.screenWidthMobile
                                          ? 180 / 500 * screenWidth
                                          : 200,
                                      text: 'Đăng nhập',
                                      height: 39)
                                  : GreenButton(
                                      onTap: handleLogin,
                                      width: screenWidth <=
                                              AppConstant.screenWidthMobile
                                          ? 180 / 500 * screenWidth
                                          : 200,
                                      text: 'Đăng nhập',
                                      height: 39),
                              const SizedBox(
                                height: 15,
                              ),
                              GestureDetector(
                                onTap: () => showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        customDialog(context, [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            'Bé hãy liên hệ Kidora để được hỗ trợ nhé',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17),
                                          ),
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          FractionallySizedBox(
                                            widthFactor: 0.5,
                                            child: ConstrainedBox(
                                              constraints: const BoxConstraints(
                                                  maxWidth: 170),
                                              child: Image.asset(
                                                'assets/images/angle/angle_in_popup_forgot_pass.png',
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          BlueButtonIcon(
                                            onTap: () {},
                                            iconLeft: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5, left: 5),
                                              child: SvgPicture.asset(
                                                  'assets/images/components/ic_fb_contact.svg'),
                                            ),
                                            height: 39,
                                            text: 'Liên hệ qua Facebook',
                                            width: 232,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          GreenButtonIcon(
                                            onTap: () {},
                                            height: 39,
                                            iconLeft: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5),
                                              child: SvgPicture.asset(
                                                'assets/images/components/ic_phone_contact.svg',
                                              ),
                                            ),
                                            text: 'Hotline 0865592737',
                                            width: 232,
                                          ),
                                        ])),
                                child: Text(
                                  'Quên mật khẩu?',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: AppColors.color_88C461,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text.rich(TextSpan(
                                  children: [
                                    const TextSpan(
                                        text: "Chưa có tài khoản? ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                    TextSpan(
                                        text: "Mua tài khoản",
                                        style: TextStyle(
                                            color: AppColors.color_FF60D2,
                                            fontWeight: FontWeight.w700,
                                            decoration:
                                                TextDecoration.underline))
                                  ],
                                  style: const TextStyle(
                                    fontSize: 16,
                                  )))
                            ],
                          ),
                        )
                      ]),
                    ),
                  ),
                ),
                if (isShowLoading)
                  const Positioned.fill(child: LoadingPopupWhite())
              ],
            ),
          ),
        ));
  }
}
