import 'package:ems/exports.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String totalSpaceDuration = StringConst.last7Days;

  final CollectionReference _fireStore =
      FirebaseFirestore.instance.collection('admin');
  final CollectionReference _spaceFireStore =
      FirebaseFirestore.instance.collection('spaces');
  int selectedIndex = 0;
  String selectedId = "all";
  final UserData? user =
      Hive.box<UserData>(StringConst.userDataBox).get(StringConst.userDataKey);
  List<DateTime> calculateDaysInterval(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  List<Color> colorList = [swatch18, swatch19, swatch20, swatch21, swatch22];
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
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        swatch9,
                        swatch9,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Text(
                          "PROFILE",
                          style: CustomTheme.semiLargeText(context).copyWith(
                              color: whiteColorShade2,
                              fontFamily: GoogleFonts.adamina().fontFamily,
                              fontSize: 23.sp),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Center(
                          child: Text(
                            "${box.get(StringConst.userDataKey)!.lastName ?? ''} ${box.get(StringConst.userDataKey)!.firstName ?? ''}",
                            style: CustomTheme.semiLargeText(context).copyWith(
                                color: whiteColorShade2,
                                fontFamily: GoogleFonts.adamina().fontFamily,
                                fontSize: 23.sp),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text("CHANGE PASSWORD"),
                      Expanded(
                        child: SizedBox(
                          height: 20.h,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: CustomBorderButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (contextM) {
                                  return SimpleDialog(
                                    title: Text(
                                      "Are you sure you want to logout?",
                                      style: CustomTheme.normalText(context),
                                    ),
                                    children: [
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: redColor,
                                                  border: Border.all(
                                                    color: borderColor,
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Material(
                                                    type: MaterialType
                                                        .transparency,
                                                    child: InkWell(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        onTap: () {
                                                          Navigator.pop(
                                                              contextM);
                                                          Navigator.of(context)
                                                              .pushAndRemoveUntil(
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            const Onboarding(),
                                                                  ),
                                                                  (Route<dynamic>
                                                                          route) =>
                                                                      false);
                                                        },
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      20.0.w,
                                                                  vertical:
                                                                      7.h),
                                                          child: Text(
                                                            "Yes",
                                                            style: CustomTheme
                                                                    .mediumText(
                                                                        context)
                                                                .copyWith(
                                                                    color:
                                                                        whiteColor),
                                                          ),
                                                        )))),
                                            Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: whiteColor,
                                                  border: Border.all(
                                                    color: darkGreyColor,
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Material(
                                                    type: MaterialType
                                                        .transparency,
                                                    child: InkWell(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        onTap: () {
                                                          Navigator.pop(
                                                              contextM);
                                                        },
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      20.0.w,
                                                                  vertical:
                                                                      7.h),
                                                          child: Text(
                                                            "No",
                                                            style: CustomTheme
                                                                .mediumText(
                                                                    context),
                                                          ),
                                                        )))),
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                });
                          },
                          color: redColor,
                          borderColor: whiteColor,
                          children: <Widget>[
                            Text(
                              "LOGOUT",
                              style: CustomTheme.normalText(context).copyWith(
                                color: whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ));
              });
        }));
  }
}
