import 'package:shared_preferences/shared_preferences.dart';

class UserLocalStorge {
  static late SharedPreferences store;

  Future<bool> load() async {
    try {
      store = await SharedPreferences.getInstance();
      // store.setString("email", value)
      return true;
    } catch (err) {
      return false;
    }
  }
}
