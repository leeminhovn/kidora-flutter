import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kidora/config/route_config.dart';
import 'package:kidora/src/data/data_source/local/user_local_storge.dart';
import 'package:kidora/src/modules/home/bloc/account_cubit.dart';
import 'package:appspector/appspector.dart';
import 'package:kidora/src/modules/home/bloc/courses_cubit.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await UserLocalStorge().load();
  runAppSpector();
  runApp(const KidoraApp());
}

void runAppSpector() {
  var config = Config()
    ..androidApiKey = "android_MjJmYThjYzAtOGMyOC00OTNkLWE1NTYtMTA0MDJkMDg2NmNj"
    ..metadata = {MetadataKeys.deviceName: "Kha Clone Kidora"};

  AppSpectorPlugin.run(config);
}

class KidoraApp extends StatefulWidget {
  const KidoraApp({super.key});

  @override
  State<KidoraApp> createState() => _KidoraAppState();
}

class _KidoraAppState extends State<KidoraApp> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => AccountCubit()),
        BlocProvider(create: (ctx) => CoursesCubit()),
      ],
      child: MaterialApp.router(
        routerConfig: routerConfig,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "Quicksand"),
      ),
    );
  }
}
