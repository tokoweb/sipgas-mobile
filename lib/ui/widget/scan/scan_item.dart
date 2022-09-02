part of '../widgets.dart';

class ScanItem extends StatelessWidget {
  final TubeDao? data;
  final Function() actionDelete;
  final String? scanType;
  const ScanItem(
      {Key? key, required this.actionDelete, this.data, this.scanType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.only(bottom: 20),
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
            data != null && data!.id != "" ? data!.serialNumber : "",
            style: blackFontStyle.copyWith(fontSize: 14, fontWeight: bold),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: GestureDetector(
                  onTap: actionDelete,
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: kPinkDarkColor),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Center(
                        child: Text(
                          'Hapus',
                          style: blackFontStyle.copyWith(
                              fontSize: 14, fontWeight: regular),
                        ),
                      )),
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: GestureDetector(
                  onTap: () => nextScreen(
                      context,
                      EditTubePage(
                        dataDao: data != null ? data! : null,
                        scanType: scanType != null ? scanType! : "",
                      )),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: kPinkDarkColor,
                    ),
                    child: Center(
                      child: Text(
                        'Detail Tabung',
                        style: whiteFontStyle.copyWith(
                            fontSize: 14, fontWeight: regular),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
