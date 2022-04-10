import 'package:ems/exports.dart';

class AddAdminSpace extends ConsumerStatefulWidget {
  const AddAdminSpace({Key? key}) : super(key: key);

  @override
  _AddAdminSpaceState createState() => _AddAdminSpaceState();
}

class _AddAdminSpaceState extends ConsumerState<AddAdminSpace> {
  TextEditingController aliasController = TextEditingController();

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
                    body: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
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
                                          ref.watch(storageProvider).addAdminSpace(
                                              context,
                                              Space(
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
                ));
              });
        }));
  }
}
