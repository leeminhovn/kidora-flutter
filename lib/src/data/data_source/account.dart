import 'package:dio/dio.dart';
import 'package:kidora/src/components/utils/printColor.dart';
import 'package:kidora/src/data/api/app-client.dart';
import 'package:kidora/src/data/api/endpoint.dart';
import 'package:kidora/src/data/baseDataSource/base_data_source.dart';
import 'package:kidora/src/data/dtos/account/account.dart';

class AccountDataSource extends BaseDataSource {
  Future<AccountDtos?> getInfoUser(String accessToken) async {
    Response response = await AppClient()
        .getDioAuth(endPoint: Endpoint.getInfoUser, accessToken: accessToken);
    if (response.data['code'] == 1) {
      return AccountDtos.fromJson(response.data['data']);
    } else {
      return null;
    }
  }

  Future<dynamic> loginAccount(String email, String password) async {
    final Response response;
    try {
      response = await AppClient().postDio(Endpoint.login,
          data: {"email": email, "password": password});

      if (response.data['code'] == 1) {
        return AccountLoginDtos.fromJson(response.data['data']);
      }
    } on DioException catch (err) {
      return err.response!.data;
    }
  }
}
