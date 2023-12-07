import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kidora/src/components/molecules/custom_dialog.dart';
import 'package:kidora/src/components/molecules/video_trailer.dart';
import 'package:kidora/src/components/oragnisms/buttons/shrugs_buttons.dart';
import 'package:kidora/src/data/dtos/courses/courses.dart';
import 'package:kidora/src/general/app_colors.dart';
import 'package:kidora/src/general/app_constant.dart';

class CourseItem extends StatefulWidget {
  final CourseDto courseDto;
  final Function clickButton;
  const CourseItem(
      {required this.courseDto, super.key, required this.clickButton});

  Widget middleWidgets() {
    return LayoutBuilder(
      builder: (context, constraints) => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: 121 / 361 * constraints.maxWidth,
                height: 37,
                child: wrapItemInfoInMiddle(
                  context: context,
                  text: 'Chưa mua',
                  isDot: true,
                )),
            // const SizedBox(
            //   width: 10,
            // ),
            SizedBox(
                width: 68.89 / 361 * constraints.maxWidth,
                height: 37,
                child: wrapItemInfoInMiddle(
                    context: context,
                    text: '${courseDto.lessons.length} bài',
                    isDot: false)),
            // const SizedBox(
            //   width: 10,
            // ),
            OrangeButton(
                // Mua khóa học
                text: 'Xem chi tiết',
                textFontSize: 17,
                onTap: () {
                  clickButton();
                },
                width: 156 / (361) * constraints.maxWidth,
                height: 37)
          ]),
    );
  }

  Widget wrapItemInfoInMiddle(
      {String text = '',
      required BuildContext context,
      bool isDot = false,
      Color? color}) {
    final Color generalColor = color ?? AppColors.color_f46700;

    final double screenWidth = MediaQuery.of(context).size.width;
    final double fontSize;

    if (screenWidth <= AppConstant.screenWidthMobile) {
      fontSize = 14;
    } else if (screenWidth <= AppConstant.screenWidthTable) {
      fontSize = 15;
    } else {
      fontSize = 17;
    }
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.color_f4f5f9,
      ),
      child: (isDot)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.circle,
                  color: generalColor,
                  size: fontSize / 2,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    WidgetSpan(
                      child: SizedBox(
                          width: fontSize /
                              3), // Add the desired width between TextSpans
                    ),
                    TextSpan(
                      text: text,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: fontSize,
                          color: generalColor,
                          fontFamily: 'Quicksand'),
                    )
                  ]),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize,
                      color: generalColor,
                      fontFamily: 'Quicksand'),
                ),
              ],
            ),
    );
  }

  @override
  // ignore: library_private_types_in_public_api
  _CourseItemState createState() =>
      // ignore: no_logic_in_create_state
      _CourseItemState(courseDto: courseDto, middleWidgets: middleWidgets);
}

