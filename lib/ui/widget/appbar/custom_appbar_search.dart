part of '../widgets.dart';

class CustomAppbarSearch extends StatelessWidget with PreferredSizeWidget {
  final Widget? widgetSearch;
  const CustomAppbarSearch({Key? key, this.widgetSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kWhiteColor,
      automaticallyImplyLeading: false,
      shape: Border(bottom: BorderSide(color: kPinkYoungColor, width: 2)),
      elevation: 0.0,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: Container(
          margin: EdgeInsets.only(bottom: 15, left: 20, right: 20),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back, size: 22),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 40,
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: kScaffoldColor),
                  child: widgetSearch != null ? widgetSearch : SizedBox(),
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
