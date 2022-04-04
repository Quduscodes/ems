import 'package:ems/exports.dart';

class SecondarySecondaryBkButton extends StatelessWidget {
  const SecondarySecondaryBkButton({
    Key? key,
    this.fillColor,
    this.borderColor = greyColor,
    this.onTap,
    this.iconColor = const Color(0xff777777),
  }) : super(key: key);
  final Color borderColor;
  final Color iconColor;
  final Color? fillColor;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 60.w,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 0.5,
          color: borderColor,
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              onTap != null ? onTap!() : Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: iconColor,
            )),
      ),
    );
  }
}

class BKButton extends StatelessWidget {
  const BKButton({
    Key? key,
    this.fillColor,
    this.borderColor = greyColor,
    this.onTap,
    this.iconColor = const Color(0xff777777),
  }) : super(key: key);
  final Color borderColor;
  final Color iconColor;
  final Color? fillColor;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 60.w,
      decoration: BoxDecoration(
        color: transColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 0.5,
          color: borderColor,
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              onTap != null ? onTap!() : Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: iconColor,
            )),
      ),
    );
  }
}
