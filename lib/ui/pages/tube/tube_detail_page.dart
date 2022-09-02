part of '../pages.dart';

class TubeDetailPage extends StatefulWidget {
  const TubeDetailPage({Key? key}) : super(key: key);

  @override
  _TubeDetailPageState createState() => _TubeDetailPageState();
}

class _TubeDetailPageState extends State<TubeDetailPage> {
  SharedPref pref = inject<SharedPref>();
  var roleUser;

  getRoleUser() async {
    String? roleUserShared = await pref.getRoleUser();

    setState(() {
      roleUser = roleUserShared;
    });
  }

  @override
  void initState() {
    super.initState();
    getRoleUser();
  }

  @override
  Widget build(BuildContext context) {
    print("role user $roleUser");
    Widget tubeNumber(String serialNumber) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              'No. Tabung',
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
                '$serialNumber',
                style: blackFontStyle.copyWith(fontSize: 24, fontWeight: bold),
              ),
            ),
          ),
          SizedBox(height: 20)
        ],
      );
    }

    Widget dataTube(TubeState state) {
      final locationTextController = TextEditingController(
          text: state.tubeDetail.location != null
              ? state.tubeDetail.location!
              : "");
      final categoryTextController = TextEditingController(
          text: state.tubeDetail.categoryName != null
              ? state.tubeDetail.categoryName!
              : "");

      final statusTextController = TextEditingController(
          text:
              state.tubeDetail.status != null ? state.tubeDetail.status! : "");

      return Column(
        children: [
          tubeNumber(state.tubeDetail.serialNumber != null
              ? state.tubeDetail.serialNumber!
              : ""),
          CustomTextFieldBorder(
            title: 'Lokasi Tabung',
            hintText: "",
            isReadonly: true,
            controller: locationTextController,
          ),
          CustomTextFieldBorder(
              title: 'Kategori Tabung',
              hintText: '',
              isReadonly: true,
              controller: categoryTextController),
          CustomTextFieldBorder(
            title: 'Status Tabung',
            hintText: '',
            isReadonly: true,
            controller: statusTextController,
          ),
          CustomTextArea(
            title: 'Informasi Tambahan',
            description:
                state.tubeDetail.note != null ? state.tubeDetail.note! : "",
          )
        ],
      );
    }

    return BlocConsumer<TubeBloc, TubeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppbarDetailTube(
            title: 'Detail Tabung',
            enableIcon: state.tubeDetail.location == "Gudang" ||
                    roleUser == "refill staff"
                ? true
                : false,
            onTapIcon: () {
              context.read<TubeBloc>()..add(DeleteAllTubeEvent());
              context.read<TubeBloc>()..add(GetListTubeScanEvent());
              nextScreen(
                  context,
                  ScanStockTubePage(
                    serialNumber: state.tubeDetail.serialNumber != null
                        ? state.tubeDetail.serialNumber!
                        : "",
                  ));
            },
          ),
          body: state.status == TubeStatus.loading
              ? Center(child: CircularProgressIndicator(color: kPrimaryColor))
              : SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      dataTube(state),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
