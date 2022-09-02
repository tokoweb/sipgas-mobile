part of '../widgets.dart';

class TravelDocItem extends StatelessWidget {
  final SubTravelDocResponse? data;
  final Function()? function;
  const TravelDocItem({Key? key, this.data, this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var jiffy2 = Jiffy(data!.updatedAt!).fromNow();

    Widget tankCategories(String name) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: kYellowColor,
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Center(
          child: Text(
            name,
            style: yellowDarkFontStyle.copyWith(
              fontSize: 12,
              fontWeight: regular,
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: function,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Text(
                    'No. Surat Jalan Sementara',
                    style: greyFontStyle.copyWith(
                        fontSize: 12, fontWeight: regular),
                  ),
                ),
                Text(
                  jiffy2,
                  style:
                      greyFontStyle.copyWith(fontSize: 12, fontWeight: regular),
                ),
              ],
            ),
            SizedBox(height: 4),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Text(
                data!.code != null ? data!.code! : "",
                style: blackFontStyle.copyWith(fontSize: 14, fontWeight: bold),
              ),
            ),
            Container(
              child: Text(
                data!.customerData!.name != null
                    ? data!.customerData!.name!
                    : "",
                style: blackFontStyle.copyWith(fontSize: 14, fontWeight: bold),
              ),
            ),
            SizedBox(height: 5),
            rowItem("assets/icon/ic_tube_rounded.svg",
                "${data!.tanksCount != null ? data!.tanksCount! : ''}"),
            rowItem("assets/icon/ic_date_rounded.svg",
                "${data!.date != null ? data!.date! : ''}"),
            SizedBox(height: 10),

            Container(
              height: 30,
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: data!.tankCategoriesData != null
                    ? data!.tankCategoriesData!.length
                    : 0,
                itemBuilder: (context, index) {
                  return tankCategories(data!.tankCategoriesData![index].name!);
                },
              ),
            ),

            // Row(
            //   children: [
            //     SizedBox(
            //       width: 10,
            //     ),
            //     Container(
            //       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            //       decoration: BoxDecoration(
            //         color: kYellowColor,
            //         borderRadius: BorderRadius.circular(14.0),
            //       ),
            //       child: Text(
            //         'N2o',
            //         style: yellowDarkFontStyle.copyWith(
            //           fontSize: 12,
            //           fontWeight: regular,
            //         ),
            //       ),
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  Widget rowItem(String icon, String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            margin: EdgeInsets.only(right: 5),
            child: SvgPicture.asset(icon),
          ),
          Text(
            title,
            style: blackFontStyle.copyWith(fontSize: 14, fontWeight: regular),
          ),
        ],
      ),
    );
  }
}
