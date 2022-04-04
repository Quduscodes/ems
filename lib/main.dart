import 'dart:io';

import 'package:ems/exports.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  await Firebase.initializeApp();
  Hive.init(directory.path);
  SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp]);
  await Hive.openBox<String>(StringConst.authStateBox);
  await Hive.openBox<String>(StringConst.userStatusBox);
  runApp(const RouteSelector());
}
