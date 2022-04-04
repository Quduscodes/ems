import 'package:ems/exports.dart';

class AuthTextFieldWidget extends StatelessWidget {
  final String? text;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final bool? enableText;
  final Function(String?)? validator;
  final int? maxLines;

  const AuthTextFieldWidget(
      {Key? key,
      required this.text,
      this.controller,
      required this.keyboardType,
      this.prefixIcon,
      this.enableText,
      this.validator,
      this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: whiteColorShade1,
      ),
      child: TextFormField(
        maxLines: maxLines ?? 1,
        enabled: enableText ?? true,
        //obscureText: obscureText == true ? true : false,
        keyboardType: keyboardType,
        controller: controller,
        validator: (value) {
          validator != null ? validator!(value) : null;
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15.0.h),
          label: Text(text!),
          labelStyle: CustomTheme.normalText(context)
              .copyWith(fontWeight: FontWeight.w400),
          prefixIcon: prefixIcon == null
              ? const Icon(Icons.mail_sharp, color: Color(0xff777777))
              : prefixIcon!,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

// class VerificationField extends StatelessWidget {
//   final TextEditingController? controller;
//   final String? text;
//   const VerificationField({Key? key, this.controller, this.text})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: whiteColorShade1,
//       ),
//       child: TextFormField(
//         //enabled: enableText == null ? true : enableText,
//         //obscureText: obscureText == true ? true : false,
//         keyboardType: TextInputType.text,
//         controller: controller,
//
//         decoration: InputDecoration(
//             border: InputBorder.none,
//             hintText: "Enter Verification Code",
//             hintStyle: CustomTheme.normalText(context).copyWith(
//               fontWeight: FontWeight.w400,
//               color: blackColor,
//             ),
//             contentPadding:
//                 EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 10.0.w),
//             // label: Text(text!),
//             // labelStyle: CustomTheme.normalText(context)
//             //     .copyWith(fontWeight: FontWeight.w400),
//
//             prefix: Container(
//               margin: EdgeInsets.only(right: 10.0.w),
//               decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [firstGradient, secondGradient],
//                   ),
//                   borderRadius: BorderRadius.circular(20.0)),
//               child: Material(
//                 type: MaterialType.transparency,
//                 child: InkWell(
//                   borderRadius: BorderRadius.circular(20.0),
//                   onTap: () {},
//                   child: Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         SvgPicture.asset(
//                           chatIcon,
//                           fit: BoxFit.scaleDown,
//                         ),
//                         SizedBox(width: 10.0.w),
//                         Text(
//                           "Send Code",
//                           style: CustomTheme.normalText(context).copyWith(
//                               color: whiteColor, fontWeight: FontWeight.w600),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             )),
//       ),
//     );
//   }
// }

class AuthPasswordField extends StatefulWidget {
  final String? text;
  final TextEditingController? controller;
  final Function(String?)? validator;
  const AuthPasswordField(
      {Key? key, required this.text, this.controller, this.validator})
      : super(key: key);

  @override
  _AuthPasswordFieldState createState() => _AuthPasswordFieldState();
}

class _AuthPasswordFieldState extends State<AuthPasswordField>
    with SingleTickerProviderStateMixin {
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: whiteColorShade1,
      ),
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: visible,
        controller: widget.controller,
        validator: (value) {
          widget.validator!(value);
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15.0.h),
          label: Text(widget.text!),
          labelStyle: CustomTheme.normalText(context)
              .copyWith(fontWeight: FontWeight.w400),
          prefixIcon: const Icon(Icons.lock, color: Color(0xff777777)),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                visible = !visible;
              });
            },
            icon: AnimatedSize(
                duration: const Duration(milliseconds: 400),
                child: visible
                    ? const Icon(Icons.visibility, color: Color(0xff777777))
                    : const Icon(
                        Icons.visibility_off,
                        color: Color(0xff777777),
                      )),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
