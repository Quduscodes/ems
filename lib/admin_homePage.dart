import 'package:ems/exports.dart';
import 'package:pie_chart/pie_chart.dart';

final selectedId = StateProvider<String>((ref) => "all");

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
  int selectedIndex = 0;
  final UserData? user =
      Hive.box<UserData>(StringConst.userDataBox).get(StringConst.userDataKey);

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
                            shrinkWrap: true,
                            children: [
                              SizedBox(
                                height: 15.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Text(
                                  "Welcome ${box.get(StringConst.userDataKey)!.lastName ?? ''} !",
                                  style: CustomTheme.semiLargeText(context)
                                      .copyWith(
                                          color: whiteColorShade2,
                                          fontFamily:
                                              GoogleFonts.adamina().fontFamily,
                                          fontSize: 23.sp),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
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
                                    List space =
                                        snapshot.data!["space"] as List;
                                    List<Space> spaces = space
                                        .map((e) => Space.fromJson(e))
                                        .toList();

                                    if (spaces.isEmpty) {
                                      return Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5.w),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: swatch12,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Material(
                                                type: MaterialType.transparency,
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  onTap: () {},
                                                  child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 20.h,
                                                          bottom: 10.h,
                                                          left: 10.w,
                                                          right: 30.w),
                                                      child: Center(
                                                        child: Text(
                                                          "ALL",
                                                          style: CustomTheme
                                                                  .mediumText(
                                                                      context)
                                                              .copyWith(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5.w),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: swatch12,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Material(
                                                type: MaterialType.transparency,
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                        context,
                                                        RouteGenerator
                                                            .addAdminSpace);
                                                  },
                                                  child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 12.h,
                                                              horizontal: 20.w),
                                                      child: Center(
                                                          child: Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                        size: 23.sp,
                                                      ))),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    return SizedBox(
                                      height: 65.h,
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemCount: spaces.length + 2,
                                                itemBuilder: (context, index) {
                                                  return index ==
                                                          spaces.length + 1
                                                      ? Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      5.w),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: swatch11,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                            child: Material(
                                                              type: MaterialType
                                                                  .transparency,
                                                              child: InkWell(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                onTap: () {
                                                                  Navigator.pushNamed(
                                                                      context,
                                                                      RouteGenerator
                                                                          .addAdminSpace);
                                                                },
                                                                child: Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical: 12
                                                                            .h,
                                                                        horizontal:
                                                                            20.w),
                                                                    child: Center(
                                                                        child: Icon(
                                                                      Icons.add,
                                                                      color:
                                                                          swatch13,
                                                                      size:
                                                                          23.sp,
                                                                    ))),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      5.w),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: selectedIndex ==
                                                                        index
                                                                    ? swatch12
                                                                    : swatch11,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                            child: Material(
                                                              type: MaterialType
                                                                  .transparency,
                                                              child: InkWell(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                onTap: () {
                                                                  setState(() {
                                                                    selectedIndex =
                                                                        index;
                                                                    index == 0
                                                                        ? ref.watch(selectedId.notifier).state =
                                                                            "all"
                                                                        : ref
                                                                            .watch(selectedId
                                                                                .notifier)
                                                                            .state = spaces[index -
                                                                                1]
                                                                            .sId!;
                                                                  });
                                                                  if (index !=
                                                                      0) {
                                                                    ref
                                                                        .watch(spaceListProvider
                                                                            .notifier)
                                                                        .state = spaces;
                                                                    ref.watch(indexProvider.notifier).state =
                                                                        index -
                                                                            1;
                                                                    ref.watch(spaceProvider.notifier).state =
                                                                        spaces[index -
                                                                            1];
                                                                  }
                                                                },
                                                                child: Padding(
                                                                  padding: EdgeInsets.only(
                                                                      top: 20.h,
                                                                      bottom:
                                                                          1.h,
                                                                      left:
                                                                          10.w,
                                                                      right:
                                                                          30.w),
                                                                  child: index ==
                                                                          0
                                                                      ? Center(
                                                                          child:
                                                                              Text(
                                                                            "ALL",
                                                                            style:
                                                                                CustomTheme.mediumText(context).copyWith(color: selectedIndex == index ? Colors.white : swatch13),
                                                                          ),
                                                                        )
                                                                      : Center(
                                                                          child:
                                                                              Text(
                                                                            spaces[index - 1].type!.toUpperCase(),
                                                                            style:
                                                                                CustomTheme.mediumText(context).copyWith(color: selectedIndex == index ? Colors.white : swatch13),
                                                                          ),
                                                                        ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                }),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                              decoration: const BoxDecoration(
                                                  color: swatch16),
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
                                                      "GOT IT",
                                                      style: CustomTheme
                                                              .normalText(
                                                                  context)
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
                                                  type:
                                                      MaterialType.transparency,
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
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
                                  "ENERGY CONSUMPTION OVERVIEW",
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
                              ref.watch(selectedId) == "all"
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      child: StreamBuilder<QuerySnapshot>(
                                          stream: _spaceFireStore.snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(primaryColor),
                                                ),
                                              );
                                            }
                                            if (snapshot.hasError) {
                                              return const Text(
                                                  "Something went wrong");
                                            }
                                            if (snapshot.data!.size == 0) {
                                              return const Text("No Data yet");
                                            }
                                            List space = snapshot.data!.docs;
                                            List<Space> spaces = space
                                                .map((e) => Space.fromJson(
                                                    e.data()['space']))
                                                .toList();
                                            int? totalRating = 0;
                                            Map<String, dynamic> appliances =
                                                {};
                                            Map<String, double> dataMap = {};
                                            List<SubAppliance> subAppliances =
                                                [];
                                            for (Space space in spaces) {
                                              for (Appliances appliance
                                                  in space.appliances!) {
                                                totalRating = int.tryParse(
                                                            appliance
                                                                .rating!)! *
                                                        int.tryParse(appliance
                                                                .quantity ??
                                                            '0')! +
                                                    totalRating!;
                                                if (appliances.containsKey(
                                                    appliance.applianceName)) {
                                                  appliances[appliance
                                                          .applianceName!]
                                                      ['quantity'] = int.parse(
                                                          appliance.quantity!) +
                                                      appliances[appliance
                                                              .applianceName!]
                                                          ["quantity"]!;
                                                } else {
                                                  appliances[appliance
                                                      .applianceName!] = {
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
                                              dataMap[key] = double.tryParse(
                                                  unit.toString())!;
                                              subAppliances.add(SubAppliance(
                                                  rating: value['rating']
                                                      .toString(),
                                                  name: key,
                                                  quantity: value['quantity']));
                                            });
                                            return Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w,
                                                    vertical: 15.h),
                                                decoration: BoxDecoration(
                                                  gradient:
                                                      const LinearGradient(
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
                                                      BorderRadius.circular(
                                                          10.0),
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
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2.5,
                                                        colorList: colorList,
                                                        initialAngleInDegree: 0,
                                                        chartType:
                                                            ChartType.ring,
                                                        ringStrokeWidth: 25,
                                                        centerText:
                                                            "${totalRating.toString()} kw/h",
                                                        legendOptions:
                                                            const LegendOptions(
                                                          showLegendsInRow:
                                                              false,
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
                                                          showChartValues:
                                                              false,
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
                                          }),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      child: StreamBuilder<DocumentSnapshot>(
                                          stream: _spaceFireStore
                                              .doc(ref.watch(selectedId))
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(primaryColor),
                                                ),
                                              );
                                            }
                                            if (snapshot.hasError) {
                                              return const Text(
                                                  "Something went wrong");
                                            }
                                            Space space = Space.fromJson(
                                                snapshot.data!['space']);
                                            int? totalRating = 0;
                                            Map<String, dynamic> appliances =
                                                {};
                                            Map<String, double> dataMap = {};
                                            List<SubAppliance> subAppliances =
                                                [];
                                            for (Appliances appliance
                                                in space.appliances!) {
                                              totalRating = int.tryParse(
                                                          appliance.rating!)! *
                                                      int.tryParse(appliance
                                                          .quantity!)! +
                                                  totalRating!;
                                              if (appliances.containsKey(
                                                  appliance.applianceName)) {
                                                appliances[appliance
                                                        .applianceName!]
                                                    ['quantity'] = int.parse(
                                                        appliance.quantity!) +
                                                    appliances[appliance
                                                            .applianceName!]
                                                        ["quantity"]!;
                                              } else {
                                                appliances[appliance
                                                    .applianceName!] = {
                                                  "rating": int.tryParse(
                                                      appliance.rating!)!,
                                                  "quantity": int.tryParse(
                                                      appliance.quantity!)!
                                                };
                                              }
                                            }
                                            appliances.forEach((key, value) {
                                              int unit = value['rating']! *
                                                  value['quantity']!;
                                              dataMap[key] = double.tryParse(
                                                  unit.toString())!;
                                              subAppliances.add(SubAppliance(
                                                  rating: value['rating']
                                                      .toString(),
                                                  name: key,
                                                  quantity: value['quantity']));
                                            });
                                            return Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w,
                                                    vertical: 15.h),
                                                decoration: BoxDecoration(
                                                  gradient:
                                                      const LinearGradient(
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
                                                      BorderRadius.circular(
                                                          10.0),
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
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2.5,
                                                        colorList: colorList,
                                                        initialAngleInDegree: 0,
                                                        chartType:
                                                            ChartType.ring,
                                                        ringStrokeWidth: 25,
                                                        centerText:
                                                            "${totalRating.toString()} kw/h",
                                                        legendOptions:
                                                            const LegendOptions(
                                                          showLegendsInRow:
                                                              false,
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
                                                          showChartValues:
                                                              false,
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
                                          }),
                                    ),
                              SizedBox(
                                height: 25.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Text(
                                  "USAGE BY DEVICES",
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
                              ref.watch(selectedId) == "all"
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      child: StreamBuilder<QuerySnapshot>(
                                          stream: _spaceFireStore.snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(primaryColor),
                                                ),
                                              );
                                            }
                                            if (snapshot.hasError) {
                                              return const Text(
                                                  "Something went wrong");
                                            }
                                            if (snapshot.data!.size == 0) {
                                              return const Text("No Data yet");
                                            }
                                            List space = snapshot.data!.docs;
                                            List<Space> spaces = space
                                                .map((e) => Space.fromJson(
                                                    e.data()['space']))
                                                .toList();
                                            int? totalRating = 0;
                                            Map<String, dynamic> appliances =
                                                {};
                                            List<SubAppliance> subAppliances =
                                                [];
                                            for (Space space in spaces) {
                                              for (Appliances appliance
                                                  in space.appliances!) {
                                                totalRating = int.tryParse(
                                                            appliance
                                                                .rating!)! *
                                                        int.tryParse(appliance
                                                            .quantity!)! +
                                                    totalRating!;
                                                if (appliances.containsKey(
                                                    appliance.applianceName)) {
                                                  appliances[appliance
                                                          .applianceName!]
                                                      ['quantity'] = int.parse(
                                                          appliance.quantity!) +
                                                      appliances[appliance
                                                              .applianceName!]
                                                          ["quantity"]!;
                                                } else {
                                                  appliances[appliance
                                                      .applianceName!] = {
                                                    "rating": int.tryParse(
                                                        appliance.rating!)!,
                                                    "quantity": int.tryParse(
                                                        appliance.quantity!)!
                                                  };
                                                }
                                              }
                                            }
                                            appliances.forEach((key, value) {
                                              subAppliances.add(SubAppliance(
                                                  rating: value['rating']
                                                      .toString(),
                                                  name: key,
                                                  quantity: value['quantity']));
                                            });
                                            return Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w,
                                                    vertical: 15.h),
                                                decoration: BoxDecoration(
                                                  gradient:
                                                      const LinearGradient(
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
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.w,
                                                            vertical: 10.h),
                                                    child: ListView.builder(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0.0),
                                                        shrinkWrap: true,
                                                        itemCount: subAppliances
                                                            .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          int unit = int.tryParse(
                                                                  subAppliances[
                                                                          index]
                                                                      .rating!)! *
                                                              subAppliances[
                                                                      index]
                                                                  .quantity!;
                                                          num ratio = unit /
                                                              totalRating!;
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
                                                                              subAppliances[index].quantity.toString(),
                                                                          style: CustomTheme.normalText(context).copyWith(
                                                                            color:
                                                                                whiteColorShade2,
                                                                          )),
                                                                      Text(
                                                                          unit
                                                                              .toString(),
                                                                          style:
                                                                              CustomTheme.smallText(context).copyWith(
                                                                            color:
                                                                                whiteColorShade2,
                                                                          )),
                                                                    ]),
                                                                SizedBox(
                                                                  height: 5.h,
                                                                ),
                                                                ratio == 0
                                                                    ? SizedBox()
                                                                    : FractionallySizedBox(
                                                                        widthFactor:
                                                                            ratio.toDouble(),
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
                                          }),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      child: StreamBuilder<DocumentSnapshot>(
                                          stream: _spaceFireStore
                                              .doc(ref.watch(selectedId))
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(primaryColor),
                                                ),
                                              );
                                            }
                                            if (snapshot.hasError) {
                                              return const Text(
                                                  "Something went wrong");
                                            }
                                            Space space = Space.fromJson(
                                                snapshot.data!['space']);
                                            int? totalRating = 0;
                                            Map<String, dynamic> appliances =
                                                {};
                                            List<SubAppliance> subAppliances =
                                                [];
                                            for (Appliances appliance
                                                in space.appliances!) {
                                              totalRating = int.tryParse(
                                                          appliance.rating!)! *
                                                      int.tryParse(appliance
                                                          .quantity!)! +
                                                  totalRating!;
                                              if (appliances.containsKey(
                                                  appliance.applianceName)) {
                                                appliances[appliance
                                                        .applianceName!]
                                                    ['quantity'] = int.parse(
                                                        appliance.quantity!) +
                                                    appliances[appliance
                                                            .applianceName!]
                                                        ["quantity"]!;
                                              } else {
                                                appliances[appliance
                                                    .applianceName!] = {
                                                  "rating": int.tryParse(
                                                      appliance.rating!)!,
                                                  "quantity": int.tryParse(
                                                      appliance.quantity!)!
                                                };
                                              }
                                            }
                                            appliances.forEach((key, value) {
                                              subAppliances.add(SubAppliance(
                                                  rating: value['rating']
                                                      .toString(),
                                                  name: key,
                                                  quantity: value['quantity']));
                                            });
                                            return Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w,
                                                    vertical: 15.h),
                                                decoration: BoxDecoration(
                                                  gradient:
                                                      const LinearGradient(
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
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.w,
                                                            vertical: 10.h),
                                                    child: ListView.builder(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0.0),
                                                        shrinkWrap: true,
                                                        itemCount: subAppliances
                                                            .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          int unit = int.tryParse(
                                                                  subAppliances[
                                                                          index]
                                                                      .rating!)! *
                                                              subAppliances[
                                                                      index]
                                                                  .quantity!;
                                                          num ratio = unit /
                                                              totalRating!;
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
                                                                              '  x' +
                                                                              subAppliances[index].quantity.toString(),
                                                                          style: CustomTheme.normalText(context).copyWith(
                                                                            color:
                                                                                whiteColorShade2,
                                                                          )),
                                                                      Text(
                                                                          "${unit.toString()} kwh",
                                                                          style:
                                                                              CustomTheme.smallText(context).copyWith(
                                                                            color:
                                                                                whiteColorShade2,
                                                                          )),
                                                                    ]),
                                                                SizedBox(
                                                                  height: 5.h,
                                                                ),
                                                                ratio == 0
                                                                    ? const SizedBox()
                                                                    : FractionallySizedBox(
                                                                        widthFactor:
                                                                            ratio.toDouble(),
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
                                          }),
                                    ),
                              SizedBox(
                                height: 10.h,
                              ),
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
                                    List space =
                                        snapshot.data!["space"] as List;
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

                                    Map<String, dynamic> appliances = {};
                                    List<SubAppliance> subAppliances = [];
                                    for (Space space in spaces) {
                                      for (Appliances appliance
                                          in space.appliances!) {
                                        totalRating =
                                            int.tryParse(appliance.rating!)! *
                                                    int.tryParse(
                                                        appliance.quantity!)! +
                                                totalRating!;
                                        if (appliances.containsKey(
                                            appliance.applianceName)) {
                                          appliances[appliance.applianceName!]
                                                  ['quantity'] =
                                              int.parse(appliance.quantity!) +
                                                  appliances[appliance
                                                          .applianceName!]
                                                      ["quantity"]!;
                                        } else {
                                          appliances[appliance.applianceName!] =
                                              {
                                            "rating": appliance.rating,
                                            "quantity": int.tryParse(
                                                appliance.quantity!)!
                                          };
                                        }
                                      }
                                    }
                                    appliances.forEach((key, value) {
                                      subAppliances.add(SubAppliance(
                                          rating: value['rating'],
                                          name: key,
                                          quantity: value['quantity']));
                                    });
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
                                              end: AlignmentDirectional
                                                  .bottomEnd,
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
                                                "Your Space: Total estimate",
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
                                              SizedBox(
                                                height: 70.h,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount:
                                                              subAppliances
                                                                  .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return Column(
                                                                children: [
                                                                  Text(
                                                                    subAppliances[
                                                                            index]
                                                                        .name!,
                                                                  ),
                                                                  Text(subAppliances[
                                                                          index]
                                                                      .quantity
                                                                      .toString())
                                                                ]);
                                                          }),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: spaces.length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                          onTap: () {},
                                                          child: Text(
                                                              spaces[index]
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
                                                                .watch(
                                                                    indexProvider
                                                                        .notifier)
                                                                .state = index;
                                                            ref
                                                                    .watch(spaceProvider
                                                                        .notifier)
                                                                    .state =
                                                                spaces[index];
                                                            Navigator.pushNamed(
                                                                context,
                                                                RouteGenerator
                                                                    .editAdminSpace);
                                                          },
                                                          child: const Icon(
                                                              Icons.edit))
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                          Icons.location_on),
                                                      Text(spaces[index]
                                                              .location ??
                                                          "")
                                                    ],
                                                  )
                                                ],
                                              );
                                            }),
                                        InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  RouteGenerator.addAdminSpace);
                                            },
                                            child:
                                                const Icon(Icons.add_rounded))
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
                                            style:
                                                CustomTheme.mediumText(context)
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
                              Row(
                                children: [
                                  Expanded(
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
                                            color:
                                                Colors.white.withOpacity(0.2)),
                                        color: whiteColor.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Material(
                                        type: MaterialType.transparency,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                RouteGenerator.helpAndSupport);
                                          },
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 10.h),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Help & Support",
                                                  style: CustomTheme.mediumText(
                                                          context)
                                                      .copyWith(
                                                          color:
                                                              whiteColorShade2,
                                                          fontSize: 25.sp),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "View All",
                                                      style: CustomTheme
                                                              .mediumText(
                                                                  context)
                                                          .copyWith(
                                                              color:
                                                                  whiteColorShade2,
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
                                  SizedBox(width: 10.w),
                                  Expanded(
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
                                            color:
                                                Colors.white.withOpacity(0.2)),
                                        color: whiteColor.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Material(
                                        type: MaterialType.transparency,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                RouteGenerator.locations);
                                          },
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 10.h),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Locations",
                                                  style: CustomTheme.mediumText(
                                                          context)
                                                      .copyWith(
                                                          color:
                                                              whiteColorShade2,
                                                          fontSize: 25.sp),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "View All",
                                                      style: CustomTheme
                                                              .mediumText(
                                                                  context)
                                                          .copyWith(
                                                              color:
                                                                  whiteColorShade2,
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.endFloat,
                  floatingActionButton: ref.watch(selectedId) != "all"
                      ? FloatingActionButton(
                          tooltip: "Delete Space",
                          // isExtended: true,
                          child: const Icon(Icons.edit, color: whiteColor),
                          backgroundColor: blackColor,
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RouteGenerator.editAdminSpace);
                          },
                        )
                      : null,
                );
              });
        }));
  }
}
