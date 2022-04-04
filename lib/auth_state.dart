import 'package:ems/exports.dart';

enum AuthState {
  // ignore: constant_identifier_names
  LoggedIn,
  // ignore: constant_identifier_names
  LoggedOut,
}

void setLoginState(AuthState state) async {
  final userStateBox = await Hive.openBox<String>(StringConst.authStateBox);
  userStateBox.put(StringConst.authState, state.toString());
}