class _CourseItemState extends State<CourseItem> with TickerProviderStateMixin {
  final CourseDto courseDto;
  final Widget Function() middleWidgets;
  final int idVideoPlay = Random().nextBool() ? 839199639 : 839199639;
  _CourseItemState({required this.courseDto, required this.middleWidgets});
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    print(widget.courseDto.id);
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1, end: 1.04).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void handleHover(bool isHover) {
    if (isHover) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final String device;
    if (screenWidth <= 725) {
      device = 'mobile';
    } else if (screenWidth <= AppConstant.screenWidthTable + 100) {
      device = 'table';
    } else {
      device = "pc";
    }
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return InkWell(
        onTap: () {},
        onHover: (bool isHover) {
          handleHover(isHover);
        },
        child: ScaleTransition(
          scale: _animation,
          child: Container(
            padding: const EdgeInsets.all(13),
            width: device == "mobile"
                ? double.infinity
                : device == "table"
                    ? constraints.maxWidth / 2 - 10
                    : constraints.maxWidth / 3 - 14,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(color: AppColors.color_00001A, blurRadius: 10)
            ], color: AppColors.white, borderRadius: BorderRadius.circular(13)),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: top(courseDto)),
              middleWidgets(),
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: double.infinity,
                  height: 2,
                  color: AppColors.color_f2f2f2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: bottom(),
              )
            ]),
          ),
        ),
      );
    });
  }

  List<Widget> top(CourseDto dataInfoCOurse) {
    Widget outerTrailer() {
      return SizedBox(
        width: double.infinity,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.color_906cff,
                boxShadow: [
                  BoxShadow(
                      color: AppColors.color_af95fe, offset: const Offset(0, 4))
                ],
                borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(
                horizontal: 8, vertical: 8 * (16 / 9)),
            child: VideoTrailer(idVideoPlay),
          ),
        ),
      );
    }

    AlertDialog diglogCustom(BuildContext context) {
      return customDialog(context, [
        const SizedBox(
          height: 5,
        ),
        Text(
          dataInfoCOurse.title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 15,
        ),
        outerTrailer(),
        const SizedBox(
          height: 15,
        ),
        Text(
          dataInfoCOurse.description,
          style: TextStyle(
              color: AppColors.color_7d7d7d,
              fontSize: 14,
              fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 15,
        ),
        PinkButton(
            onTap: () => print('buy ourse'),
            width: 170,
            text: 'Mua khoá học',
            height: 39)
      ]);
    }

    return [
      Flexible(
        child: LayoutBuilder(builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 28),
                  width: constraints.maxWidth,
                  height: 111 / 223 * constraints.maxWidth,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      "${AppConstant.baseApiUrl}images/khoahoc/${courseDto.image}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 15,
                  child: GestureDetector(
                    onTap: () => showDialog(
                        context: context,
                        builder: (context) => diglogCustom(context)),
                    child: Container(
                      width: 140 / 167 * constraints.maxWidth,
                      height: 30,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10, color: AppColors.color_00002A)
                        ],
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.white,
                      ),
                      child: FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 10),
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(children: [
                              SvgPicture.asset(
                                  'assets/images/components/play_you_pink.svg'),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Video Giới thiệu',
                                style: TextStyle(
                                    color: AppColors.color_FF60D2,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
      Flexible(
        fit: FlexFit.tight,
        child: Column(
          children: [
            Text(
              courseDto.title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              courseDto.description,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )
          ],
        ),
      )
    ];
  }

  List<Widget> bottom() {
    return [
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: RichText(
          textAlign: TextAlign.center,
          textWidthBasis: TextWidthBasis.parent,
          text: TextSpan(children: [
            WidgetSpan(
                child: Text(courseDto.rating.toString(),
                    style: TextStyle(
                        fontSize: 16,
                        color: AppColors.color_7d7d7d,
                        fontWeight: FontWeight.w500))),
            WidgetSpan(
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 2, left: 2),
                    child:
                        Image.asset('assets/images/components/star_icon.png'))),
          ]),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: RichText(
          textAlign: TextAlign.center,
          textWidthBasis: TextWidthBasis.parent,
          text: TextSpan(children: [
            WidgetSpan(
                child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Image.asset(
                      'assets/images/avatar/avatarPaidUser.png',
                      width: 20,
                    ))),
            WidgetSpan(
                child: Text("${courseDto.users} người học",
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColors.color_7d7d7d,
                        fontWeight: FontWeight.w500))),
          ]),
        ),
      ),
    ];
  }
}

class CourseItemNotBought extends CourseItem {
  const CourseItemNotBought(
      {super.key, required super.courseDto, required super.clickButton});
}

class CourseItemBought extends CourseItem {
  const CourseItemBought(
      {super.key, required super.courseDto, required super.clickButton});

  @override
  Widget middleWidgets() {
    return SizedBox(
      height: 39,
      child: LayoutBuilder(
        builder: (context, constraints) => Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: 121 / 361 * constraints.maxWidth,
                  child: wrapItemInfoInMiddle(
                      text: 'Đã mua',
                      context: context,
                      isDot: true,
                      color: AppColors.color_71ae49)),
              // const SizedBox(
              //   width: 10,
              // ),
              SizedBox(
                  width: 80 / 361 * constraints.maxWidth,
                  child: wrapItemInfoInMiddle(
                      context: context,
                      text: '${courseDto.lessons.length} bài',
                      isDot: false,
                      color: AppColors.color_71ae49)),
              // const SizedBox(
              //   width: 10,
              // ),
              GreenButton(
                  // Mua khóa học
                  text: 'Học ngay',
                  textFontSize: 17,
                  onTap: () {
                    clickButton();
                  },
                  width: 150 / (361) * constraints.maxWidth,
                  height: 37)
            ]),
      ),
    );
  }
}

class CourseItemIscomming extends CourseItem {
  const CourseItemIscomming(
      {super.key, required super.courseDto, required super.clickButton});
  @override
  Widget middleWidgets() {
    return LayoutBuilder(
      builder: (context, constraints) => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: wrapItemInfoInMiddle(
              text: 'Sắp khai giảng',
              context: context,
              isDot: true,
              color: AppColors.color_906CFF,
            )),
            const SizedBox(
              width: 10,
            ),
            PurpleButton(
                // Mua khóa học
                text: 'Xem chi tiết',
                textFontSize: 17,
                onTap: () {
                  clickButton();
                },
                width: constraints.maxWidth / 2,
                height: 37),
          ]),
    );
  }
}
