import 'package:ems/exports.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final CollectionReference _fireStore =
      FirebaseFirestore.instance.collection('admin');
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
        child: ValueListenableBuilder(
            valueListenable:
                Hive.box<UserData>(StringConst.userDataBox).listenable(),
            builder: (context, Box<UserData> box, _) {
              return Scaffold(
                  body: SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Welcome ${box.get(StringConst.userDataKey)!.lastName ?? ''},",
                                  style: CustomTheme.semiLargeText(context)
                                      .copyWith(
                                          color: darkGreenTextColor,
                                          fontFamily:
                                              GoogleFonts.adamina().fontFamily,
                                          fontSize: 25.sp),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 7.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: darkGreenTextColor)),
                                  child: const Icon(
                                    Icons.person,
                                    color: darkGreenTextColor,
                                  ),
                                )
                              ],
                            ),
                            StreamBuilder<DocumentSnapshot>(
                                stream: _fireStore
                                    .doc(
                                        box.get(StringConst.userDataKey)!.email)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  List space = snapshot.data!['space'] as List;
                                  if (!snapshot.hasData) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                primaryColor),
                                      ),
                                    );
                                  }
                                  if (snapshot.hasError) {
                                    return const Text("Something went wrong");
                                  }
                                  if (!snapshot.data!.exists) {
                                    return const Text("Start Chat");
                                  }
                                  return Text(space.length.toString());
                                })
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ));
            }));
  }
}
