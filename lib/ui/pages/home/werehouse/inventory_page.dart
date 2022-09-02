part of '../../pages.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  SharedPref pref = inject<SharedPref>();

  @override
  Widget build(BuildContext context) {
    Widget body() {
      return SingleChildScrollView(
        padding: EdgeInsets.only(top: 20),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              InventoryItem(
                title: 'Scan Tabung Masuk',
                image: 'assets/images/tube_inlet.png',
                function: () => incomingTubeScan(context),
              ),
              InventoryItem(
                title: 'Scan Tabung Keluar',
                image: 'assets/images/tube_out.png',
                function: () => scanTubeOut(context),
              ),
              InventoryItem(
                title: 'Stok Tabung',
                image: 'assets/images/tube_stock.png',
                function: () {
                  context.read<TubeBloc>()..add(DeleteAllTubeEvent());
                  context.read<TubeBloc>()..add(GetListTubeScanEvent());
                  context.read<StockTubeTypeCubit>().setType(0);
                  pref.setStockTubeStatus(0);
                  nextScreen(context, StockTubePage());
                },
              ),
              InventoryItem(
                title: 'Load Tabung',
                image: 'assets/images/tube_load.png',
                function: () => nextScreen(context, LoadTubePage()),
              ),
            ],
          ),
        ),
      );
    }

    return BlocConsumer<TubeBloc, TubeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return BlocConsumer<NotifBloc, NotifState>(
          listener: (context, notifState) {
            // TODO: implement listener
          },
          builder: (context, notifState) {
            return Scaffold(
              appBar: CustomAppBar(
                title: "Inventaris",
                iconWidget: GestureDetector(
                  onTap: () {
                    context.read<NotifBloc>()..add(FetchNotifEvent());
                    context.read<NotifBloc>()
                      ..add(PostReadAllNotificationEvent());
                    context.read<NotifBloc>()..add(FetchSummaryNotifEvent());
                    nextScreen(context, NotificationPage());
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(Icons.notifications_outlined,
                          color: kWhiteColor, size: 32),
                      notifState.summaryNotif.unread != null &&
                              notifState.summaryNotif.unread != 0
                          ? Positioned(
                              top: 2,
                              right: 0,
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 1),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kWhiteColor),
                                  alignment: Alignment.center,
                                  child: Text(
                                      notifState.summaryNotif.unread!
                                          .toString(),
                                      style: primaFontStyle.copyWith(
                                          fontSize: 12, fontWeight: medium))),
                            )
                          : SizedBox()
                    ],
                  ),
                ),
              ),
              body: body(),
            );
          },
        );
      },
    );
  }
}
