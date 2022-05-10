import 'package:ems/add_locations.dart';
import 'package:ems/exports.dart';
import 'package:ems/extensions.dart';
import 'package:ems/stats.dart';

import 'help_support.dart';

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
        statusBarIconBrightness: Brightness.light,
        // For iOS.
        // Use [dark] for white status bar and [light] for black status bar.
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        backgroundColor: swatch24,
        body: PageView(
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              _page = page;
            });
          },
          physics: const NeverScrollableScrollPhysics(),
          children: bottomAppBarScreens!.toList(),
        ),
        bottomNavigationBar: Container(
          //height: 89.0.h,
          width: size.width,
          decoration: BoxDecoration(
            color: swatch24,
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
            padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 10.0.h),
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
                          height: 55.0.h,
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
                                  height: 25.h,
                                  width: 30.w,
                                  alignment: Alignment.center,
                                  child: SvgPicture.asset(
                                    bottomAppBarAsset![i].assetImage!,
                                    color: i == _page ? swatch6 : swatch22,
                                    fit: BoxFit.scaleDown,
                                  )),
                              SizedBox(
                                height: 5.0.h,
                              ),
                              Text(
                                bottomAppBarAsset![i].assetName!,
                                style: CustomTheme.smallText(context).copyWith(
                                  color: i == _page ? swatch6 : swatch22,
                                  fontWeight: i == _page
                                      ? FontWeight.w700
                                      : FontWeight.w500,
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
      ),
    );
  }
}

List<Widget>? bottomAppBarScreens = [
  const AdminHomePage(),
  const HelpAndSupport(),
  const Stats(),
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
    assetName: 'HOME',
    assetImage: "home".svg,
    activeAssetImage: "activeDashboard",
  ),
  BottomAppBarAssetModel(
    assetName: 'Orders',
    assetImage: "home".svg,
    activeAssetImage: "activeOrders",
  ),
  BottomAppBarAssetModel(
    assetName: 'STATS',
    assetImage: "home".svg,
    activeAssetImage: "activeProduct",
  ),
  BottomAppBarAssetModel(
    assetName: 'VendorCentral',
    assetImage: "home".svg,
    activeAssetImage: "activeVendorCentral",
  ),
];
