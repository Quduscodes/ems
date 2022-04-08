import 'package:ems/exports.dart';

part 'user_data.g.dart';

@HiveType(typeId: 1)
class UserData {
  @HiveField(0)
  String? userId;
  @HiveField(2)
  String? lastName;
  @HiveField(3)
  String? firstName;
  @HiveField(4)
  String? email;
  UserData({this.email, this.firstName, this.lastName, this.userId});
}
