import 'package:ems/exports.dart';
import 'package:pie_chart/pie_chart.dart';

class Stats extends StatefulWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  String totalSpaceDuration = StringConst.last7Days;

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
                        height: 40.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 10.h),
                        child: Text(
                          "STATS",
                          style: CustomTheme.semiLargeText(context).copyWith(
                              color: whiteColorShade2,
                              fontFamily: GoogleFonts.adamina().fontFamily,
                              fontSize: 23.sp),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.all(0.0),
                          shrinkWrap: true,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Container(
                                padding: totalSpaceDuration ==
                                        StringConst.last7Days
                                    ? EdgeInsets.only(
                                        right: 25.w,
                                      )
                                    : totalSpaceDuration == StringConst.thisYear
                                        ? EdgeInsets.only(left: 25.w)
                                        : totalSpaceDuration ==
                                                StringConst.last30Days
                                            ? EdgeInsets.only(
                                                right: 25.h, left: 25.h)
                                            : null,
                                decoration: BoxDecoration(
                                    color: swatch17,
                                    borderRadius: BorderRadius.circular(25)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: totalSpaceDuration ==
                                              StringConst.last7Days
                                          ? EdgeInsets.symmetric(
                                              vertical: 10.h, horizontal: 25.w)
                                          : null,
                                      decoration: totalSpaceDuration ==
                                              StringConst.last7Days
                                          ? BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              border: Border.all(
                                                  color: swatch22, width: 3.0),
                                            )
                                          : null,
                                      child: Material(
                                        type: MaterialType.transparency,
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              totalSpaceDuration =
                                                  StringConst.last7Days;
                                            });
                                          },
                                          child: Text(
                                            "7 Days",
                                            textAlign: TextAlign.center,
                                            style: CustomTheme.mediumText(
                                                    context)
                                                .copyWith(
                                                    color: totalSpaceDuration ==
                                                            StringConst
                                                                .last7Days
                                                        ? swatch6
                                                        : swatch22),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                        padding: totalSpaceDuration ==
                                                StringConst.last30Days
                                            ? EdgeInsets.symmetric(
                                                vertical: 10.h,
                                                horizontal: 25.w)
                                            : null,
                                        decoration: totalSpaceDuration ==
                                                StringConst.last30Days
                                            ? BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                border: Border.all(
                                                    color: swatch22,
                                                    width: 3.0))
                                            : null,
                                        child: Material(
                                          type: MaterialType.transparency,
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                totalSpaceDuration =
                                                    StringConst.last30Days;
                                              });
                                            },
                                            child: Text(
                                              "30 Days",
                                              style: CustomTheme.mediumText(
                                                      context)
                                                  .copyWith(
                                                      color:
                                                          totalSpaceDuration ==
                                                                  StringConst
                                                                      .last30Days
                                                              ? swatch6
                                                              : swatch22),
                                            ),
                                          ),
                                        )),
                                    Container(
                                        padding: totalSpaceDuration ==
                                                StringConst.thisYear
                                            ? EdgeInsets.symmetric(
                                                vertical: 10.h,
                                                horizontal: 25.w)
                                            : null,
                                        decoration: totalSpaceDuration ==
                                                StringConst.thisYear
                                            ? BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                border: Border.all(
                                                    color: swatch22,
                                                    width: 3.0))
                                            : null,
                                        child: Material(
                                          type: MaterialType.transparency,
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                totalSpaceDuration =
                                                    StringConst.thisYear;
                                              });
                                            },
                                            child: Text(
                                              "365 Days",
                                              style: CustomTheme.mediumText(
                                                      context)
                                                  .copyWith(
                                                      color:
                                                          totalSpaceDuration ==
                                                                  StringConst
                                                                      .thisYear
                                                              ? swatch6
                                                              : swatch22),
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.w),
                                decoration:
                                    const BoxDecoration(color: swatch14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Suggestions to help you manage your electricity  ➡",
                                      style: CustomTheme.normalText(context)
                                          .copyWith(color: swatch15),
                                    ),
                                    SizedBox(
                                      height: 7.h,
                                    ),
                                    Text(
                                      "You can reduce up to 20% of energy by turning off appliances when not in use.",
                                      style: CustomTheme.normalText(context)
                                          .copyWith(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                            decoration: const BoxDecoration(
                                                color: swatch16),
                                            child: Material(
                                              type: MaterialType.transparency,
                                              child: InkWell(
                                                onTap: () {},
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 7.w,
                                                      vertical: 7.w),
                                                  child: Text(
                                                    "GOT IT",
                                                    style: CustomTheme
                                                            .normalText(context)
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ),
                                              ),
                                            )),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Container(
                                            decoration: const BoxDecoration(
                                                color: swatch3),
                                            child: Material(
                                                type: MaterialType.transparency,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 7.w,
                                                              vertical: 7.w),
                                                      child: Text(
                                                        "LEARN MORE",
                                                        style: CustomTheme
                                                                .normalText(
                                                                    context)
                                                            .copyWith(
                                                                color: Colors
                                                                    .white),
                                                      )),
                                                )))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              child: Text(
                                "ENERGY CONSUMPTION REPORT",
                                style: CustomTheme.normalText(context)
                                    .copyWith(color: swatch15),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              child: const Divider(
                                color: swatch15,
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              child: StreamBuilder<QuerySnapshot>(
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
                                    List<Space> spaces = [];
                                    int totalRating = 0;
                                    int unitRating = 0;
                                    DateTime now = DateTime.now();
                                    Map<String, dynamic> appliances = {};
                                    Map<String, double> dataMap = {};
                                    List<SubAppliance> subAppliances = [];
                                    if (totalSpaceDuration ==
                                        StringConst.last7Days) {
                                      spaces = space
                                          .map((e) =>
                                              Space.fromJson(e.data()['space']))
                                          .toList();
                                      for (Space mySpace in spaces) {
                                        for (Appliances appliance
                                            in mySpace.appliances!) {
                                          DateTime startDate = DateTime(
                                              now.year, now.month, now.day - 7);
                                          DateTime dateAdded = DateTime.parse(
                                              mySpace.dateAdded!);
                                          unitRating = totalRating +
                                              int.tryParse(appliance.rating!)! *
                                                  int.tryParse(
                                                      appliance.quantity!)!;
                                          if (dateAdded.isAfter(startDate)) {
                                            totalRating = totalRating +
                                                int.tryParse(
                                                        appliance.rating!)! *
                                                    int.tryParse(
                                                        appliance.quantity!)! *
                                                    24 *
                                                    now
                                                        .difference(dateAdded)
                                                        .inDays;
                                            if (appliances.containsKey(
                                                appliance.applianceName)) {
                                              appliances[
                                                      appliance.applianceName!]
                                                  ['quantity'] = int.parse(
                                                      appliance.quantity!) +
                                                  appliances[appliance
                                                          .applianceName!]
                                                      ["quantity"]!;
                                            } else {
                                              appliances[
                                                  appliance.applianceName!] = {
                                                "rating": int.tryParse(
                                                        appliance.rating!)! *
                                                    24 *
                                                    now
                                                        .difference(dateAdded)
                                                        .inDays,
                                                "quantity": int.tryParse(
                                                    appliance.quantity!)!
                                              };
                                            }
                                          } else {
                                            totalRating = totalRating +
                                                int.tryParse(
                                                        appliance.rating!)! *
                                                    int.tryParse(
                                                        appliance.quantity!)! *
                                                    24 *
                                                    7;
                                            if (appliances.containsKey(
                                                appliance.applianceName)) {
                                              appliances[
                                                      appliance.applianceName!]
                                                  ['quantity'] = int.parse(
                                                      appliance.quantity!) +
                                                  appliances[appliance
                                                          .applianceName!]
                                                      ["quantity"]!;
                                            } else {
                                              appliances[
                                                  appliance.applianceName!] = {
                                                "rating": int.tryParse(
                                                        appliance.rating!)! *
                                                    24 *
                                                    7,
                                                "quantity": int.tryParse(
                                                    appliance.quantity!)!
                                              };
                                            }
                                          }
                                        }
                                      }
                                    } else if (totalSpaceDuration ==
                                        StringConst.last30Days) {
                                      spaces = space
                                          .map((e) =>
                                              Space.fromJson(e.data()['space']))
                                          .toList();
                                      for (Space mySpace in spaces) {
                                        for (Appliances appliance
                                            in mySpace.appliances!) {
                                          unitRating = totalRating +
                                              int.tryParse(appliance.rating!)! *
                                                  int.tryParse(
                                                      appliance.quantity!)!;
                                          DateTime startDate = DateTime(
                                              now.year,
                                              now.month,
                                              now.day - 30);

                                          DateTime dateAdded = DateTime.parse(
                                              mySpace.dateAdded!);

                                          if (dateAdded.isAfter(startDate)) {
                                            totalRating = totalRating +
                                                int.tryParse(
                                                        appliance.rating!)! *
                                                    int.tryParse(
                                                        appliance.quantity!)! *
                                                    24 *
                                                    now
                                                        .difference(dateAdded)
                                                        .inDays;
                                            if (appliances.containsKey(
                                                appliance.applianceName)) {
                                              appliances[
                                                      appliance.applianceName!]
                                                  ['quantity'] = int.parse(
                                                      appliance.quantity!) +
                                                  appliances[appliance
                                                          .applianceName!]
                                                      ["quantity"]!;
                                            } else {
                                              appliances[
                                                  appliance.applianceName!] = {
                                                "rating": int.tryParse(
                                                        appliance.rating!)! *
                                                    24 *
                                                    now
                                                        .difference(dateAdded)
                                                        .inDays,
                                                "quantity": int.tryParse(
                                                    appliance.quantity!)!
                                              };
                                            }
                                          } else {
                                            totalRating = totalRating +
                                                int.tryParse(
                                                        appliance.rating!)! *
                                                    int.tryParse(
                                                        appliance.quantity!)! *
                                                    24 *
                                                    30;
                                            if (appliances.containsKey(
                                                appliance.applianceName)) {
                                              appliances[
                                                      appliance.applianceName!]
                                                  ['quantity'] = int.parse(
                                                      appliance.quantity!) +
                                                  appliances[appliance
                                                          .applianceName!]
                                                      ["quantity"]!;
                                            } else {
                                              appliances[
                                                  appliance.applianceName!] = {
                                                "rating": int.tryParse(
                                                        appliance.rating!)! *
                                                    24 *
                                                    30,
                                                "quantity": int.tryParse(
                                                    appliance.quantity!)!
                                              };
                                            }
                                          }
                                        }
                                      }
                                    } else {
                                      spaces = space
                                          .map((e) =>
                                              Space.fromJson(e.data()['space']))
                                          .toList();
                                      for (Space mySpace in spaces) {
                                        for (Appliances appliance
                                            in mySpace.appliances!) {
                                          DateTime startDate = DateTime(
                                              now.year,
                                              now.month,
                                              now.day - 365);
                                          DateTime dateAdded = DateTime.parse(
                                              mySpace.dateAdded!);
                                          unitRating = totalRating +
                                              int.tryParse(appliance.rating!)! *
                                                  int.tryParse(
                                                      appliance.quantity!)!;
                                          if (dateAdded.isAfter(startDate)) {
                                            totalRating = totalRating +
                                                int.tryParse(
                                                        appliance.rating!)! *
                                                    int.tryParse(
                                                        appliance.quantity!)! *
                                                    24 *
                                                    now
                                                        .difference(dateAdded)
                                                        .inDays;
                                            if (appliances.containsKey(
                                                appliance.applianceName)) {
                                              appliances[
                                                      appliance.applianceName!]
                                                  ['quantity'] = int.parse(
                                                      appliance.quantity!) +
                                                  appliances[appliance
                                                          .applianceName!]
                                                      ["quantity"]!;
                                            } else {
                                              appliances[
                                                  appliance.applianceName!] = {
                                                "rating": int.tryParse(
                                                        appliance.rating!)! *
                                                    24 *
                                                    now
                                                        .difference(dateAdded)
                                                        .inDays,
                                                "quantity": int.tryParse(
                                                    appliance.quantity!)!
                                              };
                                            }
                                          } else {
                                            totalRating = totalRating +
                                                int.tryParse(
                                                        appliance.rating!)! *
                                                    int.tryParse(
                                                        appliance.quantity!)! *
                                                    24 *
                                                    365;
                                            if (appliances.containsKey(
                                                appliance.applianceName)) {
                                              appliances[
                                                      appliance.applianceName!]
                                                  ['quantity'] = int.parse(
                                                      appliance.quantity!) +
                                                  appliances[appliance
                                                          .applianceName!]
                                                      ["quantity"]!;
                                            } else {
                                              appliances[
                                                  appliance.applianceName!] = {
                                                "rating": int.tryParse(
                                                        appliance.rating!)! *
                                                    24 *
                                                    365,
                                                "quantity": int.tryParse(
                                                    appliance.quantity!)!
                                              };
                                            }
                                          }
                                        }
                                      }
                                    }

                                    appliances.forEach((key, value) {
                                      int unit =
                                          value['rating']! * value['quantity']!;
                                      dataMap[key] =
                                          double.tryParse(unit.toString())!;
                                      subAppliances.add(SubAppliance(
                                          rating: value['rating'].toString(),
                                          name: key,
                                          quantity: value['quantity']));
                                    });
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 15.h),
                                            decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                colors: [
                                                  swatch17,
                                                  swatch17,
                                                ],
                                                begin: AlignmentDirectional
                                                    .topStart,
                                                end: AlignmentDirectional
                                                    .bottomEnd,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 10.h),
                                              child: Column(
                                                children: [
                                                  PieChart(
                                                    dataMap: dataMap,
                                                    animationDuration:
                                                        const Duration(
                                                            milliseconds: 800),
                                                    chartLegendSpacing: 32,
                                                    chartRadius:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.5,
                                                    colorList: colorList,
                                                    initialAngleInDegree: 0,
                                                    chartType: ChartType.ring,
                                                    ringStrokeWidth: 25,
                                                    centerText:
                                                        totalRating.toString(),
                                                    legendOptions:
                                                        const LegendOptions(
                                                      showLegendsInRow: false,
                                                      legendPosition:
                                                          LegendPosition.right,
                                                      showLegends: false,
                                                      legendShape:
                                                          BoxShape.circle,
                                                      legendTextStyle:
                                                          TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    chartValuesOptions:
                                                        const ChartValuesOptions(
                                                      showChartValueBackground:
                                                          true,
                                                      showChartValues: false,
                                                      showChartValuesInPercentage:
                                                          false,
                                                      showChartValuesOutside:
                                                          false,
                                                      decimalPlaces: 1,
                                                    ),
                                                    // gradientList: ---To add gradient colors---
                                                    // emptyColorGradient: ---Empty Color gradient---
                                                  ),
                                                  SizedBox(height: 10.h),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          "${(unitRating / 60).truncate().toString()} kw/s",
                                                          style: CustomTheme
                                                                  .semiLargeText(
                                                                      context)
                                                              .copyWith(
                                                            color:
                                                                whiteColorShade2,
                                                          )),
                                                      Text(
                                                          "${unitRating.truncate().toString()} kw/h",
                                                          style: CustomTheme
                                                                  .semiLargeText(
                                                                      context)
                                                              .copyWith(
                                                            color:
                                                                whiteColorShade2,
                                                          )),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Text(
                                          "USAGE BY DEVICES",
                                          style: CustomTheme.normalText(context)
                                              .copyWith(color: swatch15),
                                        ),
                                        const Divider(
                                          color: swatch15,
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 15.h),
                                            decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                colors: [
                                                  swatch17,
                                                  swatch17,
                                                ],
                                                begin: AlignmentDirectional
                                                    .topStart,
                                                end: AlignmentDirectional
                                                    .bottomEnd,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w,
                                                    vertical: 10.h),
                                                child: ListView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        subAppliances.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      int unit = int.tryParse(
                                                              subAppliances[
                                                                      index]
                                                                  .rating!)! *
                                                          subAppliances[index]
                                                              .quantity!;
                                                      num ratio =
                                                          unit / totalRating;
                                                      return Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 5.h),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                      subAppliances[index]
                                                                              .name! +
                                                                          '   x' +
                                                                          subAppliances[index]
                                                                              .quantity
                                                                              .toString(),
                                                                      style: CustomTheme.normalText(
                                                                              context)
                                                                          .copyWith(
                                                                        color:
                                                                            whiteColorShade2,
                                                                      )),
                                                                  Text(
                                                                      unit
                                                                          .truncate()
                                                                          .toString(),
                                                                      style: CustomTheme.smallText(
                                                                              context)
                                                                          .copyWith(
                                                                        color:
                                                                            whiteColorShade2,
                                                                      )),
                                                                ]),
                                                            SizedBox(
                                                              height: 5.h,
                                                            ),
                                                            FractionallySizedBox(
                                                              widthFactor: ratio
                                                                  .truncate()
                                                                  .toDouble(),
                                                              child: Container(
                                                                height: 6.h,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      swatch23,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    })))
                                      ],
                                    );
                                  }),
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
