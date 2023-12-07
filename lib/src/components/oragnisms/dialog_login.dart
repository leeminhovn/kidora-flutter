import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kidora/config/router_name.dart';
import 'package:kidora/src/components/molecules/custom_dialog.dart';
import 'package:kidora/src/components/oragnisms/buttons/shrugs_buttons.dart';
import 'package:kidora/src/modules/home/bloc/account_cubit.dart';

AlertDialog dialogLogin(BuildContext context) {
  return customDialog(
    context,
    [
      const SizedBox(
        height: 19,
      ),
      const Text(
        'Bé hãy đăng nhập tài khoản\nđể trải nghiệm những bài học thú vị\ncùng Kidora nhé!\n',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
      const SizedBox(
        height: 5,
      ),
      GreenButton(
          onTap: () {
            context.pop();
            context.push(ApplicationRouteName.login);
          },
          width: 170,
          text: 'Đăng nhập',
          height: 39),
      const SizedBox(
        height: 20,
      ),
      const Text(
        'Chưa có tài khoản?',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
      const SizedBox(
        height: 5,
      ),
      PinkButton(
          onTap: () {
            print('Mua tài khoản');
          },
          width: 170,
          text: 'Mua tài khoản',
          height: 39),
    ],
  );
}
