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
  Hive.registerAdapter(UserDataAdapter());

  await Hive.openBox<String>(StringConst.authStateBox);
  await Hive.openBox<String>(StringConst.userStatusBox);
  await Hive.openBox<UserData>(StringConst.userDataBox);

  runApp(const RouteSelector());
}
// for (var word in all) {
// if (word.length >= 3) {
// reverseString(word) == null ? null : print(reverseString(word));
// }
// }
// String? reverseString(String word) {
//   String newWord = "";
//   for (int i = word.length; i > 0; i--) {
//     newWord = newWord + word[i - 1];
//   }
//   if (newWord.toLowerCase() == word.toLowerCase()) {
//     return newWord.toLowerCase();
//   } else {
//     return null;
//   }
// }
