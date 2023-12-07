import 'package:kidora/src/data/api/app-client.dart';

abstract class BaseDataSource {
  AppClient appClient = AppClient();

  //some logic
  //  Box hiveBox = Hive.box(AppConstants.APP_NAME_ID);
  // BuildContext get context => AppManager.globalKeyRootMaterial.currentCon
}
