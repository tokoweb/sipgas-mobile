part of '../widgets.dart';

void filterTubeAction(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: kTransparantColor,
    builder: (ctx) {
      return Container(
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        height: 260,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  Container(width: 20),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Filter",
                        style: blackFontStyle.copyWith(
                            fontSize: 15, fontWeight: bold),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, size: 20),
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Kategori tabung',
                      style: blackFontStyle.copyWith(
                          fontSize: 14, fontWeight: regular),
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: GestureDetector(
                          onTap: () {
                            print('tap tap');
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: kPrimaryColor,
                            ),
                            child: Center(
                              child: Text(
                                'Oksigen 6 M3',
                                style: whiteFontStyle.copyWith(
                                    fontSize: 14, fontWeight: regular),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: kPinkDarkColor),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Center(
                              child: Text(
                                'Oksigen 2 M3',
                                style: blackFontStyle.copyWith(
                                    fontSize: 14, fontWeight: regular),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: kPinkDarkColor),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Center(
                              child: Text(
                                'Oksigen 1 M3',
                                style: blackFontStyle.copyWith(
                                    fontSize: 14, fontWeight: regular),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: kPinkDarkColor),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Center(
                              child: Text(
                                'N2o',
                                style: blackFontStyle.copyWith(
                                    fontSize: 14, fontWeight: regular),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30, bottom: 10),
                    child: Text(
                      'Status tabung',
                      style: blackFontStyle.copyWith(
                          fontSize: 14, fontWeight: regular),
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: GestureDetector(
                          onTap: () {
                            print('tap tap');
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: kPrimaryColor,
                            ),
                            child: Center(
                              child: Text(
                                'Kosong',
                                style: whiteFontStyle.copyWith(
                                    fontSize: 14, fontWeight: regular),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: kPinkDarkColor),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Center(
                              child: Text(
                                'Terisi',
                                style: blackFontStyle.copyWith(
                                    fontSize: 14, fontWeight: regular),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: kPinkDarkColor),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Center(
                              child: Text(
                                'Rusak',
                                style: blackFontStyle.copyWith(
                                    fontSize: 14, fontWeight: regular),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}


