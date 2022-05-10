import 'package:ems/exports.dart';

import 'custom_dropdown.dart';

class EditAdminSpace extends ConsumerStatefulWidget {
  const EditAdminSpace({Key? key}) : super(key: key);

  @override
  _EditAdminSpaceState createState() => _EditAdminSpaceState();
}

class _EditAdminSpaceState extends ConsumerState<EditAdminSpace> {
  TextEditingController aliasController = TextEditingController();
  String selectedLocation = "";

  final UserData? user =
      Hive.box<UserData>(StringConst.userDataBox).get(StringConst.userDataKey);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      aliasController.text = ref.watch(spaceProvider)!.type ?? '';
      selectedLocation = ref.watch(spaceProvider)!.location ?? '';
    });
  }

  final CollectionReference _locationFirestore =
      FirebaseFirestore.instance.collection('locations');
  List<Appliances> globalAppliances = [];
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
                  color: swatch9,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
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
                                  Text('Edit Space',
                                      style: CustomTheme.semiLargeText(context)
                                          .copyWith(color: whiteColor)),
                                  Material(
                                    type: MaterialType.transparency,
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (contextM) {
                                              return SimpleDialog(
                                                title: Text(
                                                  "Are you sure you want to delete this space?",
                                                  style: CustomTheme.normalText(
                                                      context),
                                                ),
                                                children: [
                                                  SizedBox(
                                                    height: 15.h,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 30.w),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              color: redColor,
                                                              border:
                                                                  Border.all(
                                                                color:
                                                                    borderColor,
                                                                width: 1,
                                                              ),
                                                            ),
                                                            child: Material(
                                                                type: MaterialType
                                                                    .transparency,
                                                                child: InkWell(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50),
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                          contextM);
                                                                      ref.watch(selectedId.notifier).state =
                                                                          "all";
                                                                      ref
                                                                          .watch(storageProvider
                                                                              .notifier)
                                                                          .deleteAdminSpace(
                                                                              context);
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: 20.0
                                                                              .w,
                                                                          vertical:
                                                                              7.h),
                                                                      child:
                                                                          Text(
                                                                        "Yes",
                                                                        style: CustomTheme.mediumText(context).copyWith(
                                                                            color:
                                                                                whiteColor),
                                                                      ),
                                                                    )))),
                                                        Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              color: whiteColor,
                                                              border:
                                                                  Border.all(
                                                                color:
                                                                    darkGreyColor,
                                                                width: 1,
                                                              ),
                                                            ),
                                                            child: Material(
                                                                type: MaterialType
                                                                    .transparency,
                                                                child: InkWell(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50),
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                          contextM);
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: 20.0
                                                                              .w,
                                                                          vertical:
                                                                              7.h),
                                                                      child:
                                                                          Text(
                                                                        "No",
                                                                        style: CustomTheme.mediumText(
                                                                            context),
                                                                      ),
                                                                    )))),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              );
                                              // return Container(
                                              //   child: Column(
                                              //     children: [
                                              //       Text(
                                              //           "Are you sure you want to delete this space?"),
                                              //       Row(
                                              //         children: [
                                              //           Text("Yes"),
                                              //           Text("No"),
                                              //         ],
                                              //       )
                                              //     ],
                                              //   ),
                                              // );
                                            });
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: redGradient1,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 15.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: TextField(
                                controller: aliasController,
                                decoration: InputDecoration(
                                  hintText: "Space Alias",
                                  hintStyle: CustomTheme.normalText(context)
                                      .copyWith(color: whiteColor),
                                  border: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: whiteColor, width: 2.0),
                                  ),
                                  disabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: whiteColor, width: 2.0),
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: whiteColor, width: 2.0),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: whiteColor, width: 2.0),
                                  ),
                                ),
                                style: CustomTheme.normalText(context)
                                    .copyWith(color: whiteColor),
                              ),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            StreamBuilder<DocumentSnapshot>(
                                stream: _locationFirestore
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
                                    return const Text("Something went wrong");
                                  }
                                  if (!snapshot.data!.exists) {
                                    return const Text(
                                        "No Locations have been added yet, add a location to add space or contact an adminr");
                                  }
                                  List location =
                                      snapshot.data!["location"] as List;
                                  List<String> locations = location
                                      .map((e) => e.toString())
                                      .toList();
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 24.w),
                                    child: CustomDropdown(
                                      items: locations,
                                      title: 'Select Location',
                                      value: selectedLocation.isNotEmpty
                                          ? selectedLocation
                                          : locations[0],
                                      onChanged: (val) {
                                        setState(() {
                                          selectedLocation = val;
                                        });
                                      },
                                    ),
                                  );
                                }),
                            SizedBox(
                              height: 10.h,
                            ),
                            ListView.builder(
                                padding: EdgeInsets.symmetric(horizontal: 24.w),
                                shrinkWrap: true,
                                itemCount: ref
                                    .watch(spaceProvider)!
                                    .appliances!
                                    .length,
                                itemBuilder: (context, index) {
                                  List<Appliances> appliances =
                                      ref.watch(spaceProvider)!.appliances!;
                                  globalAppliances = appliances;
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        appliances[index]
                                            .applianceName
                                            .toString(),
                                        style: CustomTheme.normalText(context)
                                            .copyWith(color: whiteColor),
                                      ),
                                      SizedBox(
                                          width: 200.w,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: whiteColor))),
                                            child: TextField(
                                              onChanged: (val) {
                                                appliances[index].quantity =
                                                    val;
                                                globalAppliances[index]
                                                    .quantity = val;
                                              },
                                              textAlign: TextAlign.center,
                                              textAlignVertical:
                                                  TextAlignVertical.bottom,
                                              maxLength: 1,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                hintText:
                                                    appliances[index].quantity,
                                                border: InputBorder.none,
                                                hintStyle:
                                                    CustomTheme.normalText(
                                                            context)
                                                        .copyWith(
                                                            color: whiteColor),
                                                counter: Offstage(),
                                              ),
                                              style: CustomTheme.normalText(
                                                      context)
                                                  .copyWith(color: whiteColor),
                                            ),
                                          ))
                                    ],
                                  );
                                })
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: CustomBorderButton(
                          onPressed: () {
                            ref.watch(storageProvider).editAdminSpace(
                                context,
                                Space(
                                    dateAdded:
                                        ref.watch(spaceProvider)!.dateAdded,
                                    type: aliasController.text,
                                    location: selectedLocation,
                                    sId: ref.watch(spaceProvider)!.sId,
                                    spaceOwner:
                                        "${box.get(StringConst.userDataKey)!.lastName!} ${box.get(StringConst.userDataKey)!.firstName!}",
                                    appliances: globalAppliances));
                          },
                          color: whiteColor,
                          borderColor: greenTextColor,
                          children: <Widget>[
                            Text(
                              "Done",
                              style: CustomTheme.normalText(context).copyWith(
                                color: greenTextColor,
                              ),
                            ),
                            SizedBox(
                              width: 10.0.w,
                            ),
                            Icon(
                              Icons.add_rounded,
                              color: greenTextColor,
                              size: 25.sp,
                            )
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
