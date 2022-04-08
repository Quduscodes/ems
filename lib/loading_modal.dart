import 'package:ems/exports.dart';

class LoadingModal extends StatelessWidget {
  // final Widget? child;
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  // final Animation<Color>? valueColor;
  // final String message;

  const LoadingModal({
    required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = Colors.grey,
  });
  // this.child,

  // required this.message,
  // this.opacity = 0.3,
  // this.color = Colors.grey,
  // this.valueColor,

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = <Widget>[];
    // if (child != null) {
    //   widgetList.add(child!);
    // }
    if (inAsyncCall) {
      final modal = Stack(
        children: [
          Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: false, color: color),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 25.w),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            ),
          ),
        ],
      );
      widgetList.add(modal);
    }
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ),
        child: Stack(
          children: widgetList,
        ));
  }
}
