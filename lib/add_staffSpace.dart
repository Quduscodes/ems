import 'package:ems/exports.dart';

import 'custom_dropdown.dart';

class ConfigureSpaceStaff extends StatefulWidget {
  const ConfigureSpaceStaff({Key? key}) : super(key: key);

  @override
  State<ConfigureSpaceStaff> createState() => _ConfigureSpaceStaff();
}

class _ConfigureSpaceStaff extends State<ConfigureSpaceStaff> {
  TextEditingController aliasController = TextEditingController();
  String selectedLocation = "";

  final CollectionReference _locationFirestore =
      FirebaseFirestore.instance.collection('locations');
  final UserData? user =
      Hive.box<UserData>(StringConst.userDataBox).get(StringConst.userDataKey);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {});
  }

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
                                'Add Space',
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
                              TextField(
                                controller: aliasController,
                                decoration: const InputDecoration(
                                  hintText: "Space Alias",
                                  border: InputBorder.none,
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
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
                                          "No Locations have been added yet");
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
                              StreamBuilder<DocumentSnapshot>(
                                  stream:
                                      _fireStore.doc("appliances").snapshots(),
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
                                              style:
                                                  CustomTheme.normalText(context)
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
                                            itemCount: appliances.length,
                                            itemBuilder: (context, index) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(appliances[index]
                                                      .applianceName
                                                      .toString()),
                                                  SizedBox(
                                                      width: 200.w,
                                                      child: Container(
                                                        decoration: const BoxDecoration(
                                                            border: Border(
                                                                bottom: BorderSide(
                                                                    color:
                                                                        blackColor))),
                                                        child: TextField(
                                                          onChanged: (val) {
                                                            appliances[index]
                                                                .quantity = val;
                                                          },
                                                          decoration:
                                                              const InputDecoration(
                                                            border:
                                                                InputBorder.none,
                                                          ),
                                                        ),
                                                      ))
                                                ],
                                              );
                                            }),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        CustomBorderButton(
                                          onPressed: () {
                                            final String id = DateTime.now()
                                                .microsecondsSinceEpoch
                                                .toString();
                                            ref.watch(storageProvider).addUserSpace(
                                                context,
                                                Space(
                                                    location: selectedLocation,
                                                    dateAdded:
                                                        DateTime.now().toString(),
                                                    type: aliasController.text,
                                                    sId: id,
                                                    spaceOwner:
                                                        "${box.get(StringConst.userDataKey)!.lastName!} ${box.get(StringConst.userDataKey)!.firstName!}",
                                                    appliances: appliances));
                                          },
                                          color: whiteColor,
                                          borderColor: greenTextColor,
                                          children: <Widget>[
                                            Text(
                                              "Add",
                                              style:
                                                  CustomTheme.normalText(context)
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
