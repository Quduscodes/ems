import 'package:ems/exports.dart';

class StaffAppliancesView extends StatefulWidget {
  const StaffAppliancesView({Key? key}) : super(key: key);

  @override
  State<StaffAppliancesView> createState() => _StaffAppliancesViewState();
}

class _StaffAppliancesViewState extends State<StaffAppliancesView> {
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
                                            child: Text(
                                              "No appliance have been added yet, contact an admin.",
                                              style: CustomTheme.normalText(
                                                      context)
                                                  .copyWith(
                                                color: greenTextColor,
                                              ),
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
                                                      ],
                                                    ),
                                                  );
                                                }),
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
