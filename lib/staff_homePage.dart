import 'package:ems/exports.dart';
import 'package:ems/space_data.dart';

class StaffHomePage extends StatefulWidget {
  const StaffHomePage({Key? key}) : super(key: key);

  @override
  State<StaffHomePage> createState() => _StaffHomePageState();
}

class _StaffHomePageState extends State<StaffHomePage> {
  final CollectionReference _fireStore =
      FirebaseFirestore.instance.collection('users');
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
                                  child: Icon(
                                    Icons.person,
                                    color: darkGreenTextColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            StreamBuilder<DocumentSnapshot>(
                                stream: _fireStore
                                    .doc(box
                                        .get(StringConst.userDataKey)!
                                        .userId)
                                    .snapshots(),
                                builder: (context, snapshot) {
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
                                  final SpaceData data = SpaceData.fromJson(
                                      snapshot.data!['space']);
                                  return data.type!.isEmpty
                                      ? Material(
                                          type: MaterialType.transparency,
                                          child: InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context,
                                                    RouteGenerator
                                                        .configureSpaceStaff);
                                              },
                                              child: Text("Configure space")))
                                      : Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: darkGreenTextColor),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w,
                                                    vertical: 10.h),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("Your ${data.type}:"),
                                                    Icon(Icons.settings)
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w,
                                                    vertical: 10.h),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text(data.noOfFan!),
                                                        Text("Fans")
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(data.noOfAc!),
                                                        Text("Air Conditioners")
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(data.noOfBulb!),
                                                        Text("Bulbs")
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(data
                                                            .noOfTelevision!),
                                                        Text("Televisions")
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ));
                                })
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ));
            }));
  }
}
