part of '../widgets.dart';

class CustomAppbarIcon extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool iconFilter;
  final bool iconSearch;
  final Function() filterFunction;
  final Function() searchFunction;

  const CustomAppbarIcon(
      {Key? key,
      required this.title,
      required this.iconFilter,
      required this.iconSearch,
      required this.filterFunction,
      required this.searchFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kWhiteColor,
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      shape: Border(bottom: BorderSide(color: kPinkYoungColor, width: 2)),
      elevation: 0.0,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: Container(
          margin: EdgeInsets.only(bottom: 5, left: 20, right: 20),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back, size: 22),
              ),
              Container(width: 35),
              Expanded(
                child: Center(
                  child: Text(
                    title,
                    style:
                        blackFontStyle.copyWith(fontSize: 18, fontWeight: bold),
                  ),
                ),
              ),
              (iconFilter == true)
                  ? GestureDetector(
                      onTap: filterFunction,
                      child: Container(
                        margin: EdgeInsets.only(right: 15),
                        width: 20,
                        child: SvgPicture.asset('assets/icon/ic_filter.svg'),
                      ),
                    )
                  : SizedBox(width: 20),
              (iconSearch == true)
                  ? GestureDetector(
                      onTap: searchFunction,
                      child: Container(
                        width: 20,
                        child: SvgPicture.asset('assets/icon/ic_search.svg'),
                      ),
                    )
                  : SizedBox(width: 20)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70);
}
