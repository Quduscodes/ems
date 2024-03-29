import 'package:ems/exports.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final onChanged;
  final String? value;
  final String title;
  const CustomDropdown(
      {Key? key,
      required this.items,
      required this.title,
      this.onChanged,
      this.value})
      : super(key: key);
  static bool smallScreen = false;

  @override
  Widget build(BuildContext context) {
    if (100.h < 900) {
      smallScreen = true;
    }
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: CustomTheme.normalText(context)
                .copyWith(color: swatch12, fontWeight: FontWeight.w400),
          ),
          DropdownButton<String>(
            selectedItemBuilder: (_) {
              return items.map<Widget>((String item) {
                return Center(
                  child: Text(
                    item,
                    textAlign: TextAlign.start,
                    style: CustomTheme.normalText(context).copyWith(
                        color: whiteColor, fontWeight: FontWeight.w400),
                  ),
                );
              }).toList();
            },
            underline: Divider(
              thickness: 2.sp,
              color: greyTextColor,
              height: 0.3.h,
            ),
            elevation: 0,
            isExpanded: true,
            items: items.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem.toString()));
            }).toList(),
            style: TextStyle(
                color: darkGreyColor,
                fontWeight: FontWeight.w400,
                fontSize: 15.sp),
            onChanged: onChanged,
            value: value,
          ),
        ],
      ),
    );
  }
}
