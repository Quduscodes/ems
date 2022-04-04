import 'package:ems/exports.dart';

enum UserStatus {
  // ignore: constant_identifier_names
  Admin,
  // ignore: constant_identifier_names
  Staff,
}

void setUserStatus(UserStatus status) async {
  final userStateBox = await Hive.openBox<String>(StringConst.userStatusBox);
  userStateBox.put(StringConst.userStatus, status.toString());
}
