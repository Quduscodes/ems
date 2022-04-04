import 'package:ems/exports.dart';

class CustomBorderButton extends StatelessWidget {
  final Color? color;
  final Color? borderColor;
  final List<Widget> children;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  const CustomBorderButton(
      {Key? key,
      required this.color,
      required this.borderColor,
      required this.children,
      this.padding,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: color,
        border: Border.all(
          color: borderColor!,
          width: 1,
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: onPressed,
          child: Padding(
            padding: padding ?? const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}
