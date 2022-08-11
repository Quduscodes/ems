import 'package:ems/exports.dart';

import 'custom_dropdown.dart';

final applianceList = StateProvider<List<Appliances>?>((ref) => null);

class AddAdminSpace extends ConsumerStatefulWidget {
  const AddAdminSpace({Key? key}) : super(key: key);

  @override
  _AddAdminSpaceState createState() => _AddAdminSpaceState();
}

class _AddAdminSpaceState extends ConsumerState<AddAdminSpace> {
  TextEditingController aliasController = TextEditingController();
  String selectedLocation = "";

  final UserData? user =
      Hive.box<UserData>(StringConst.userDataBox).get(StringConst.userDataKey);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {});
  }

  final CollectionReference _locationFirestore =
      FirebaseFirestore.instance.collection('locations');
  final CollectionReference _fireStore =
      FirebaseFirestore.instance.collection('appliances');
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
                                  Text('Add Space',
                                      style: CustomTheme.semiLargeText(context)
                                          .copyWith(color: whiteColor)),
                                  SizedBox(width: 4.8.w),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.h),
                            Expanded(
                              child: ListView(
                                padding: EdgeInsets.symmetric(horizontal: 24.w),
                                shrinkWrap: true,
                                children: [
                                  TextField(
                                    controller: aliasController,
                                    decoration: InputDecoration(
                                      hintText: "Space Alias",
                                      hintStyle: CustomTheme.normalText(context)
                                          .copyWith(color: whiteColor),
                                      border: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: whiteColor, width: 2.0),
                                      ),
                                      disabledBorder:
                                          const UnderlineInputBorder(
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
                                          return const Text(
                                              "Something went wrong");
                                        }
                                        if (!snapshot.data!.exists) {
                                          return const Text(
                                              "No Locations have been added yet, add a location to add space or contact an admin");
                                        }
                                        List location =
                                            snapshot.data!["location"] as List;
                                        List<String> locations = location
                                            .map((e) => e.toString())
                                            .toList();
                                        return CustomDropdown(
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
                                        );
                                      }),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  FutureBuilder<DocumentSnapshot>(
                                      future:
                                          _fireStore.doc("appliances").get(),
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
                                          return const Text(
                                              "No Appliances have been added yet, add a new appliance or contact an admin");
                                        }
                                        List appliance =
                                            snapshot.data!["appliance"] as List;
                                        List<Appliances> appliances = appliance
                                            .map((e) => Appliances.fromJson(e))
                                            .toList();
                                        if (appliance.isEmpty) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 24.w),
                                            child: CustomBorderButton(
                                              onPressed: () {
                                                Navigator.pushNamed(context,
                                                    RouteGenerator.appliances);
                                              },
                                              color: whiteColor,
                                              borderColor: greenTextColor,
                                              children: <Widget>[
                                                Text(
                                                  "There are no appliances yet, add new or contact an admin",
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
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          // Add Your Code here.
                                          if (appliances.isNotEmpty) {
                                            if (ref.watch(applianceList) ==
                                                null) {
                                              ref
                                                  .watch(applianceList.notifier)
                                                  .state = appliances;
                                            }
                                          }
                                        });
                                        return Column(
                                          children: [
                                            ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: ref
                                                    .watch(applianceList)!
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  return Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        ref
                                                            .watch(applianceList)![
                                                                index]
                                                            .applianceName
                                                            .toString(),
                                                        style: CustomTheme
                                                                .normalText(
                                                                    context)
                                                            .copyWith(
                                                                color:
                                                                    whiteColor),
                                                      ),
                                                      SizedBox(
                                                          width: 150.w,
                                                          child: Container(
                                                            decoration: const BoxDecoration(
                                                                border: Border(
                                                                    bottom: BorderSide(
                                                                        color:
                                                                            whiteColor))),
                                                            child: TextField(
                                                              onChanged: (val) {
                                                                ref
                                                                    .watch(applianceList)![
                                                                        index]
                                                                    .quantity = val;
                                                              },
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              textAlignVertical:
                                                                  TextAlignVertical
                                                                      .bottom,
                                                              maxLength: 1,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  const InputDecoration(
                                                                counter:
                                                                    Offstage(),
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                              ),
                                                              style: CustomTheme
                                                                      .normalText(
                                                                          context)
                                                                  .copyWith(
                                                                      color:
                                                                          whiteColor),
                                                            ),
                                                          ))
                                                    ],
                                                  );
                                                }),
                                            SizedBox(
                                              height: 40.h,
                                            ),
                                            CustomBorderButton(
                                              onPressed: () {
                                                if (ref.watch(applianceList) !=
                                                    null) {
                                                  final String id = DateTime
                                                          .now()
                                                      .microsecondsSinceEpoch
                                                      .toString();
                                                  ref.watch(storageProvider).addAdminSpace(
                                                      context,
                                                      Space(
                                                          dateAdded:
                                                              DateTime.now()
                                                                  .toString(),
                                                          type: aliasController
                                                              .text,
                                                          location:
                                                              selectedLocation,
                                                          sId: id,
                                                          spaceOwner:
                                                              "${box.get(StringConst.userDataKey)!.lastName!} ${box.get(StringConst.userDataKey)!.firstName!}",
                                                          appliances: ref.watch(
                                                              applianceList)!));
                                                }
                                              },
                                              color: whiteColor,
                                              borderColor: greenTextColor,
                                              children: <Widget>[
                                                Text(
                                                  "Add",
                                                  style: CustomTheme.normalText(
                                                          context)
                                                      .copyWith(
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
