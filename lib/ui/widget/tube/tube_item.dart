part of '../widgets.dart';

class TubeItem extends StatelessWidget {
  final SubTubeResponse? tubeData;
  final Function()? onTap;
  const TubeItem({Key? key, this.tubeData, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(14),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.10),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'No. Tabung',
              style: greyFontStyle.copyWith(fontSize: 12, fontWeight: regular),
            ),
            SizedBox(height: 4),
            Text(
              tubeData != null && tubeData!.serialNumber != null
                  ? tubeData!.serialNumber!
                  : "",
              style: blackFontStyle.copyWith(fontSize: 14, fontWeight: bold),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: kYellowColor,
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Text(
                    tubeData != null && tubeData!.categoryName != null
                        ? tubeData!.categoryName!
                        : "",
                    style: yellowDarkFontStyle.copyWith(
                      fontSize: 12,
                      fontWeight: regular,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: kPinkYoungColor,
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Text(
                    tubeData != null && tubeData!.status != null
                        ? tubeData!.status!
                        : "",
                    style: rosyFontStyle.copyWith(
                      fontSize: 12,
                      fontWeight: regular,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
