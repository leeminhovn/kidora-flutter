import 'package:flutter/material.dart';
import 'package:kidora/src/general/app_colors.dart';

class NavigationBarKidora extends StatelessWidget {
  final int page;
  final void Function(int) goToPage;
  const NavigationBarKidora(
      {super.key, required this.page, required this.goToPage});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.color_88C461,
      height: 59,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        itemBar(page == 0, () => goToPage(0), "Trang chủ",
            MediaQuery.of(context).size),
        itemBar(page == 1, () => goToPage(1), "Khoá học của bé",
            MediaQuery.of(context).size)
      ]),
    );
  }

  Widget itemBar(
      bool isActive, void Function() onClick, String title, Size sizeScreen) {
    final TextStyle textStyleAll = TextStyle(
        color: isActive ? AppColors.color_88C461 : AppColors.color_F4F5FB,
        fontSize: 24,
        fontWeight: FontWeight.bold);

    return Container(
      constraints: BoxConstraints(maxWidth: sizeScreen.width / 2 * 0.9),
      width: double.infinity,
      padding: const EdgeInsets.only(top: 23),
      child: GestureDetector(
        onTap: () => onClick(),
        child: Container(
          decoration: BoxDecoration(
            color: isActive ? AppColors.color_F4F5FB : Colors.transparent,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          height: double.infinity,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              if (isActive)
                Positioned(
                    left: -45,
                    bottom: -6,
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.color_F4F5FB,
                              offset: const Offset(14, 1),
                            ),
                          ],
                          color: AppColors.color_88C461,
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.elliptical(10, 10))),
                      width: 35,
                      height: 14,
                    )),
              if (isActive)
                Positioned(
                    right: -45,
                    bottom: -6,
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.color_F4F5FB,
                              // color: Colors.red,
                              offset: const Offset(-14, 1),
                            ),
                          ],
                          color: AppColors.color_88C461,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.elliptical(10, 10))),
                      width: 35,
                      height: 14,
                    )),
              Center(
                child: FittedBox(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: textStyleAll,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// Widget itemBarDesktop () {

// }