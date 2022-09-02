part of '../widgets.dart';

class NotifItem extends StatelessWidget {
  final SubNotificationResponse? data;
  const NotifItem({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
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
        children: [
          Icon(Icons.notifications_active, color: kPrimaryColor),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Kontrak Peminjaman Tabung Telah Berakhir",
                    style: blackFontStyle.copyWith(
                        fontSize: 14, fontWeight: medium)),
                SizedBox(height: 6),
                Text(
                  "Pelanggan: ${data != null && data!.data!.data!.customerData!.name != null ? data!.data!.data!.customerData!.name! : ''}",
                  style:
                      greyFontStyle.copyWith(fontSize: 14, fontWeight: regular),
                ),
                SizedBox(height: 6),
                Text(
                  "Tanggal Berakhir: ${data != null && data!.data!.data!.to != null ? data!.data!.data!.to! : ''}",
                  style:
                      greyFontStyle.copyWith(fontSize: 14, fontWeight: regular),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
