import 'package:ems/exports.dart';
import 'package:flutter/gestures.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
        child: Scaffold(
            body: Stack(
              children: [
                Positioned.fill(
                  child: SafeArea(
                    child: Padding(
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
                                                      RouteGenerator.adminSignup);
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
                                Consumer(builder: (context, WidgetRef ref, child) {
                                  return CustomAuthButton(
                                    text: "Login",
                                    onPressed: () {
                                      ref
                                          .read(authenticationProvider.notifier)
                                          .loginAdmin(context, emailController.text,
                                              passwordController.text);
                                    },
                                  );
                                }),
                                SizedBox(height: 100.h),
                                CustomBorderButton(
                                  onPressed: () {
                                    setUserStatus(UserStatus.Staff);
                                    Navigator.pushNamed(
                                        context, RouteGenerator.staffLogin);
                                  },
                                  color: whiteColor,
                                  borderColor: greenTextColor,
                                  children: <Widget>[
                                    Text(
                                      "or Login as a staff",
                                      style:
                                          CustomTheme.normalText(context).copyWith(
                                        color: greenTextColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.0.w,
                                    ),
                                    SvgPicture.asset(
                                      "assets/svgs/Person.svg",
                                      fit: BoxFit.scaleDown,
                                    ),
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
            )));
  }
}
