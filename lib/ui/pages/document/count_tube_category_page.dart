part of '../pages.dart';

class CountTubePageCategoryPage extends StatefulWidget {
  final TravelDocDetailResponse? tubeDetail;
  const CountTubePageCategoryPage({Key? key, this.tubeDetail})
      : super(key: key);

  @override
  _CountTubePageCategoryPageState createState() =>
      _CountTubePageCategoryPageState();
}

class _CountTubePageCategoryPageState extends State<CountTubePageCategoryPage> {
  @override
  Widget build(BuildContext context) {
    Widget countTube() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              'Jumlah Tabung',
              style: greyFontStyle.copyWith(fontSize: 12, fontWeight: regular),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
                border: Border.all(color: kPinkYoungColor),
                borderRadius: BorderRadius.circular(4.0)),
            child: Center(
              child: Text(
                widget.tubeDetail != null &&
                        widget.tubeDetail!.tanksCount != null
                    ? widget.tubeDetail!.tanksCount!.toString()
                    : "",
                style: blackFontStyle.copyWith(fontSize: 24, fontWeight: bold),
              ),
            ),
          ),
          SizedBox(height: 20)
        ],
      );
    }

    Widget dataCategory(TankCategoriesData data, TravelDocState state) {
      List<TubeDao>? listTubeByCategory = state.tubeDaoTravel.length > 0
          ? state.tubeDaoTravel
              .where(
                (element) => element.tankCategoryId == data.tankCategoryId,
              )
              .toList()
          : [];

      return Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0), color: kPinkYoungColor),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Text('${data.name} (${data.qty})',
                style:
                    blackFontStyle.copyWith(fontSize: 14, fontWeight: regular)),
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: kWhiteColor,
                  border: Border.all(color: kPinkYoungColor),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => nextScreen(
                        context,
                        ScanTubeInTravelDocPage(
                          tankCategoryId: data.tankCategoryId.toString(),
                          countTanks: data.qty.toString(),
                        ),
                      ),
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(16),
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                        decoration: BoxDecoration(
                          color: kYellowColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Container(width: 20),
                            Expanded(
                              child: Center(
                                child: Text(
                                  'Scan Tabung',
                                  style: blackFontStyle.copyWith(
                                      fontSize: 14, fontWeight: bold),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Color(0xffffee95),
                              ),
                              child: SvgPicture.asset(
                                'assets/icon/ic_scan.svg',
                                width: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 4,
                      color: Color(0xffEBEBEB),
                    ),
                    IntrinsicHeight(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: kPinkYoungColor,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              padding: EdgeInsets.symmetric(vertical: 14),
                              child: Text(
                                'No',
                                style: blackFontStyle.copyWith(
                                    fontSize: 14, fontWeight: bold),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: VerticalDivider(
                                color: kPinkYoungColor,
                                thickness: 1,
                              ),
                            ),
                            Text(
                              'List Tabung',
                              style: blackFontStyle.copyWith(
                                  fontSize: 14, fontWeight: bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: data.qty,
                          itemBuilder: (context, index) {
                            return IntrinsicHeight(
                              child: Container(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 20,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Text(
                                        "${index + 1}",
                                        style: blackFontStyle.copyWith(
                                            fontSize: 14, fontWeight: bold),
                                      ),
                                    ),
                                    VerticalDivider(
                                      color: kPinkYoungColor,
                                      thickness: 1,
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Container(
                                        height: 40,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 6),
                                        decoration: BoxDecoration(
                                          color: kScaffoldColor,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 14),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        listTubeByCategory.length > 0
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: listTubeByCategory.length,
                                itemBuilder: (context, index) {
                                  return IntrinsicHeight(
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 20,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 20),
                                          ),
                                          VerticalDivider(
                                            color: kPinkYoungColor,
                                            thickness: 1,
                                          ),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: Container(
                                              height: 40,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 6),
                                              decoration: BoxDecoration(
                                                color: kPinkYoungColor,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    listTubeByCategory[index]
                                                        .serialNumber,
                                                    style:
                                                        blackFontStyle.copyWith(
                                                            fontSize: 14,
                                                            fontWeight: bold),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      context
                                                          .read<TravelDocBloc>()
                                                          .add(DeleteListScanByIdTubeTravelDoc(
                                                              id: listTubeByCategory[
                                                                      index]
                                                                  .id
                                                                  .toString()));
                                                    },
                                                    child: Icon(Icons.close),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 14),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : SizedBox(),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget listCategoryTube(TravelDocState state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              'Rincian Kategori Tabung',
              style: greyFontStyle.copyWith(fontSize: 12, fontWeight: regular),
            ),
          ),
          widget.tubeDetail != null &&
                  widget.tubeDetail!.tankCategoriesData != null
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: widget.tubeDetail!.tankCategoriesData!.length,
                  itemBuilder: (context, index) {
                    return dataCategory(
                        widget.tubeDetail!.tankCategoriesData![index], state);
                  },
                )
              : SizedBox(),
        ],
      );
    }

    return BlocConsumer<TravelDocBloc, TravelDocState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var listTubeDao = state.tubeDaoTravel.length;
        var qtyTube = state.travelDocDetail.tanksCount;
        SharedPref pref = inject<SharedPref>();

        return Scaffold(
          appBar: CustomAppbarDetail(title: 'Jumlah Tabung'),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                countTube(),
                listCategoryTube(state),
              ],
            ),
          ),
          bottomNavigationBar: Container(
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: ButtonPrimary(
                isLoading:
                    state.status == TravelDocStatus.update_travel_doc_loading,
                color: kYellowColor,
                title: "Simpan",
                onTap: () async {
                  if (listTubeDao == qtyTube) {
                    pref.setTubeScanTravel(1);
                    successAlertDialog(
                        context, "Data Tabung Berhasil Disimpan");

                    Future.delayed(Duration(seconds: 1), () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    });
                  } else {
                    pref.setTubeScanTravel(0);
                    errorAlertDialog(
                        context, "Jumlah tabung yang anda scan masih kurang.");
                  }
                },
              )),
        );
      },
    );
  }
}
