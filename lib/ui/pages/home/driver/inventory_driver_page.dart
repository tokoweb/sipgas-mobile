part of '../../pages.dart';

class InventoryDriverPage extends StatefulWidget {
  const InventoryDriverPage({Key? key}) : super(key: key);

  @override
  _InventoryDriverPageState createState() => _InventoryDriverPageState();
}

class _InventoryDriverPageState extends State<InventoryDriverPage> {
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
                title: 'Scan Pengambilan Tabung',
                image: 'assets/images/tube_out.png',
                function: () {
                  context.read<TubeBloc>()..add(DeleteAllTubeEvent());
                  context.read<TubeBloc>()..add(GetListTubeScanEvent());
                  nextScreen(
                      context,
                      ScanTubePage(
                        scanType: "taking_driver",
                      ));
                },
              ),
              InventoryItem(
                title: 'Load Tabung',
                image: 'assets/images/tube_load.png',
                function: () {
                  pref.setLoadTubeDriverStatus(0);
                  context.read<LoadTubeTypeDriverCubit>().setType(0);
                  nextScreen(context, LoadTubeDriverPage());
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
