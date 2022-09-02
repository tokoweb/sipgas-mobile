part of '../widgets.dart';

successAlertDialog(BuildContext context, String title) {
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    content: Container(
      width: double.infinity,
      height: 200,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.close, size: 22),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 30),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/success_alert.png',
                ),
              ),
            ),
          ),
          Container(
            child: Text(
              title,
              style: blackFontStyle.copyWith(fontSize: 14, fontWeight: regular),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    ),
    actions: [],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

errorAlertDialog(BuildContext context, String title) {
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    content: Container(
      width: double.infinity,
      height: 200,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.close, size: 22),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 30),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/error_alert.png',
                ),
              ),
            ),
          ),
          Container(
            child: Text(
              title,
              style: blackFontStyle.copyWith(fontSize: 14, fontWeight: regular),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    ),
    actions: [],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

questionAlertDialog(
    BuildContext context, String title, String subtitle, Function() yesAction) {
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    content: Container(
      width: double.infinity,
      height: 110,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              title,
              style: blackFontStyle.copyWith(fontSize: 18, fontWeight: bold),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Text(
              subtitle,
              style: blackFontStyle.copyWith(fontSize: 14, fontWeight: regular),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: kYellowColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Tidak',
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
                  onTap: yesAction,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: kYellowColor),
                    ),
                    child: Center(
                      child: Text(
                        'Ya',
                        style: blackFontStyle.copyWith(
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
    ),
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
