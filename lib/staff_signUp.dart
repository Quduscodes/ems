import 'package:ems/exports.dart';
import 'package:flutter/gestures.dart';

class StaffSignUp extends StatefulWidget {
  const StaffSignUp({Key? key}) : super(key: key);

  @override
  State<StaffSignUp> createState() => _StaffSignUpState();
}

class _StaffSignUpState extends State<StaffSignUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  // final TextEditingController emailController = TextEditingController();

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
                            AuthTextFieldWidget(
                              controller: firstNameController,
                              keyboardType: TextInputType.emailAddress,
                              text: 'First Name',
                            ),
                            SizedBox(height: 20.h),
                            AuthTextFieldWidget(
                              controller: lastNameController,
                              keyboardType: TextInputType.emailAddress,
                              text: 'Last Name',
                            ),
                            SizedBox(height: 20.h),
                            AuthPasswordField(
                              controller: passwordController,
                              text: "Password",
                            ),
                            SizedBox(height: 40.h),
                            Consumer(builder: (context, WidgetRef ref, child) {
                              return CustomAuthButton(
                                text: "Sign Up",
                                onPressed: () {
                                  ref
                                      .read(authenticationProvider.notifier)
                                      .registerUser(
                                          context,
                                          emailController.text,
                                          passwordController.text,
                                          firstNameController.text,
                                          lastNameController.text);
                                },
                              );
                            }),
                            SizedBox(height: 100.h),
                            CustomBorderButton(
                              onPressed: () {
                                setUserStatus(UserStatus.Admin);
                                Navigator.pushNamed(
                                    context, RouteGenerator.adminSignup);
                              },
                              color: whiteColor,
                              borderColor: greenTextColor,
                              children: <Widget>[
                                Text(
                                  "or sign up as an admin",
                                  style:
                                      CustomTheme.normalText(context).copyWith(
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