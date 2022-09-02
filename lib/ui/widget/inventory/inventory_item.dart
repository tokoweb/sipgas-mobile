part of '../widgets.dart';

class InventoryItem extends StatelessWidget {
  final String title;
  final String image;
  final Function()? function;
  const InventoryItem(
      {Key? key, required this.title, required this.image, this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        width: double.infinity,
        height: 80,
        padding: EdgeInsets.only(left: 20, right: 10),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: kWhiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: blackFontStyle.copyWith(fontSize: 16, fontWeight: bold),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.cover),
              ),
            )
          ],
        ),
      ),
    );
  }
}
