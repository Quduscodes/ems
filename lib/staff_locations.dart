import 'package:ems/exports.dart';

class StaffLocationsView extends StatefulWidget {
  const StaffLocationsView({Key? key}) : super(key: key);

  @override
  State<StaffLocationsView> createState() => _StaffLocationsViewState();
}

class _StaffLocationsViewState extends State<StaffLocationsView> {
  final CollectionReference _fireStore =
      FirebaseFirestore.instance.collection('locations');

  final TextEditingController locationController = TextEditingController();
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
                    backgroundColor: swatch9,
                    body: SafeArea(
                      child: Container(
                        color: swatch9,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              margin: EdgeInsets.only(bottom: 2.4.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Material(
                                    type: MaterialType.transparency,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.arrow_back,
                                          color: whiteColor,
                                          size: 20.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text('LOCATIONS',
                                      style: CustomTheme.semiLargeText(context)
                                          .copyWith(color: whiteColor)),
                                  SizedBox(width: 4.8.w),
                                ],
                              ),
                            ),
                            SizedBox(height: 30.h),
                            Expanded(
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  StreamBuilder<DocumentSnapshot>(
                                      stream: _fireStore
                                          .doc("locations")
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
                                          return const Text(
                                              "Something went wrong");
                                        }
                                        if (!snapshot.data!.exists) {
                                          return Column(
                                            children: [
                                              const Text(
                                                  "No Locations have been added yet"),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 24.w,
                                                    vertical: 10.h),
                                                child: CustomBorderButton(
                                                  onPressed: () {
                                                    showModalBottomSheet(
                                                        context: context,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        isScrollControlled:
                                                            true,
                                                        builder: (context) {
                                                          return Padding(
                                                            padding:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .viewInsets,
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          24.w,
                                                                      vertical:
                                                                          30.h),
                                                              decoration: const BoxDecoration(
                                                                  borderRadius: BorderRadius.only(
                                                                      topRight:
                                                                          Radius.circular(
                                                                              20),
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              20)),
                                                                  color:
                                                                      whiteColor),
                                                              height: 400.h,
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                      "Add Location",
                                                                      style: CustomTheme.mediumText(
                                                                              context)
                                                                          .copyWith()),
                                                                  SizedBox(
                                                                    height:
                                                                        20.h,
                                                                  ),
                                                                  Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          "Location Name:",
                                                                          style:
                                                                              CustomTheme.normalText(context).copyWith(),
                                                                        ),
                                                                        SizedBox(
                                                                            width:
                                                                                200.w,
                                                                            child: Container(
                                                                              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: blackColor))),
                                                                              child: TextField(
                                                                                controller: locationController,
                                                                                decoration: const InputDecoration(
                                                                                  border: InputBorder.none,
                                                                                ),
                                                                              ),
                                                                            ))
                                                                      ]),
                                                                  SizedBox(
                                                                    height:
                                                                        20.h,
                                                                  ),
                                                                  const Expanded(
                                                                    child:
                                                                        SizedBox(),
                                                                  ),
                                                                  CustomBorderButton(
                                                                    onPressed:
                                                                        () {
                                                                      ref.watch(storageProvider).addLocation(
                                                                          context,
                                                                          locationController
                                                                              .text);
                                                                    },
                                                                    color:
                                                                        whiteColor,
                                                                    borderColor:
                                                                        greenTextColor,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        "Add",
                                                                        style: CustomTheme.normalText(context)
                                                                            .copyWith(
                                                                          color:
                                                                              greenTextColor,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10.0.w,
                                                                      ),
                                                                      Icon(
                                                                        Icons
                                                                            .add_rounded,
                                                                        color:
                                                                            greenTextColor,
                                                                        size: 25
                                                                            .sp,
                                                                      )
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        20.h,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  color: whiteColor,
                                                  borderColor: greenTextColor,
                                                  children: <Widget>[
                                                    Text(
                                                      "Add New",
                                                      style: CustomTheme
                                                              .normalText(
                                                                  context)
                                                          .copyWith(
                                                        color: greenTextColor,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5.0.w,
                                                    ),
                                                    Icon(
                                                      Icons.add_rounded,
                                                      color: greenTextColor,
                                                      size: 25.sp,
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          );
                                        }
                                        List location =
                                            snapshot.data!["location"] as List;
                                        List<String> locations = location
                                            .map((e) => e.toString())
                                            .toList();
                                        if (location.isEmpty) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 24.w,
                                                vertical: 10.h),
                                            child: CustomBorderButton(
                                              onPressed: () {
                                                showModalBottomSheet(
                                                    context: context,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    isScrollControlled: true,
                                                    builder: (context) {
                                                      return Padding(
                                                        padding: MediaQuery.of(
                                                                context)
                                                            .viewInsets,
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      24.w,
                                                                  vertical:
                                                                      30.h),
                                                          decoration: const BoxDecoration(
                                                              borderRadius: BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          20),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20)),
                                                              color:
                                                                  whiteColor),
                                                          height: 400.h,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                  "Add Location",
                                                                  style: CustomTheme
                                                                          .mediumText(
                                                                              context)
                                                                      .copyWith()),
                                                              SizedBox(
                                                                height: 20.h,
                                                              ),
                                                              Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      "Location Name:",
                                                                      style: CustomTheme.normalText(
                                                                              context)
                                                                          .copyWith(),
                                                                    ),
                                                                    SizedBox(
                                                                        width: 200
                                                                            .w,
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              const BoxDecoration(border: Border(bottom: BorderSide(color: blackColor))),
                                                                          child:
                                                                              TextField(
                                                                            controller:
                                                                                locationController,
                                                                            decoration:
                                                                                const InputDecoration(
                                                                              border: InputBorder.none,
                                                                            ),
                                                                          ),
                                                                        ))
                                                                  ]),
                                                              SizedBox(
                                                                height: 20.h,
                                                              ),
                                                              const Expanded(
                                                                child:
                                                                    SizedBox(),
                                                              ),
                                                              CustomBorderButton(
                                                                onPressed: () {
                                                                  ref
                                                                      .watch(
                                                                          storageProvider)
                                                                      .addLocation(
                                                                          context,
                                                                          locationController
                                                                              .text);
                                                                },
                                                                color:
                                                                    whiteColor,
                                                                borderColor:
                                                                    greenTextColor,
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                    "Add",
                                                                    style: CustomTheme.normalText(
                                                                            context)
                                                                        .copyWith(
                                                                      color:
                                                                          greenTextColor,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        10.0.w,
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .add_rounded,
                                                                    color:
                                                                        greenTextColor,
                                                                    size: 25.sp,
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 20.h,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                              color: whiteColor,
                                              borderColor: greenTextColor,
                                              children: <Widget>[
                                                Text(
                                                  "Add New",
                                                  style: CustomTheme.normalText(
                                                          context)
                                                      .copyWith(
                                                    color: greenTextColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5.0.w,
                                                ),
                                                Icon(
                                                  Icons.add_rounded,
                                                  color: greenTextColor,
                                                  size: 25.sp,
                                                )
                                              ],
                                            ),
                                          );
                                        }
                                        return Column(
                                          children: [
                                            ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: locations.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 15.h),
                                                    child: Text(
                                                      locations[index],
                                                      style: CustomTheme
                                                              .normalText(
                                                                  context)
                                                          .copyWith(
                                                              color:
                                                                  whiteColor),
                                                    ),
                                                  );
                                                }),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                          ],
                                        );
                                      }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
              });
        }));
  }
}
