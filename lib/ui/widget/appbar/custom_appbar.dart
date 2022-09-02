part of '../widgets.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final String? icon1;
  final String? icon2;
  final Widget? iconWidget;
  const CustomAppBar(
      {Key? key, required this.title, this.icon1, this.icon2, this.iconWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      automaticallyImplyLeading: false,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: Container(
          padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
          child: Row(
            children: [
              Container(
                height: 40,
                margin: EdgeInsets.only(right: 10),
                child: SizedBox(),
              ),
              // Container(
              //   width: 40,
              //   height: 40,
              //   margin: EdgeInsets.only(right: 10),
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       image: AssetImage("assets/icon/ic_logo_white.png"),
              //     ),
              //   ),
              // ),
              iconWidget != null
                  ? Expanded(
                      child: Text(
                      title!,
                      style: whiteFontStyle.copyWith(
                          fontWeight: bold, fontSize: 22),
                    ))
                  : Text(
                      title!,
                      style: whiteFontStyle.copyWith(
                          fontWeight: bold, fontSize: 22),
                    ),
              iconWidget != null ? iconWidget! : SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70);
}
