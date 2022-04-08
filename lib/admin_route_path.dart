import 'package:ems/exports.dart';

class AdminRoutePath extends StatelessWidget {
  const AdminRoutePath({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable:
            Hive.box<String>(StringConst.authStateBox).listenable(),
        builder: (context, Box<String> box, _) {
          debugPrint(box.get(StringConst.authState));
          if (box.get(StringConst.authState) != AuthState.LoggedIn.toString()) {
            return const AdminHomePage();
          } else {
            return const Splash();
          }
        });
  }
}
