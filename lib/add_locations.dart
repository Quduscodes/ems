import 'package:ems/exports.dart';

class LocationsView extends StatefulWidget {
  const LocationsView({Key? key}) : super(key: key);

  @override
  State<LocationsView> createState() => _LocationsViewState();
}

class _LocationsViewState extends State<LocationsView> {
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
                    body: SafeArea(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            left: 4.8.w,
                            right: 4.8.w,
                            top: 2.4.w,
                            bottom: 3.w,
                          ),
                          margin: EdgeInsets.only(bottom: 2.4.w),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 0.1.w, color: greyColorShade5),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: blackTextColor,
                                  size: 16.sp,
                                ),
                              ),
                              Text(
                                'Locations',
                                style: TextStyle(
                                  color: blackTextColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 4.8.w),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              StreamBuilder<DocumentSnapshot>(
                                  stream:
                                      _fireStore.doc("locations").snapshots(),
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
                                      return Column(
                                        children: [
                                          const Text(
                                              "No Locations have been added yet"),
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
                                            horizontal: 24.w, vertical: 10.h),
                                        child: CustomBorderButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                                context: context,
                                                backgroundColor:
                                                    Colors.transparent,
                                                isScrollControlled: true,
                                                builder: (context) {
                                                  return Padding(
                                                    padding:
                                                        MediaQuery.of(context)
                                                            .viewInsets,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 24.w,
                                                              vertical: 30.h),
                                                      decoration: const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          20),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20)),
                                                          color: whiteColor),
                                                      height: 400.h,
                                                      child: Column(
                                                        children: [
                                                          Text("Add Location",
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
                                                                  style: CustomTheme
                                                                          .normalText(
                                                                              context)
                                                                      .copyWith(),
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                        200.w,
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                              border: Border(bottom: BorderSide(color: blackColor))),
                                                                      child:
                                                                          TextField(
                                                                        controller:
                                                                            locationController,
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          border:
                                                                              InputBorder.none,
                                                                        ),
                                                                      ),
                                                                    ))
                                                              ]),
                                                          SizedBox(
                                                            height: 20.h,
                                                          ),
                                                          const Expanded(
                                                            child: SizedBox(),
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
                                                            color: whiteColor,
                                                            borderColor:
                                                                greenTextColor,
                                                            children: <Widget>[
                                                              Text(
                                                                "Add",
                                                                style: CustomTheme
                                                                        .normalText(
                                                                            context)
                                                                    .copyWith(
                                                                  color:
                                                                      greenTextColor,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 10.0.w,
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
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.h),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(locations[index]),
                                                    InkWell(
                                                        onTap: () {
                                                          ref
                                                              .watch(
                                                                  storageProvider
                                                                      .notifier)
                                                              .deleteLocation(
                                                                  context,
                                                                  locations[
                                                                      index]);
                                                        },
                                                        child: const Icon(
                                                            Icons.delete)),
                                                  ],
                                                ),
                                              );
                                            }),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 24.w, vertical: 20.h),
                                          child: CustomBorderButton(
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  context: context,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  isScrollControlled: true,
                                                  builder: (context) {
                                                    return Padding(
                                                      padding:
                                                          MediaQuery.of(context)
                                                              .viewInsets,
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    24.w,
                                                                vertical: 30.h),
                                                        decoration: const BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        20),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20)),
                                                            color: whiteColor),
                                                        height: 400.h,
                                                        child: Column(
                                                          children: [
                                                            Text("Add Location",
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
                                                                      width:
                                                                          200.w,
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
                                                                            border:
                                                                                InputBorder.none,
                                                                          ),
                                                                        ),
                                                                      ))
                                                                ]),
                                                            const Expanded(
                                                              child: SizedBox(),
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
                                                              color: whiteColor,
                                                              borderColor:
                                                                  greenTextColor,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  "Add",
                                                                  style: CustomTheme
                                                                          .normalText(
                                                                              context)
                                                                      .copyWith(
                                                                    color:
                                                                        greenTextColor,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10.0.w,
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
                                        )
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
