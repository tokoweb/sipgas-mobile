part of '../widgets.dart';

class StockTubeItem extends StatelessWidget {
  final SubTubeResponse? tubeData;
  final Function()? onTap;

  const StockTubeItem({Key? key, this.tubeData, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(14),
        margin: EdgeInsets.only(bottom: 10, right: 20, left: 20),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'No. Tabung',
                        style: greyFontStyle.copyWith(
                            fontSize: 12, fontWeight: regular),
                      ),
                      SizedBox(height: 4),
                      Text(
                        tubeData!.serialNumber!.toString(),
                        style: blackFontStyle.copyWith(
                            fontSize: 14, fontWeight: bold),
                      ),
                    ],
                  ),
                ),
                (tubeData!.location == "Gudang")
                    ? GestureDetector(
                        onTap: () {
                          context.read<TubeBloc>()..add(DeleteAllTubeEvent());
                          context.read<TubeBloc>()..add(GetListTubeScanEvent());
                          nextScreen(
                              context,
                              ScanStockTubePage(
                                serialNumber: tubeData != null &&
                                        tubeData!.serialNumber != null
                                    ? tubeData!.serialNumber
                                    : "",
                              ));
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: kGreyNavColor,
                          ),
                          child: SvgPicture.asset(
                            'assets/icon/ic_scan.svg',
                            width: 20,
                            color: kBlackColor,
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
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
                    tubeData!.categoryName!,
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
                    tubeData!.status!,
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
