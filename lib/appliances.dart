import 'package:ems/exports.dart';

class AppliancesView extends StatefulWidget {
  const AppliancesView({Key? key}) : super(key: key);

  @override
  State<AppliancesView> createState() => _AppliancesViewState();
}

class _AppliancesViewState extends State<AppliancesView> {
  final CollectionReference _fireStore =
      FirebaseFirestore.instance.collection('appliances');

  final TextEditingController applianceController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();
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
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
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
                                  Text('APPLIANCES',
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
                                          .doc("appliances")
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
                                                  "No Appliances have been added"),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              AddAppliance()
                                            ],
                                          );
                                        }
                                        List appliance =
                                            snapshot.data!["appliance"] as List;
                                        List<Appliances> appliances = appliance
                                            .map((e) => Appliances.fromJson(e))
                                            .toList();
                                        if (appliance.isEmpty) {
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
                                                                  "Add Appliance",
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
                                                                      "Appliance Name:",
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
                                                                                applianceController,
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
                                                              Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      "Appliance Rating:",
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
                                                                                ratingController,
                                                                            decoration:
                                                                                const InputDecoration(
                                                                              border: InputBorder.none,
                                                                            ),
                                                                          ),
                                                                        ))
                                                                  ]),
                                                              const Expanded(
                                                                child:
                                                                    SizedBox(),
                                                              ),
                                                              CustomBorderButton(
                                                                onPressed: () {
                                                                  final String
                                                                      id =
                                                                      DateTime.now()
                                                                          .microsecondsSinceEpoch
                                                                          .toString();
                                                                  ref.watch(storageProvider).addAppliance(
                                                                      context,
                                                                      Appliances(
                                                                          sId:
                                                                              id,
                                                                          applianceName: applianceController
                                                                              .text,
                                                                          rating:
                                                                              ratingController.text));
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
                                                itemCount: appliances.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10.h),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                appliances[
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
                                                                width: 10.w,
                                                              ),
                                                              Text(
                                                                appliances[
                                                                        index]
                                                                    .rating
                                                                    .toString(),
                                                                style: CustomTheme
                                                                        .normalText(
                                                                            context)
                                                                    .copyWith(
                                                                        color:
                                                                            whiteColor),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        InkWell(
                                                            onTap: () {
                                                              ref
                                                                  .watch(storageProvider
                                                                      .notifier)
                                                                  .deleteAppliance(
                                                                      context,
                                                                      appliances[
                                                                          index]);
                                                            },
                                                            child: const Icon(
                                                              Icons.delete,
                                                              color: whiteColor,
                                                            )),
                                                        SizedBox(
                                                          width: 15.w,
                                                        ),
                                                        InkWell(
                                                            onTap: () {
                                                              Appliances
                                                                  appliance =
                                                                  appliances[
                                                                      index];
                                                              ratingController
                                                                      .text =
                                                                  appliance
                                                                      .rating!;
                                                              applianceController
                                                                      .text =
                                                                  appliance
                                                                      .applianceName!;
                                                              showModalBottomSheet(
                                                                  context:
                                                                      context,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  isScrollControlled:
                                                                      true,
                                                                  builder:
                                                                      (context) {
                                                                    return Padding(
                                                                      padding: MediaQuery.of(
                                                                              context)
                                                                          .viewInsets,
                                                                      child:
                                                                          Container(
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                24.w,
                                                                            vertical: 30.h),
                                                                        decoration: const BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                                                            color: whiteColor),
                                                                        height:
                                                                            400.h,
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Text("Edit Appliance",
                                                                                style: CustomTheme.mediumText(context).copyWith()),
                                                                            SizedBox(
                                                                              height: 20.h,
                                                                            ),
                                                                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                                              Text(
                                                                                "Appliance Name:",
                                                                                style: CustomTheme.normalText(context).copyWith(),
                                                                              ),
                                                                              SizedBox(
                                                                                  width: 200.w,
                                                                                  child: Container(
                                                                                    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: blackColor))),
                                                                                    child: TextField(
                                                                                      controller: applianceController,
                                                                                      decoration: const InputDecoration(
                                                                                        border: InputBorder.none,
                                                                                      ),
                                                                                    ),
                                                                                  ))
                                                                            ]),
                                                                            SizedBox(
                                                                              height: 20.h,
                                                                            ),
                                                                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                                              Text(
                                                                                "Appliance Rating:",
                                                                                style: CustomTheme.normalText(context).copyWith(),
                                                                              ),
                                                                              SizedBox(
                                                                                  width: 200.w,
                                                                                  child: Container(
                                                                                    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: blackColor))),
                                                                                    child: TextField(
                                                                                      controller: ratingController,
                                                                                      decoration: const InputDecoration(
                                                                                        border: InputBorder.none,
                                                                                      ),
                                                                                      textAlign: TextAlign.center,
                                                                                      textAlignVertical: TextAlignVertical.bottom,
                                                                                      keyboardType: TextInputType.number,
                                                                                    ),
                                                                                  ))
                                                                            ]),
                                                                            const Expanded(
                                                                              child: SizedBox(),
                                                                            ),
                                                                            CustomBorderButton(
                                                                              onPressed: () {
                                                                                ref.watch(applianceDataListProvider.notifier).state = appliances;
                                                                                ref.watch(storageProvider).editAppliance(context, Appliances(applianceName: applianceController.text, rating: ratingController.text, sId: appliance.sId), index);
                                                                              },
                                                                              color: whiteColor,
                                                                              borderColor: greenTextColor,
                                                                              children: <Widget>[
                                                                                Text(
                                                                                  "Edit",
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
                                                                            SizedBox(
                                                                              height: 20.h,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  });
                                                            },
                                                            child: const Icon(
                                                              Icons.edit,
                                                              color: whiteColor,
                                                            ))
                                                      ],
                                                    ),
                                                  );
                                                }),
                                            AddAppliance()
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

