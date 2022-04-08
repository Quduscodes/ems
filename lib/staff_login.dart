import 'package:ems/exports.dart';
import 'package:flutter/gestures.dart';

class StaffLogin extends StatefulWidget {
  const StaffLogin({Key? key}) : super(key: key);

  @override
  State<StaffLogin> createState() => _StaffLoginState();
}

class _StaffLoginState extends State<StaffLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
        child:
            Scaffold(body: Consumer(builder: (context, WidgetRef ref, child) {
          return Stack(
            children: [
              Positioned.fill(
                child: SafeArea(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BKButton(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    RichText(
                                        text: TextSpan(
                                            text: "Don’t have an account?",
                                            style:
                                                CustomTheme.smallText(context)
                                                    .copyWith(),
                                            children: <TextSpan>[
                                          TextSpan(
                                              text: ' Sign Up.',
                                              style:
                                                  CustomTheme.smallText(context)
                                                      .copyWith(
                                                          color: primaryColor),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      RouteGenerator
                                                          .staffSignup);
                                                })
                                        ]))
                                  ],
                                ),
                                SizedBox(height: 90.h),
                                Text(
                                  "Welcome Back!🤗",
                                  textAlign: TextAlign.center,
                                  style: CustomTheme.semiLargeText(context)
                                      .copyWith(
                                          fontFamily:
                                              GoogleFonts.lobster().fontFamily,
                                          fontSize: 25.sp),
                                ),
                                SizedBox(height: 25.h),
                                AuthTextFieldWidget(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  text: 'Email',
                                ),
                                SizedBox(height: 20.h),
                                AuthPasswordField(
                                  controller: passwordController,
                                  text: "Password",
                                ),
                                SizedBox(height: 40.h),
                                CustomAuthButton(
                                  text: "Login",
                                  onPressed: () {
                                    ref
                                        .read(authenticationProvider.notifier)
                                        .loginUser(
                                            context,
                                            emailController.text,
                                            passwordController.text);
                                  },
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
                                      style: CustomTheme.normalText(context)
                                          .copyWith(
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
                ),
              ),
              Positioned.fill(
                child: Consumer(builder: (context, WidgetRef ref, child) {
                  return ref.watch(authLoader)
                      ? LoadingModal(
                          inAsyncCall: ref.watch(authLoader),
                        )
                      : const SizedBox();
                }),
              )
            ],
          );
        })));
  }
}
