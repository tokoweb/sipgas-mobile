part of '../widgets.dart';

class CustomButtonScan extends StatelessWidget {
  final String? title;
  final Function()? function;
  final String? icon;

  const CustomButtonScan(
      {Key? key, required this.title, required this.function, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.only(left: 20, top: 6, bottom: 6, right: 6),
        decoration: BoxDecoration(
            color: kYellowColor, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                title!,
                style: blackFontStyle.copyWith(fontSize: 14, fontWeight: bold),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Color(0xffffee95),
              ),
              child: SvgPicture.asset(
                icon!,
                width: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