class AddAppliance extends StatelessWidget {
  AddAppliance({
    Key? key,
  }) : super(key: key);

  final TextEditingController applianceController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      child: Consumer(builder: (context, WidgetRef ref, child) {
        return CustomBorderButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (context) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 30.h),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20)),
                          color: whiteColor),
                      height: 400.h,
                      child: Column(
                        children: [
                          Text("Add Appliance",
                              style:
                                  CustomTheme.mediumText(context).copyWith()),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Appliance Name:",
                                  style: CustomTheme.normalText(context)
                                      .copyWith(),
                                ),
                                SizedBox(
                                    width: 200.w,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: blackColor))),
                                      child: TextField(
                                        controller: applianceController,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ))
                              ]),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Appliance Rating:",
                                  style: CustomTheme.normalText(context)
                                      .copyWith(),
                                ),
                                SizedBox(
                                    width: 200.w,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: blackColor))),
                                      child: TextField(
                                        controller: ratingController,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          counter: Offstage(),
                                        ),
                                        textAlign: TextAlign.center,
                                        textAlignVertical:
                                            TextAlignVertical.bottom,
                                        keyboardType: TextInputType.number,
                                      ),
                                    ))
                              ]),
                          const Expanded(
                            child: SizedBox(),
                          ),
                          CustomBorderButton(
                            onPressed: () {
                              final String id = DateTime.now()
                                  .microsecondsSinceEpoch
                                  .toString();
                              ref.watch(storageProvider).addAppliance(
                                  context,
                                  Appliances(
                                      sId: id,
                                      applianceName: applianceController.text,
                                      rating: ratingController.text));
                            },
                            color: whiteColor,
                            borderColor: greenTextColor,
                            children: <Widget>[
                              Text(
                                "Add",
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
              style: CustomTheme.normalText(context).copyWith(
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
        );
      }),
    );
  }
}
