import 'package:ems/add_locations.dart';
import 'package:ems/chat_window.dart';
import 'package:ems/exports.dart';

class BottomAppBarScreenAdmin extends ConsumerStatefulWidget {
  const BottomAppBarScreenAdmin({Key? key}) : super(key: key);

  @override
  _BottomAppBarScreenVendorState createState() =>
      _BottomAppBarScreenVendorState();
}

class _BottomAppBarScreenVendorState
    extends ConsumerState<BottomAppBarScreenAdmin> {
  final GlobalKey<ScaffoldState>? _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController? _pageController = PageController(initialPage: 0);
  int? _page = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        // For Android.
        // Use [light] for white status bar and [dark] for black status bar.
        statusBarIconBrightness: Brightness.dark,
        // For iOS.
        // Use [dark] for white status bar and [light] for black status bar.
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        backgroundColor: whiteColor,
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _page = page;
              });
            },
            physics: const NeverScrollableScrollPhysics(),
            children: bottomAppBarScreens!.toList(),
          ),
        ),
        bottomNavigationBar: Container(
          //height: 89.0.h,
          width: size.width,
          decoration: BoxDecoration(
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withOpacity(0.08),
                blurRadius: 30.0,
                spreadRadius: 0.0,
                offset: const Offset(0.0, -20.0),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 25.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (int i = 0; i < bottomAppBarScreens!.length; i++)
                  Expanded(
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(35.0.h),
                        onTap: () {
                          setState(() {
                            _pageController!.animateToPage(i,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                          });
                        },
                        child: Container(
                          width: 60.0.w,
                          height: 60.0.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            //borderRadius: BorderRadius.circular(35.0.h),
                            color: Colors.transparent,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                height: 40.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                      colors: i == _page
                                          ? [gradientGreen1, gradientGreen2]
                                          : [gradientGrey1, gradientGrey2]),
                                ),
                                alignment: Alignment.center,
                                child: i == _page
                                    ? SvgPicture.asset(
                                        bottomAppBarAsset![i].activeAssetImage!,
                                        //color:  whiteColor,
                                        fit: BoxFit.scaleDown,
                                      )
                                    : SvgPicture.asset(
                                        bottomAppBarAsset![i].assetImage!,
                                        //color:  whiteColor,
                                        fit: BoxFit.scaleDown,
                                      ),
                              ),
                              SizedBox(
                                height: 5.0.h,
                              ),
                              Text(
                                bottomAppBarAsset![i].assetName!,
                                style:
                                    CustomTheme.smallestText(context).copyWith(
                                  color: i == _page
                                      ? blackColor
                                      : greyTextColorShade2,
                                  fontWeight: i == _page
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          tooltip: "Add Products",
          // isExtended: true,
          child: const Icon(Icons.add, color: whiteColor),
          backgroundColor: blackColor,
          onPressed: () {
            Navigator.pushNamed(context, RouteGenerator.addAdminSpace);
            // Navigator.pushNamed(context, RouteGenerator.addNewProductScreen);
          },
        ),
      ),
    );
  }
}

List<Widget>? bottomAppBarScreens = [
  const AdminHomePage(),
  const LiveChatScreen(),
  const AppliancesView(),
  const LocationsView(),
];

class BottomAppBarAssetModel {
  final String? assetName;
  final String? assetImage;
  final String? activeAssetImage;

  BottomAppBarAssetModel(
      {this.assetName, this.assetImage, this.activeAssetImage});
}

List<BottomAppBarAssetModel>? bottomAppBarAsset = [
  BottomAppBarAssetModel(
    assetName: 'Dashboard',
    assetImage: "dashboard",
    activeAssetImage: "activeDashboard",
  ),
  BottomAppBarAssetModel(
    assetName: 'Orders',
    assetImage: "orders",
    activeAssetImage: "activeOrders",
  ),
  BottomAppBarAssetModel(
    assetName: 'Products',
    assetImage: "product",
    activeAssetImage: "activeProduct",
  ),
  BottomAppBarAssetModel(
    assetName: 'VendorCentral',
    assetImage: "vendorCentralIcon",
    activeAssetImage: "activeVendorCentral",
  ),
];
