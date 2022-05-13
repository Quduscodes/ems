import 'package:ems/exports.dart';
import 'package:pie_chart/pie_chart.dart';

final isSpaceEmpty = StateProvider<bool>((ref) => false);

class StaffHomePage extends StatefulWidget {
  const StaffHomePage({Key? key}) : super(key: key);

  @override
  State<StaffHomePage> createState() => _StaffHomePageState();
}

class _StaffHomePageState extends State<StaffHomePage> {
  final CollectionReference _fireStore =
      FirebaseFirestore.instance.collection('users');
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
                        children: [
                          Expanded(
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.w, vertical: 10.h),
                                  child: Text(
                                    "Welcome ${box.get(StringConst.userDataKey)!.lastName ?? ''},",
                                    style: CustomTheme.semiLargeText(context)
                                        .copyWith(
                                            color: whiteColorShade2,
                                            fontFamily: GoogleFonts.adamina()
                                                .fontFamily,
                                            fontSize: 25.sp),
                                  ),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                const Ads(),
                                SizedBox(
                                  height: 30.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  child: Text(
                                    "ENERGY CONSUMPTION OVERVIEW",
                                    style: CustomTheme.normalText(context)
                                        .copyWith(color: swatch15),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  child: const Divider(
                                    color: swatch15,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  child: StreamBuilder<DocumentSnapshot>(
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
                                          return Text("Something went wrong",
                                              style: CustomTheme.normalText(
                                                      context)
                                                  .copyWith(color: whiteColor));
                                        }
                                        if (!snapshot.data!.exists) {
                                          return Text("Empty",
                                              style: CustomTheme.normalText(
                                                      context)
                                                  .copyWith(color: whiteColor));
                                        }
                                        final Space data = Space.fromJson(
                                            snapshot.data!['space']);
                                        int? totalRating = 0;
                                        Map<String, dynamic> appliances = {};
                                        List<SubAppliance> subAppliances = [];
                                        Map<String, double> dataMap = {};

                                        if (data.spaceOwner != null) {
                                          for (Appliances appliance
                                              in data.appliances!) {
                                            totalRating = int.tryParse(
                                                        appliance.rating!)! *
                                                    int.tryParse(
                                                        appliance.quantity!)! +
                                                totalRating!;
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
                                                    appliance.rating!)!,
                                                "quantity": int.tryParse(
                                                    appliance.quantity!)!
                                              };
                                            }
                                          }
                                        }
                                        appliances.forEach((key, value) {
                                          int unit = value['rating']! *
                                              value['quantity']!;
                                          dataMap[key] =
                                              double.tryParse(unit.toString())!;
                                          subAppliances.add(SubAppliance(
                                              rating:
                                                  value['rating'].toString(),
                                              name: key,
                                              quantity: value['quantity']));
                                        });
                                        if (data.spaceOwner == null) {
                                          WidgetsBinding.instance
                                              ?.addPostFrameCallback((_) {
                                            // Add Your Code here.
                                            ref
                                                .watch(isSpaceEmpty.notifier)
                                                .state = false;
                                          });
                                          return Material(
                                              type: MaterialType.transparency,
                                              child: InkWell(
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                        context,
                                                        RouteGenerator
                                                            .configureSpaceStaff);
                                                  },
                                                  child: Text(
                                                      "You have not configured your space,\nConfigure space",
                                                      style: CustomTheme
                                                              .normalText(
                                                                  context)
                                                          .copyWith(
                                                              color:
                                                                  whiteColor))));
                                        } else {
                                          WidgetsBinding.instance
                                              ?.addPostFrameCallback((_) {
                                            // Add Your Code here.
                                            ref
                                                .watch(isSpaceEmpty.notifier)
                                                .state = false;
                                          });
                                          return Container(
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
                                                              milliseconds:
                                                                  800),
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
                                                          "${totalRating.toString()} kw/h",
                                                      legendOptions:
                                                          const LegendOptions(
                                                        showLegendsInRow: false,
                                                        legendPosition:
                                                            LegendPosition
                                                                .right,
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
                                                            "${totalRating.toString()} kwh",
                                                            style: CustomTheme
                                                                    .semiLargeText(
                                                                        context)
                                                                .copyWith(
                                                              color:
                                                                  whiteColorShade2,
                                                            )),
                                                        Text(
                                                            "${totalRating.toString()} kwh",
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
                                              ));
                                        }
                                      }),
                                ),
                                SizedBox(
                                  height: 25.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  child: Text(
                                    "USAGE BY DEVICES",
                                    style: CustomTheme.normalText(context)
                                        .copyWith(color: swatch15),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  child: const Divider(
                                    color: swatch15,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  child: StreamBuilder<DocumentSnapshot>(
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
                                          return Text("Something went wrong",
                                              style: CustomTheme.normalText(
                                                      context)
                                                  .copyWith(color: whiteColor));
                                        }
                                        if (!snapshot.data!.exists) {
                                          return Text("Empty",
                                              style: CustomTheme.normalText(
                                                      context)
                                                  .copyWith(color: whiteColor));
                                        }
                                        final Space data = Space.fromJson(
                                            snapshot.data!['space']);
                                        int? totalRating = 0;
                                        Map<String, dynamic> appliances = {};
                                        List<SubAppliance> subAppliances = [];
                                        Map<String, double> dataMap = {};

                                        if (data.spaceOwner != null) {
                                          for (Appliances appliance
                                              in data.appliances!) {
                                            totalRating = int.tryParse(
                                                        appliance.rating!)! *
                                                    int.tryParse(
                                                        appliance.quantity!)! +
                                                totalRating!;
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
                                                    appliance.rating!)!,
                                                "quantity": int.tryParse(
                                                    appliance.quantity!)!
                                              };
                                            }
                                          }
                                        }
                                        appliances.forEach((key, value) {
                                          int unit = value['rating']! *
                                              value['quantity']!;
                                          dataMap[key] =
                                              double.tryParse(unit.toString())!;
                                          subAppliances.add(SubAppliance(
                                              rating:
                                                  value['rating'].toString(),
                                              name: key,
                                              quantity: value['quantity']));
                                        });
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
                                                  child: Text(
                                                      "You have not configured your space,\nConfigure space",
                                                      style: CustomTheme
                                                              .normalText(
                                                                  context)
                                                          .copyWith(
                                                              color:
                                                                  whiteColor))));
                                        } else {
                                          return Container(
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
                                                        num ratio = unit != 0
                                                            ? unit /
                                                                totalRating!
                                                            : 0.0;
                                                        return Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      5.h),
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
                                                                        subAppliances[index].name! +
                                                                            '   x' +
                                                                            subAppliances[index]
                                                                                .quantity
                                                                                .toString(),
                                                                        style: CustomTheme.normalText(context)
                                                                            .copyWith(
                                                                          color:
                                                                              whiteColorShade2,
                                                                        )),
                                                                    Text(
                                                                        unit
                                                                            .toString(),
                                                                        style: CustomTheme.smallText(context)
                                                                            .copyWith(
                                                                          color:
                                                                              whiteColorShade2,
                                                                        )),
                                                                  ]),
                                                              SizedBox(
                                                                height: 5.h,
                                                              ),
                                                              ratio == 0 ||
                                                                      ratio ==
                                                                          null ||
                                                                      ratio ==
                                                                          0.0 ||
                                                                      ratio <=
                                                                          0.0
                                                                  ? SizedBox()
                                                                  : FractionallySizedBox(
                                                                      widthFactor:
                                                                          ratio
                                                                              .toDouble(),
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            6.h,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              swatch23,
                                                                          borderRadius:
                                                                              BorderRadius.circular(15),
                                                                        ),
                                                                      ),
                                                                    )
                                                            ],
                                                          ),
                                                        );
                                                      })));
                                        }
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.endFloat,
                    floatingActionButton: !ref.watch(isSpaceEmpty)
                        ? FloatingActionButton(
                            tooltip: "Add Space",
                            // isExtended: true,
                            child: const Icon(Icons.add, color: whiteColor),
                            backgroundColor: blackColor,
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RouteGenerator.configureSpaceStaff);
                            },
                          )
                        : FloatingActionButton(
                            tooltip: "Edit Space",
                            // isExtended: true,
                            child: const Icon(Icons.edit, color: whiteColor),
                            backgroundColor: blackColor,
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RouteGenerator.editSpaceStaff);
                            },
                          ));
              });
        }));
  }
}
