import 'package:ems/exports.dart';

class ConfigureSpaceStaff extends StatefulWidget {
  const ConfigureSpaceStaff({Key? key}) : super(key: key);

  @override
  State<ConfigureSpaceStaff> createState() => _ConfigureSpaceStaff();
}

class _ConfigureSpaceStaff extends State<ConfigureSpaceStaff> {
  final CollectionReference _fireStore =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _spacesFireStore =
      FirebaseFirestore.instance.collection('spaces');
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          // For Android.
          // Use [light] for white status bar and [dark] for black status bar.
          statusBarIconBrightness: Brightness.dark,
          // For iOS.
          // Use [dark] for white status bar and [light] for black status bar.
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
        child: Consumer(builder: (context, WidgetRef ref, child) {
          return ValueListenableBuilder(
              valueListenable:
                  Hive.box<UserData>(StringConst.userDataBox).listenable(),
              builder: (context, Box<UserData> box, _) {
                return Scaffold(
                    body: SafeArea(
                        child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      Text("Add Space"),
                      Expanded(
                          child: ListView(
                        shrinkWrap: true,
                        children: [
                          CustomAuthButton(
                            text: "Login",
                            onPressed: () {
                              _fireStore
                                  .doc(box.get(StringConst.userDataKey)!.userId)
                                  .update({
                                "space": {
                                  "type": "room",
                                  "noOfFan": "6",
                                  "noOfAc": "2",
                                  "noOfBulb": "6",
                                  "noOfFridge": "1",
                                }
                              });
                            },
                          ),
                        ],
                      ))
                    ],
                  ),
                )));
              });
        }));
  }
}
