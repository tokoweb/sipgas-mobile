part of '../../pages.dart';

class InventoryFillingStaff extends StatefulWidget {
  const InventoryFillingStaff({Key? key}) : super(key: key);

  @override
  _InventoryFillingStaffState createState() => _InventoryFillingStaffState();
}

class _InventoryFillingStaffState extends State<InventoryFillingStaff> {
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
                title: 'Scan Tabung Terisi',
                image: 'assets/images/tube_inlet.png',
                function: () {
                  context.read<TubeBloc>()..add(DeleteAllTubeEvent());
                  nextScreen(
                      context, ScanTubePage(scanType: "pengisian_terisi"));
                },
              ),
              InventoryItem(
                title: 'Stok Tabung',
                image: 'assets/images/tube_stock.png',
                function: () {
                  context.read<TubeBloc>()..add(DeleteAllTubeEvent());
                  context.read<TubeBloc>()..add(GetListTubeScanEvent());
                  pref.setStockTubeFillingStafStatus(0);
                  context.read<StockTubeTypeFillingStafCubit>().setType(0);
                  nextScreen(context, StockTubeFillingPage());
                },
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: "Inventaris",
      ),
      body: body(),
    );
  }
}
