import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kidora/src/data/data_source/local/user_local_storge.dart';
import 'package:kidora/src/data/dtos/account/account.dart';

import 'package:kidora/src/domain/repositories/account_repository.dart';

part './account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountStateInitial()) {
    checkUser();
  }
  loginByEmailPassword(
      String email, String password, Function handleSucess) async {
    emit(AccountStateLoginLoading());
    final responseHaveData = await AccountRepo().loginAction(email, password);

    if (responseHaveData is Map<String, dynamic>) {
      emit(AccountStateLoginFaile(state)..errorMessage = responseHaveData);
    } else {
      handleSucess();

      AccountLoginDtos infoUser = responseHaveData;
      UserLocalStorge.store.setString("refreshToken", infoUser.refreshToken);
      UserLocalStorge.store.setString("accessToken", infoUser.accessToken);

      emit(AccountStateLoginSuccess(state));
      await checkUser();
    }
  }

  checkUser() async {
    String refreshToken = UserLocalStorge.store.getString('refreshToken') ?? '';
    String accessToken = UserLocalStorge.store.getString('accessToken') ?? '';
    final AccountDtos? infoUser = await AccountRepo().getInfoUser(accessToken);

    await Future.delayed(const Duration(milliseconds: 50));
    infoUser == null ? () => {} : deleteStoreLearnFreeUser();
    emit(AccountStateLoaded(state)
      ..email = infoUser?.email ?? ""
      ..courses = infoUser?.courses ?? []
      ..resultUser = infoUser?.resultUser ?? []);
  }

  logoutUser() async {
    deleteStoreToken();
    emit(
      AccountStateLogout(state)
        ..email = ""
        ..courses = []
        ..resultUser,
    );
  }

  deleteStoreLearnFreeUser() {
    UserLocalStorge.store.remove("user_learn_local");
  }

  deleteStoreToken() {
    UserLocalStorge.store.remove("refreshToken");
    UserLocalStorge.store.remove("accessToken");
  }
}
