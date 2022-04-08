import 'package:ems/exports.dart';

class StaffRoutePath extends StatelessWidget {
  const StaffRoutePath({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable:
            Hive.box<String>(StringConst.authStateBox).listenable(),
        builder: (context, Box<String> box, _) {
          if (box.get(StringConst.authState) != AuthState.LoggedIn.toString()) {
            return const StaffHomePage();
          } else {
            return const Splash();
          }
        });
  }
}
