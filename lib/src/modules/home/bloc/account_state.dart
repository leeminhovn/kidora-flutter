part of './account_cubit.dart';

abstract class AccountState {
  String id = '';
  String email = '';
  List<String> courses = [];
  bool status = false;
  List<ResultDtos> resultUser = [];

  Map<String, dynamic> errorMessage = {};
  copy(AccountState state) {
    id = state.id;
    email = state.email;
    status = state.status;
    resultUser = state.resultUser;
    errorMessage = state.errorMessage;
  }
}

class AccountStateInitial extends AccountState {
  AccountStateInitial() : super();
}

class AccountStateLoading extends AccountState {
  AccountStateLoading() : super();
}

class AccountStateLoaded extends AccountState {
  AccountStateLoaded(AccountState state) {
    super.copy(state);
  }
}

class AccountStateLoginLoading extends AccountState {
  AccountStateLoginLoading() : super();
}

class AccountStateLoginFaile extends AccountState {
  AccountStateLoginFaile(state) {
    super.copy(state);
  }
}

class AccountStateLoginSuccess extends AccountState {
  AccountStateLoginSuccess(state) {
    super.copy(state);
  }
}

class AccountStateLogout extends AccountState {
  AccountStateLogout(state) {
    super.copy(state);
  }
}
