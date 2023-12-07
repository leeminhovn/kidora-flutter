import 'package:kidora/src/data/api/endpoint.dart';
import 'package:kidora/src/data/data_source/account.dart';
import 'package:kidora/src/data/dtos/account/account.dart';


class AccountRepo {
  Future<AccountDtos?> getInfoUser(String accessToken) {
    return AccountDataSource().getInfoUser(accessToken);
  }

  Future<dynamic> loginAction(String email, String password) {
    return AccountDataSource().loginAccount(email, password);
  }
}
