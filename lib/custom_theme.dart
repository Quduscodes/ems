import 'package:ems/exports.dart';

class CustomTheme {
  static ThemeData getTheme() {
    return _themeData();
  }

  static TextStyle largeText(BuildContext context) {
    return Theme.of(context).textTheme.headline1!.copyWith(
          fontSize: 25.0.sp,
          fontWeight: FontWeight.w700,
          color: blackColor,
          fontFamily: GoogleFonts.mulish().fontFamily,
        );
  }

  static TextStyle semiLargeText(BuildContext context) {
    return Theme.of(context).textTheme.headline1!.copyWith(
          fontSize: 20.0.sp,
          fontWeight: FontWeight.w700,
          color: blackColor,
          fontFamily: GoogleFonts.mulish().fontFamily,
        );
  }

  static TextStyle mediumText(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(
          fontSize: 16.0.sp,
          fontWeight: FontWeight.w700,
          color: blackColor,
          fontFamily: GoogleFonts.mulish().fontFamily,
        );
  }

  static TextStyle normalText(BuildContext context) {
    return Theme.of(context).textTheme.headline1!.copyWith(
          fontSize: 14.0.sp,
          fontWeight: FontWeight.w500,
          color: blackColor,
          fontFamily: GoogleFonts.mulish().fontFamily,
        );
  }

  static TextStyle smallText(BuildContext context) {
    return Theme.of(context).textTheme.headline1!.copyWith(
          fontSize: 12.0.sp,
          fontWeight: FontWeight.w300,
          color: blackColor,
          fontFamily: GoogleFonts.mulish().fontFamily,
        );
  }

  static TextStyle smallestText(BuildContext context) {
    return Theme.of(context).textTheme.headline1!.copyWith(
          fontSize: 10.0.sp,
          fontWeight: FontWeight.w300,
          color: blackColor,
          fontFamily: GoogleFonts.mulish().fontFamily,
        );
  }

  static ThemeData _themeData() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      primaryColor: const Color(0xff26AD71),
      fontFamily: GoogleFonts.mulish().fontFamily,
      //accentColor: Colors.black,
      // textTheme: _textTheme(),
      //typography: Typography(),
      snackBarTheme: const SnackBarThemeData(
          elevation: 0.0, backgroundColor: Colors.transparent),
      platform: TargetPlatform.iOS,
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }),
    );
  }
}

// class CustomTheme {

// }
