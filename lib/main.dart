import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'src/app/pages/my_app_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  HydratedBlocOverrides.runZoned(
    () => SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      runApp(EasyLocalization(
        path: 'assets/translations',
        supportedLocales: const [Locale('en', 'US'), Locale('es', 'ES')],
        fallbackLocale: const Locale('en', 'US'),
        child: const MyApp(),
      ));
    }),
    storage: storage,
  );
}
