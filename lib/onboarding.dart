import 'package:ems/exports.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  //PageController pageController;

  PageController backgGroundController = PageController(initialPage: 0);
  PageController containerController = PageController(initialPage: 0);

  void onItemTapped(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //final theme = Theme.of(context);
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
        backgroundColor: whiteColor,
        body: Container(
          color: whiteColor,
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Positioned.fill(
                child: PageView.builder(
                  controller: backgGroundController,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: onItemTapped,
                  itemCount: onBoardingList!.length,
                  itemBuilder: (context, index) {
                    return Image.asset(onBoardingList![index].image!,
                        fit: BoxFit.cover);
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                      child: _currentIndex ==
                              (onBoardingList!.length - onBoardingList!.length)
                          ? const SizedBox()
                          : Container(
                              margin: EdgeInsets.only(
                                bottom: ScreenUtil().setHeight(20),
                              ),
                              decoration: BoxDecoration(
                                  color: whiteColor.withOpacity(0.3),
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(24.0),
                                      bottomRight: Radius.circular(24.0))),
                              width: 15.0.w,
                              height: 350.0.h,
                              child: Material(
                                type: MaterialType.transparency,
                                child: InkWell(
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(24.0),
                                      bottomRight: Radius.circular(24.0)),
                                  onTap: () {
                                    containerController.previousPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeIn,
                                    );
                                    backgGroundController.previousPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeIn,
                                    );
                                  },
                                ),
                              ),
                            ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                            bottom: ScreenUtil().setHeight(40),
                            left: ScreenUtil().setWidth(20),
                            right: ScreenUtil().setWidth(20)),
                        //width: 311.0.w,
                        height: 400.0.h,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(45.0),
                        ),
                        child: PageView.builder(
                          controller: containerController,
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: onBoardingList!.length,
                          onPageChanged: onItemTapped,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32.0.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 40.0.h,
                                  ),
                                  Text(
                                    onBoardingList![index].header!,
                                    textAlign: TextAlign.center,
                                    style:
                                        CustomTheme.largeText(context).copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: blackColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0.h,
                                  ),
                                  Text(
                                    onBoardingList![index].description!,
                                    textAlign: TextAlign.center,
                                    style: CustomTheme.normalText(context)
                                        .copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: blackColor.withOpacity(0.4),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                        child: _currentIndex != (onBoardingList!.length - 1)
                            ? Container(
                                margin: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(20),
                                ),
                                decoration: BoxDecoration(
                                    color: whiteColor.withOpacity(0.3),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(24.0),
                                        bottomLeft: Radius.circular(24.0))),
                                width: 15.0.w,
                                height: 350.0.h,
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: InkWell(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(24.0),
                                        bottomLeft: Radius.circular(24.0)),
                                    onTap: () {
                                      containerController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeIn,
                                      );
                                      backgGroundController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeIn,
                                      );
                                    },
                                  ),
                                ),
                              )
                            : const SizedBox()),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                //bott
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          for (int i = 0; i < onBoardingList!.length; i++)
                            if (i == _currentIndex) ...[
                              circularIndicator(true)
                            ] else
                              circularIndicator(false),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.0.h,
                    ),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                      child: _currentIndex != (onBoardingList!.length - 1)
                          ? Container(
                              margin: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(70)),
                              width: 80.0.w,
                              height: 80.0.h,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  color:
                                      const Color(0xFF2BAF6F).withOpacity(0.3),
                                  width: 1.0,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Container(
                                  width: 60.0.w,
                                  height: 60.0.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: whiteColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF369246)
                                            .withOpacity(0.058),
                                        offset: const Offset(0, 1.58),
                                        blurRadius: 3.76,
                                      ),
                                      BoxShadow(
                                        color: const Color(0xFF369246)
                                            .withOpacity(0.09),
                                        offset: const Offset(0, 7.2),
                                        blurRadius: 10.76,
                                      ),
                                      BoxShadow(
                                        color: const Color(0xFF369246)
                                            .withOpacity(0.13),
                                        offset: const Offset(0, 18.23),
                                        blurRadius: 28.34,
                                      )
                                    ],
                                    gradient: const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        firstGradient,
                                        secondGradient,
                                      ],
                                    ),
                                  ),
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: InkWell(
                                      borderRadius:
                                          BorderRadius.circular(30.0.h),
                                      onTap: () {
                                        containerController.nextPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeIn,
                                        );
                                        backgGroundController.nextPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeIn,
                                        );
                                      },
                                      child: const Center(
                                        child: Icon(
                                          Icons.arrow_forward,
                                          color: whiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(
                                bottom: ScreenUtil().setHeight(100),
                                left: ScreenUtil().setWidth(50),
                                right: ScreenUtil().setWidth(50),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: size.width * 0.5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: const LinearGradient(
                                          colors: [
                                            gradientGreen1,
                                            gradientGreen2
                                          ],
                                        ),
                                      ),
                                      child: Material(
                                        type: MaterialType.transparency,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          onTap: () {
                                            setUserStatus(UserStatus.Staff);
                                            Navigator.pushNamed(context,
                                                RouteGenerator.staffSignup);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                    "assets/svgs/Person.svg",
                                                    fit: BoxFit.scaleDown,
                                                    color: whiteColor),
                                                SizedBox(width: 12.0.w),
                                                Text(
                                                  "Sign Up",
                                                  style: CustomTheme.normalText(
                                                          context)
                                                      .copyWith(
                                                          color: whiteColor,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0.w,
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: size.width * 0.5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: whiteColor,
                                        border: Border.all(
                                          color: greenColorShade2,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Material(
                                        type: MaterialType.transparency,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          onTap: () {
                                            setUserStatus(UserStatus.Staff);
                                            Navigator.pushNamed(context,
                                                RouteGenerator.staffLogin);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/svgs/unlock.svg",
                                                  fit: BoxFit.scaleDown,
                                                ),
                                                SizedBox(width: 15.0.w),
                                                Text(
                                                  "Log in",
                                                  style: CustomTheme.normalText(
                                                          context)
                                                      .copyWith(
                                                          color: greenTextColor,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget circularIndicator(
  bool value,
) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 2.0.w),
    //duration: const Duration(milliseconds: 300),
    height: value == true ? 5.0.h : 12.0.h,
    width: value == true ? 5.0.w : 5.0.w,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular((5.0.h + 5.0.w) * 0.2),
        color: value == true ? primaryColor : whiteColorShade4),
  );
}

class OnBoardingModel {
  final String? image;
  final String? header;
  final String? description;

  OnBoardingModel({
    this.image,
    this.header,
    this.description,
  });
}

List<OnBoardingModel>? onBoardingList = [
  OnBoardingModel(
      image: "assets/images/background.jpg",
      header: 'Real-Time Data, ⏱️\nZero Delay!',
      description:
          "View real-time electrical data statistics on your device wherever you are."),
  OnBoardingModel(
      image: "assets/images/background2.png",
      header: 'All your electrical data in one place 🔒',
      description:
          "View and store all your electrical data in one secure place."),
  OnBoardingModel(
      image: "assets/images/background3.jpg",
      header: 'Export data as csv',
      description:
          "Export data as csv and view meaningful computations of your electrical data."),
  OnBoardingModel(
      image: "assets/images/background.jpg",
      header: 'Save extra cash! 🤑',
      description:
          "Make proper allocations for your resources and save extra cash for other services."),
];
