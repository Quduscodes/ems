import 'package:ems/exports.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final CollectionReference _fireStore =
      FirebaseFirestore.instance.collection('admin');
  final CollectionReference _spaceFireStore =
      FirebaseFirestore.instance.collection('spaces');

  final UserData? user =
      Hive.box<UserData>(StringConst.userDataBox).get(StringConst.userDataKey);
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
                    body: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        gradientGreen1,
                        gradientGreen2,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
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
                                          color: whiteColorShade2,
                                          fontFamily:
                                              GoogleFonts.adamina().fontFamily,
                                          fontSize: 25.sp),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 7.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border:
                                          Border.all(color: whiteColorShade2)),
                                  child: const Icon(
                                    Icons.person,
                                    color: whiteColorShade2,
                                  ),
                                )
                              ],
                            ),
                            StreamBuilder<QuerySnapshot>(
                                stream: _spaceFireStore.snapshots(),
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
                                  if (snapshot.data!.size == 0) {
                                    return const Text("No Space yet");
                                  }
                                  List space = snapshot.data!.docs;
                                  List<Space> spaces = space
                                      .map((e) =>
                                          Space.fromJson(e.data()['space']))
                                      .toList();
                                  int? totalRating = 0;
                                  for (Space space in spaces) {
                                    for (Appliances appliance
                                        in space.appliances!) {
                                      totalRating =
                                          int.tryParse(appliance.rating!)! *
                                                  int.tryParse(
                                                      appliance.quantity!)! +
                                              totalRating!;
                                    }
                                  }
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 10.h),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.white.withOpacity(0.5),
                                          Colors.white.withOpacity(0.2)
                                        ],
                                        begin: AlignmentDirectional.topStart,
                                        end: AlignmentDirectional.bottomEnd,
                                      ),
                                      border: Border.all(
                                          width: 1.5,
                                          color: Colors.white.withOpacity(0.2)),
                                      color: whiteColor.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Total estimate",
                                          style: CustomTheme.normalText(context)
                                              .copyWith(
                                            color: whiteColorShade2,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          totalRating.toString(),
                                          style: CustomTheme.mediumText(context)
                                              .copyWith(
                                                  color: whiteColorShade2,
                                                  fontSize: 25.sp),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                            StreamBuilder<DocumentSnapshot>(
                                stream: _fireStore
                                    .doc(box
                                        .get(StringConst.userDataKey)!
                                        .userId!)
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
                                    return const Text("No Space yet");
                                  }
                                  List space = snapshot.data!["space"] as List;
                                  List<Space> spaces = space
                                      .map((e) => Space.fromJson(e))
                                      .toList();

                                  if (spaces.isEmpty) {
                                    return InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              RouteGenerator.addAdminSpace);
                                        },
                                        child: const Icon(Icons.add_rounded));
                                  }
                                  int? totalRating = 0;
                                  for (Space space in spaces) {
                                    for (Appliances appliance
                                        in space.appliances!) {
                                      totalRating =
                                          int.tryParse(appliance.rating!)! *
                                                  int.tryParse(
                                                      appliance.quantity!)! +
                                              totalRating!;
                                    }
                                  }
                                  return Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 10.h),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.white.withOpacity(0.5),
                                              Colors.white.withOpacity(0.2)
                                            ],
                                            begin:
                                                AlignmentDirectional.topStart,
                                            end: AlignmentDirectional.bottomEnd,
                                          ),
                                          border: Border.all(
                                              width: 1.5,
                                              color: Colors.white
                                                  .withOpacity(0.2)),
                                          color: whiteColor.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              "Total estimate",
                                              style: CustomTheme.normalText(
                                                      context)
                                                  .copyWith(
                                                color: whiteColorShade2,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Text(
                                              totalRating.toString(),
                                              style: CustomTheme.mediumText(
                                                      context)
                                                  .copyWith(
                                                      color: whiteColorShade2,
                                                      fontSize: 25.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: spaces.length,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                    onTap: () {},
                                                    child: Text(spaces[index]
                                                        .type
                                                        .toString())),
                                                InkWell(
                                                    onTap: () {
                                                      ref
                                                          .watch(
                                                              spaceListProvider
                                                                  .notifier)
                                                          .state = spaces;
                                                      ref
                                                          .watch(indexProvider
                                                              .notifier)
                                                          .state = index;
                                                      ref
                                                              .watch(
                                                                  spaceProvider
                                                                      .notifier)
                                                              .state =
                                                          spaces[index];
                                                      Navigator.pushNamed(
                                                          context,
                                                          RouteGenerator
                                                              .editAdminSpace);
                                                    },
                                                    child:
                                                        const Icon(Icons.edit))
                                              ],
                                            );
                                          }),
                                      InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                RouteGenerator.addAdminSpace);
                                          },
                                          child: const Icon(Icons.add_rounded))
                                    ],
                                  );
                                }),
                            Container(
                              width: 50.w,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withOpacity(0.5),
                                    Colors.white.withOpacity(0.2)
                                  ],
                                  begin: AlignmentDirectional.topStart,
                                  end: AlignmentDirectional.bottomEnd,
                                ),
                                border: Border.all(
                                    width: 1.5,
                                    color: Colors.white.withOpacity(0.2)),
                                color: whiteColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Material(
                                type: MaterialType.transparency,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RouteGenerator.appliances);
                                  },
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 10.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Appliances",
                                          style: CustomTheme.mediumText(context)
                                              .copyWith(
                                                  color: whiteColorShade2,
                                                  fontSize: 25.sp),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "View All",
                                              style: CustomTheme.mediumText(
                                                      context)
                                                  .copyWith(
                                                      color: whiteColorShade2,
                                                      fontSize: 15.sp),
                                            ),
                                            Icon(
                                              Icons.navigate_next,
                                              color: whiteColorShade2,
                                              size: 15.sp,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 50.w,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withOpacity(0.5),
                                    Colors.white.withOpacity(0.2)
                                  ],
                                  begin: AlignmentDirectional.topStart,
                                  end: AlignmentDirectional.bottomEnd,
                                ),
                                border: Border.all(
                                    width: 1.5,
                                    color: Colors.white.withOpacity(0.2)),
                                color: whiteColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Material(
                                type: MaterialType.transparency,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RouteGenerator.helpAndSupport);
                                  },
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 10.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Help & Support",
                                          style: CustomTheme.mediumText(context)
                                              .copyWith(
                                                  color: whiteColorShade2,
                                                  fontSize: 25.sp),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "View All",
                                              style: CustomTheme.mediumText(
                                                      context)
                                                  .copyWith(
                                                      color: whiteColorShade2,
                                                      fontSize: 15.sp),
                                            ),
                                            Icon(
                                              Icons.navigate_next,
                                              color: whiteColorShade2,
                                              size: 15.sp,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ));
              });
        }));
  }
}
