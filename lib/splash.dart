import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ems/exports.dart';
import 'package:flutter/rendering.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
        //backgroundColor: theme.backgroundColor,
        body: Stack(
          children: [
            Positioned.fill(
              child: Container(
                height: height,
                width: width,
                decoration: const BoxDecoration(
                  //color: blackColor,
                  image: DecorationImage(
                    image: AssetImage("assets/images/onboardingGif.gif"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned.fill(
                child: Container(
              width: width,
              height: height,
              color: blackColor.withOpacity(0.7),
            )),
            Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "EPMS",
                        style: CustomTheme.largeText(context).copyWith(
                            fontFamily: GoogleFonts.lobster().fontFamily,
                            color: Colors.white,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      AnimatedTextKit(repeatForever: true, animatedTexts: [
                        FadeAnimatedText('Electrical Power Management System',
                            textStyle: CustomTheme.largeText(context).copyWith(
                                fontFamily:
                                    GoogleFonts.alegreyaSans().fontFamily,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                            duration: const Duration(seconds: 3),
                            fadeOutBegin: 0.9,
                            fadeInEnd: 0.7)
                      ]),
                    ],
                  ),
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(50)),
                width: 80.0.w,
                height: 80.0.h,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: whiteColor.withOpacity(0.2),
                    width: 3.0,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 60.0.w,
                    height: 60.0.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: whiteColor,
                    ),
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30.0.h),
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouteGenerator.onboarding);
                          // Navigator.pushNamed(
                          //     context, RouteGenerator.onboarding);
                        },
                        child: const Center(
                          child: Icon(Icons.arrow_forward, color: primaryColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
