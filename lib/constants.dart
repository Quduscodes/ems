import 'package:ems/exports.dart';

showSnackBar(BuildContext context, {text, bool error = false}) {
  return SnackBar(
    duration: const Duration(seconds: 4),
    content: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: error
              ? Colors.red.withOpacity(0.9)
              : const Color(0xFF4BB543).withOpacity(0.9)),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 7.w),
      child: Row(
        children: [
          SizedBox(width: 5.w),
          Icon(
            error ? Icons.error : Icons.check_circle,
            color: error ? Colors.white : Colors.white,
          ),
          // Container(
          //   width: 2.w,
          //   height: 1.h,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
          //     color: error ? Colors.red : Colors.green,
          //   ),
          // ),
          SizedBox(width: 10.w),
          Expanded(
              child: Text(
            text,
            maxLines: 2,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: CustomTheme.smallText(context).copyWith(color: whiteColor),
          )),
        ],
      ),
    ),
  );
}

void dropKeyboard(context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}
