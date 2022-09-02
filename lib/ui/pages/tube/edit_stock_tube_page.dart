part of '../pages.dart';

class EditStockTubePage extends StatefulWidget {
  final TubeDao? dataDao;
  const EditStockTubePage({Key? key, this.dataDao}) : super(key: key);

  @override
  _EditStockTubePageState createState() => _EditStockTubePageState();
}

class _EditStockTubePageState extends State<EditStockTubePage> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  SharedPref pref = inject<SharedPref>();

  var resultStatus;
  var tankCategoriesId;
  var categoryName;
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
    resultStatus = widget.dataDao!.status;
    tankCategoriesId = widget.dataDao!.tankCategoryId;
    categoryName = widget.dataDao!.categoryName;
    getRoleUser();
  }

  @override
  Widget build(BuildContext context) {
    _locationController.text =
        widget.dataDao != null ? widget.dataDao!.location : "";
    print("Kevin role user $roleUser");

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

    Widget dropdownTubeCategories(TubeState state) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                "Kategori Tabung",
                style:
                    greyFontStyle.copyWith(fontSize: 12, fontWeight: regular),
              ),
            ),
            state.dropdownTube.tankCategories != null
                ? Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: kPinkYoungColor),
                    child: DropdownSearch<DropdownData>(
                      mode: Mode.MENU,
                      dropdownSearchDecoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: InputBorder.none,
                      ),
                      items: state.dropdownTube.tankCategories
                          ?.where((element) => element.label != categoryName)
                          .toList(),
                      itemAsString: (d) => d!.label != null ? d.label! : "",
                      selectedItem: DropdownData(label: categoryName),
                      onChanged: (DropdownData? data) {
                        setState(() {
                          print(data);
                          tankCategoriesId = data!.value;
                          categoryName = data.label;
                        });
                      },
                    ),
                  )
                : SizedBox(),
            SizedBox(height: 20),
          ],
        ),
      );
    }

    Widget dropdownTubeStatus(TubeState state) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                "Status Tabung",
                style:
                    greyFontStyle.copyWith(fontSize: 12, fontWeight: regular),
              ),
            ),
            state.dropdownTube.status != null
                ? Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: kPinkYoungColor),
                    child: DropdownSearch<DropdownData>(
                      mode: Mode.MENU,
                      dropdownSearchDecoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: InputBorder.none,
                      ),
                      items: state.dropdownTube.status
                          ?.where((element) => element.label != resultStatus)
                          .toList(),
                      itemAsString: (d) => d!.label != null ? d.label! : "",
                      selectedItem: DropdownData(label: resultStatus),
                      onChanged: (DropdownData? data) {
                        setState(() {
                          resultStatus = data!.label;
                        });
                      },
                    ),
                  )
                : SizedBox(),
            SizedBox(height: 20),
          ],
        ),
      );
    }

    Widget dataTube(TubeState state) {
      _noteController.text = widget.dataDao != null ? widget.dataDao!.note : "";
      return Column(
        children: [
          tubeNumber(
              widget.dataDao != null ? widget.dataDao!.serialNumber : 'kosong'),
          CustomTextFieldBorder(
            title: 'Lokasi Tabung',
            hintText: "",
            isReadonly: true,
            controller: _locationController,
          ),
          dropdownTubeCategories(state),
          dropdownTubeStatus(state),
          CustomTextFieldPink(
            title: 'Informasi Tambahan',
            maxlines: 4,
            controller: _noteController,
          ),
        ],
      );
    }

    return BlocConsumer<TubeBloc, TubeState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state.status == TubeStatus.update_stock_tube_loaded) {
          successAlertDialog(context, "Berhasil Update Data Tabung");

          Future.delayed(Duration(seconds: 1), () {
            if (roleUser == "refill staff") {
              context.read<PageCubit>().setPage(0);
              nextScreenRemoveUntil(context, MainFillingPage());
            } else {
              context.read<PageCubit>().setPage(0);
              nextScreenRemoveUntil(context, MainPage());
            }
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppbarDetail(title: 'Detail Tabung'),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                dataTube(state),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ButtonPrimary(
                isLoading: state.status == TubeStatus.update_stock_tube_loading,
                title: 'Update data tabung',
                color: kYellowColor,
                onTap: () {
                  _submitForm();
                }),
          ),
        );
      },
    );
  }

  void _submitForm() {
    UpdateTubeRequest requestUpdate = UpdateTubeRequest(
      tubeId: widget.dataDao!.tubeId.toString(),
      tankCategoryId: tankCategoriesId,
      serialNumber: widget.dataDao!.serialNumber,
      status: resultStatus,
      location: _locationController.text,
      note: _noteController.text,
    );
    context.read<TubeBloc>()
      ..add(UpdateStockTubeEvent(requestUpdate: requestUpdate));
  }
}
