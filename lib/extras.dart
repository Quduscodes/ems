import 'package:ems/exports.dart';

class Extras extends StatefulWidget {
  const Extras({Key? key}) : super(key: key);

  @override
  State<Extras> createState() => _ExtrasState();
}

class _ExtrasState extends State<Extras> {
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
                          "EXTRAS",
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
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                swatch17,
                                swatch17,
                              ],
                              begin: AlignmentDirectional.topStart,
                              end: AlignmentDirectional.bottomEnd,
                            ),
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
                                    horizontal: 20.w, vertical: 20.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          style: CustomTheme.mediumText(context)
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
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                swatch17,
                                swatch17,
                              ],
                              begin: AlignmentDirectional.topStart,
                              end: AlignmentDirectional.bottomEnd,
                            ),
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
                                    horizontal: 10.w, vertical: 15.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          style: CustomTheme.mediumText(context)
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
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                swatch17,
                                swatch17,
                              ],
                              begin: AlignmentDirectional.topStart,
                              end: AlignmentDirectional.bottomEnd,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouteGenerator.locations);
                              },
                              borderRadius: BorderRadius.circular(10.0),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 15.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Locations",
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
                                          style: CustomTheme.mediumText(context)
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
                      ),
                    ],
                  ),
                ));
              });
        }));
  }
}
