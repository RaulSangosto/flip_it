import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/app/pages/my_app_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}
