part of '../widgets.dart';

class ProfileItem extends StatelessWidget {
  final String? icon;
  final String? title;
  final Function()? function;
  const ProfileItem({Key? key, this.icon, this.title, this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: SvgPicture.asset(
                icon!,
                width: 20,
                color: kPinkDarkColor,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 9,
              child: Text(
                title!,
                style:
                    blackFontStyle.copyWith(fontSize: 16, fontWeight: regular),
              ),
            )
          ],
        ),
      ),
    );
  }
}
