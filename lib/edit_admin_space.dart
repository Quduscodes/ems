import 'package:ems/exports.dart';

class EditAdminSpace extends ConsumerStatefulWidget {
  const EditAdminSpace({Key? key}) : super(key: key);

  @override
  _EditAdminSpaceState createState() => _EditAdminSpaceState();
}

class _EditAdminSpaceState extends ConsumerState<EditAdminSpace> {
  TextEditingController aliasController = TextEditingController();

  final UserData? user =
      Hive.box<UserData>(StringConst.userDataBox).get(StringConst.userDataKey);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      aliasController.text = ref.watch(spaceProvider)!.type ?? '';
    });
  }

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
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BackButton(),
                                Text("Edit Space"),
                                InkWell(
                                  onTap: () {
                                    ref
                                        .watch(storageProvider.notifier)
                                        .deleteAdminSpace(context);
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: redGradient1,
                                  ),
                                )
                              ],
                            ),
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
                            ListView.builder(
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
                                      Text(appliances[index]
                                          .applianceName
                                          .toString()),
                                      SizedBox(
                                          width: 200.w,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: blackColor))),
                                            child: TextField(
                                              onChanged: (val) {
                                                appliances[index].quantity =
                                                    val;
                                                globalAppliances[index]
                                                    .quantity = val;
                                              },
                                              decoration: InputDecoration(
                                                hintText:
                                                    appliances[index].quantity,
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ))
                                    ],
                                  );
                                })
                          ],
                        ),
                      ),
                      CustomBorderButton(
                        onPressed: () {
                          ref.watch(storageProvider).editAdminSpace(
                              context,
                              Space(
                                  dateAdded:ref.watch(spaceProvider)!.dateAdded,
                                  type: aliasController.text,
                                  sId: ref.watch(spaceProvider)!.sId,
                                  spaceOwner:
                                      "${box.get(StringConst.userDataKey)!.lastName!} ${box.get(StringConst.userDataKey)!.firstName!}",
                                  appliances: globalAppliances));
                        },
                        color: whiteColor,
                        borderColor: greenTextColor,
                        children: <Widget>[
                          Text(
                            "Edit Space",
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
                ));
              });
        }));
  }
}
