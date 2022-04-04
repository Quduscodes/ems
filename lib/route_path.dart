import 'package:ems/exports.dart';

class RoutePath extends StatelessWidget {
  const RoutePath({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable:
            Hive.box<String>(StringConst.userStatusBox).listenable(),
        builder: (context, Box<String> box, _) {
          debugPrint(box.get(StringConst.userStatus));
          if (box.get(StringConst.userStatus) == UserStatus.Admin.toString()) {
            return const AdminRoutePath();
          } else if (box.get(StringConst.userStatus) ==
              UserStatus.Staff.toString()) {
            return const StaffRoutePath();
          } else {
            return const Splash();
          }
        });
  }
}
