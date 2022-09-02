part of '../widgets.dart';

void incomingTubeScan(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: kTransparantColor,
    builder: (ctx) {
      return IntrinsicHeight(
        child: Container(
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Scan Tabung Masuk",
                          style: blackFontStyle.copyWith(
                              fontSize: 14, fontWeight: bold),
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
              CustomButtonScan(
                title: 'Scan Tabung Kosong',
                icon: 'assets/icon/ic_scan.svg',
                function: () {
                  Navigator.pop(context);
                  context.read<TubeBloc>()..add(DeleteAllTubeEvent());
                  context.read<TubeBloc>()..add(GetListTubeScanEvent());
                  nextScreen(context, ScanTubePage(scanType: "Kosong"));
                },
              ),
              CustomButtonScan(
                title: 'Scan Tabung Terisi',
                icon: 'assets/icon/ic_scan.svg',
                function: () {
                  Navigator.pop(context);
                  context.read<TubeBloc>()..add(DeleteAllTubeEvent());
                  context.read<TubeBloc>()..add(GetListTubeScanEvent());
                  nextScreen(context, ScanTubePage(scanType: "Terisi"));
                },
              ),
              CustomButtonScan(
                title: 'Scan Tabung Retur',
                icon: 'assets/icon/ic_scan.svg',
                function: () {
                  Navigator.pop(context);
                  context.read<TubeBloc>()..add(DeleteAllTubeEvent());
                  context.read<TubeBloc>()..add(GetListTubeScanEvent());
                  nextScreen(context, ScanTubePage(scanType: "Terisi"));
                },
              ),
              CustomButtonScan(
                title: 'Scan Tabung Maintenance/Rusak',
                icon: 'assets/icon/ic_scan.svg',
                function: () {
                  Navigator.pop(context);
                  context.read<TubeBloc>()..add(DeleteAllTubeEvent());
                  context.read<TubeBloc>()..add(GetListTubeScanEvent());
                  nextScreen(context, ScanTubePage(scanType: "Maintenance"));
                },
              )
            ],
          ),
        ),
      );
    },
  );
}

void scanTubeOut(BuildContext context) {
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
        height: 120,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  Container(
                    width: 20,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Scan Tabung Keluar",
                        style: blackFontStyle.copyWith(
                            fontSize: 14, fontWeight: bold),
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
            CustomButtonScan(
              title: 'Scan Tabung Pengisian',
              icon: 'assets/icon/ic_scan.svg',
              function: () {
                Navigator.pop(context);
                context.read<TubeBloc>()..add(DeleteAllTubeEvent());
                context.read<TubeBloc>()..add(GetListTubeScanEvent());
                nextScreen(context, ScanTubePage(scanType: "out"));
              },
            ),
          ],
        ),
      );
    },
  );
}

void addNote(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              padding: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                color: kGreyNavColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                  suffix: SvgPicture.asset(
                    "assets/icon/ic_send.svg",
                    width: 20,
                    height: 20,
                    color: kBlackColor,
                  ),
                ),
                autofocus: true,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
