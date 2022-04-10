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
          statusBarIconBrightness: Brightness.light,
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
                          physics: const NeverScrollableScrollPhysics(),
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
                                          Border.all(color: whiteColorShade5)),
                                  child: const Icon(
                                    Icons.person,
                                    color: whiteColorShade5,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30.h,
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
                                  final Space data =
                                      Space.fromJson(snapshot.data!['space']);
                                  int? totalRating = 0;

                                  if (data.spaceOwner != null) {
                                    for (Appliances appliance
                                        in data.appliances!) {
                                      totalRating =
                                          int.tryParse(appliance.rating!)! *
                                                  int.tryParse(
                                                      appliance.quantity!)! +
                                              totalRating!;
                                    }
                                  }

                                  if (data.spaceOwner == null) {
                                    return Material(
                                        type: MaterialType.transparency,
                                        child: InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context,
                                                  RouteGenerator
                                                      .configureSpaceStaff);
                                            },
                                            child:
                                                const Text("Configure space")));
                                  } else {
                                    return Container(
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
                                                  Expanded(
                                                    child: Text(
                                                      "Your ${data.type}:",
                                                      style: CustomTheme
                                                              .mediumText(
                                                                  context)
                                                          .copyWith(
                                                              color:
                                                                  whiteColorShade2,
                                                              fontFamily: GoogleFonts
                                                                      .adamina()
                                                                  .fontFamily,
                                                              fontSize: 25.sp),
                                                    ),
                                                  ),
                                                  Material(
                                                    type: MaterialType
                                                        .transparency,
                                                    child: InkWell(
                                                      onTap: () {
                                                        ref
                                                            .watch(spaceProvider
                                                                .notifier)
                                                            .state = data;
                                                        Navigator.pushNamed(
                                                            context,
                                                            RouteGenerator
                                                                .editSpaceStaff);
                                                      },
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Icon(
                                                          Icons.edit,
                                                          color:
                                                              whiteColorShade2,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 5.h),
                                              child: Text(
                                                totalRating.toString(),
                                                style: CustomTheme.largeText(
                                                        context)
                                                    .copyWith(
                                                        color: whiteColorShade2,
                                                        fontFamily: GoogleFonts
                                                                .adamina()
                                                            .fontFamily,
                                                        fontSize: 30.sp),
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
                                                  children: data.appliances!
                                                      .map((e) => Padding(
                                                        padding:  EdgeInsets.symmetric(horizontal: 5.w),
                                                        child: Column(
                                                              children: [
                                                                Text(
                                                                  e.quantity!,
                                                                  style: CustomTheme
                                                                          .mediumText(
                                                                              context)
                                                                      .copyWith(
                                                                          color:
                                                                              whiteColorShade2,
                                                                          fontFamily:
                                                                              GoogleFonts.adamina()
                                                                                  .fontFamily,
                                                                          fontSize:
                                                                              25.sp),
                                                                ),
                                                                Text(
                                                                  e.applianceName!,
                                                                  style: CustomTheme
                                                                          .normalText(
                                                                              context)
                                                                      .copyWith(
                                                                          color:
                                                                              whiteColorShade2,
                                                                          fontFamily:
                                                                              GoogleFonts.adamina()
                                                                                  .fontFamily,
                                                                          fontSize:
                                                                              15.sp),
                                                                )
                                                              ],
                                                            ),
                                                      ))
                                                      .toList(),
                                                )),
                                          ],
                                        ));
                                  }
                                }),
                            SizedBox(
                              height: 300.h,
                            ),
                            Center(
                                child: Text(
                              "Need Help?",
                              style: CustomTheme.normalText(context).copyWith(
                                  color: whiteColorShade2,
                                  fontFamily: GoogleFonts.adamina().fontFamily,
                                  fontSize: 15.sp),
                            )),
                            SizedBox(
                              height: 5.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 125.w),
                              child: Material(
                                type: MaterialType.transparency,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10.0),
                                  onTap: () {},
                                  child: Container(
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
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      child: Icon(
                                        Icons.chat,
                                        color: whiteColorShade2,
                                        size: 30.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
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
