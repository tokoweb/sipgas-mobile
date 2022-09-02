part of '../widgets.dart';

class CustomAppbarDetail extends StatelessWidget with PreferredSizeWidget {
  final String title;

  const CustomAppbarDetail({Key? key, required this.title}) : super(key: key);

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
          margin: EdgeInsets.only(bottom: 15, left: 20, right: 20),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back, size: 22),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    title,
                    style:
                        blackFontStyle.copyWith(fontSize: 18, fontWeight: bold),
                  ),
                ),
              ),
              Container(width: 20)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70);
}
