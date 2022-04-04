import 'package:ems/exports.dart';
import 'package:flutter/gestures.dart';

class StaffLogin extends StatefulWidget {
  const StaffLogin({Key? key}) : super(key: key);

  @override
  State<StaffLogin> createState() => _StaffLoginState();
}

class _StaffLoginState extends State<StaffLogin> {
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
            body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SizedBox(
              height: size.height,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BKButton(
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            RichText(
                                text: TextSpan(
                                    text: "Don’t have an account?",
                                    style: CustomTheme.smallText(context)
                                        .copyWith(),
                                    children: <TextSpan>[
                                  TextSpan(
                                      text: ' Sign Up.',
                                      style: CustomTheme.smallText(context)
                                          .copyWith(color: primaryColor),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushNamed(context,
                                              RouteGenerator.staffSignup);
                                        })
                                ]))
                          ],
                        ),
                        SizedBox(height: 90.h),
                        Text(
                          "Welcome Back!🤗",
                          textAlign: TextAlign.center,
                          style: CustomTheme.semiLargeText(context).copyWith(
                              fontFamily: GoogleFonts.lobster().fontFamily,
                              fontSize: 25.sp),
                        ),
                        SizedBox(height: 25.h),
                        const AuthTextFieldWidget(
                          keyboardType: TextInputType.emailAddress,
                          text: 'Email',
                        ),
                        SizedBox(height: 20.h),
                        const AuthPasswordField(
                          text: "Password",
                        ),
                        SizedBox(height: 40.h),
                        CustomAuthButton(
                          text: "Login",
                          onPressed: () {},
                        ),
                        SizedBox(height: 100.h),
                        CustomBorderButton(
                          onPressed: () {
                            setUserStatus(UserStatus.Admin);
                            Navigator.pushNamed(
                                context, RouteGenerator.adminLogin);
                          },
                          color: whiteColor,
                          borderColor: greenTextColor,
                          children: <Widget>[
                            Text(
                              "or Login as an admin",
                              style: CustomTheme.normalText(context).copyWith(
                                color: greenTextColor,
                              ),
                            ),
                            SizedBox(
                              width: 10.0.w,
                            ),
                            Icon(
                              Icons.admin_panel_settings,
                              color: greenTextColor,
                              size: 25.sp,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )));
  }
}
