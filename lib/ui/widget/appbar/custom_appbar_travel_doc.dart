part of '../widgets.dart';

class CustomAppbarTravel extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final Function() filterFunction;
  final Function() searchFunction;
  const CustomAppbarTravel(
      {Key? key,
      required this.title,
      required this.filterFunction,
      required this.searchFunction})
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
          padding: EdgeInsets.only(bottom: 5, left: 20, right: 20),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/icon/ic_logo_white.png"),
                  ),
                ),
              ),
              Text(
                title!,
                style: whiteFontStyle.copyWith(fontWeight: bold, fontSize: 22),
              ),
              Spacer(),
              GestureDetector(
                onTap: filterFunction,
                child: Container(
                  margin: EdgeInsets.only(right: 15),
                  width: 20,
                  child: SvgPicture.asset(
                    'assets/icon/ic_filter.svg',
                    color: kWhiteColor,
                  ),
                ),
              ),
              GestureDetector(
                onTap: searchFunction,
                child: Container(
                  width: 20,
                  child: SvgPicture.asset(
                    'assets/icon/ic_search.svg',
                    color: kWhiteColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70);
}
