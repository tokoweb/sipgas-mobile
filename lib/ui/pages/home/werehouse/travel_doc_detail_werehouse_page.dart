part of '../../pages.dart';

class TravelDocDetailWerehousePage extends StatefulWidget {
  const TravelDocDetailWerehousePage({Key? key}) : super(key: key);

  @override
  _TravelDocDetailWerehousePageState createState() =>
      _TravelDocDetailWerehousePageState();
}

class _TravelDocDetailWerehousePageState
    extends State<TravelDocDetailWerehousePage> {
  final TextEditingController _customerController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _numberTubeController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _driverController = TextEditingController();
  final TextEditingController _vehicleController = TextEditingController();
  final TextEditingController _qtyTubeController = TextEditingController();
  SharedPref pref = inject<SharedPref>();

  var driverSelected = "";
  var vehicleSelected = "";
  var driverId;
  var vehicleId;
  var statusScan;

  getStatusScan() async {
    int? prefScan = await pref.getTubeScanTravel();

    setState(() {
      statusScan = prefScan;
    });
  }

  getDropdownSeletced(TravelDocState state) async {
    var vehicleResult = state.travelDocDetail.vehicleData != null
        ? "${state.travelDocDetail.vehicleData!.serialNumber} - ${state.travelDocDetail.vehicleData!.type} - ${state.travelDocDetail.vehicleData!.licensePlate}"
        : "";

    var vehicleIdResult = state.travelDocDetail.vehicleData != null &&
            state.travelDocDetail.vehicleData!.vehicleId != null
        ? state.travelDocDetail.vehicleData!.vehicleId!
        : "";

    var driverResult = state.travelDocDetail.driverData != null &&
            state.travelDocDetail.driverData!.name != null
        ? state.travelDocDetail.driverData!.name!
        : "";

    var driverIdResult = state.travelDocDetail.driverData != null &&
            state.travelDocDetail.driverData!.userId != null
        ? state.travelDocDetail.driverData!.userId!
        : "";

    setState(() {
      driverSelected = driverResult;
      driverId = driverIdResult;

      vehicleSelected = vehicleResult;
      vehicleId = vehicleIdResult;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<TravelDocBloc>().add(FetchNoteTravelDocEvent());
    getStatusScan();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void addNote(BuildContext context, bool isUpdate, NoteDao? data) {
    if (data == null) {
      _noteController.text = "";
    } else {
      _noteController.text = data.desc!;
    }

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
                  color: kScaffoldColor,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextField(
                      controller: _noteController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.only(bottom: 5, top: 5, right: 25),
                      ),
                      onSubmitted: (val) {
                        if (isUpdate) {
                        } else {
                          context.read<TravelDocBloc>()
                            ..add(InsertNoteTravelDocEvent(
                                noteDao: NoteDao(id: null, desc: val)));
                        }
                        context
                            .read<TravelDocBloc>()
                            .add(FetchNoteTravelDocEvent());
                        Navigator.pop(context);
                      },
                      autofocus: true,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (isUpdate) {
                          context.read<TravelDocBloc>()
                            ..add(
                              UpdateNoteTravelDocEvent(
                                noteDao: NoteDao(
                                  id: data!.id,
                                  desc: _noteController.text,
                                ),
                              ),
                            );
                        } else {
                          context.read<TravelDocBloc>()
                            ..add(
                              InsertNoteTravelDocEvent(
                                noteDao: NoteDao(
                                  id: null,
                                  desc: _noteController.text,
                                ),
                              ),
                            );
                        }
                        context
                            .read<TravelDocBloc>()
                            .add(FetchNoteTravelDocEvent());
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        "assets/icon/ic_send.svg",
                        width: 20,
                        height: 20,
                        color: kBlackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getStatusScan();

    Widget countOfTube(TravelDocState state) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                'Jumlah Tabung',
                style:
                    greyFontStyle.copyWith(fontSize: 12, fontWeight: regular),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: kPinkYoungColor),
              child: TextFormField(
                onTap: () {
                  context.read<TravelDocBloc>()
                    ..add(FetchListScanTubeTravelDoc());
                  nextScreen(
                      context,
                      CountTubePageCategoryPage(
                          tubeDetail: state.travelDocDetail));
                },
                readOnly: true,
                controller: _numberTubeController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: Icon(
                      Icons.arrow_right,
                      color: kBlackColor,
                    )),
              ),
            )
          ],
        ),
      );
    }

    Widget dropdownDriver(TravelDocState state) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                "Driver",
                style:
                    greyFontStyle.copyWith(fontSize: 12, fontWeight: regular),
              ),
            ),
            state.dropdownDriver.drivers != null
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
                      items: state.dropdownDriver.drivers,
                      itemAsString: (d) => d!.label != null ? d.label! : "",
                      selectedItem: DropdownData(label: "$driverSelected"),
                      onChanged: (DropdownData? data) {
                        setState(() {
                          driverSelected = data!.label!;
                          driverId = data.value;
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

    Widget dropdownVehicle(TravelDocState state) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                "ID Kendaraan",
                style:
                    greyFontStyle.copyWith(fontSize: 12, fontWeight: regular),
              ),
            ),
            state.dropdownDriver.drivers != null
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
                      items: state.dropdownDriver.vehicles,
                      itemAsString: (d) => d!.label != null ? d.label! : "",
                      selectedItem: DropdownData(label: "$vehicleSelected"),
                      onChanged: (DropdownData? data) {
                        setState(() {
                          vehicleSelected = data!.label!;
                          vehicleId = data.value;
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

    Widget notesList(TravelDocState state) {
      return state.travelDocDetail.noteData != null &&
              state.travelDocDetail.noteData!.length > 0
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Catatan",
                    style: greyFontStyle.copyWith(
                        fontSize: 12, fontWeight: regular),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: state.travelDocDetail.noteData!.length,
                  itemBuilder: (context, index) {
                    return NoteItem(
                      data: state.travelDocDetail.noteData![index],
                    );
                  },
                ),
              ],
            )
          : SizedBox();
    }

    Widget addNoteList(TravelDocState state) {
      return Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: state.noteDao.length,
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    color: kPinkYoungColor,
                    borderRadius: BorderRadius.circular(4.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.noteDao[index].name!,
                      style: greyFontStyle.copyWith(
                          fontSize: 14, fontWeight: regular),
                    ),
                    SizedBox(height: 4),
                    Text(
                      state.noteDao[index].desc!,
                      style: blackFontStyle.copyWith(
                          fontSize: 14, fontWeight: regular),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 10),
          state.travelDocDetail.status == "DELIVERY" ||
                  state.travelDocDetail.status == "DONE"
              ? SizedBox()
              : Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => state.noteDao.length == 0
                        ? addNote(context, false, null)
                        : addNote(context, true, state.noteDao[0]),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: kYellowColor),
                      child: Text(
                        state.noteDao.length == 0
                            ? "Tambah catatan"
                            : "Edit Catatan",
                        style: blackFontStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      );
    }

    Widget countOfTubeDone(TravelDocState state) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                'Jumlah Tabung',
                style:
                    greyFontStyle.copyWith(fontSize: 12, fontWeight: regular),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: kPinkYoungColor),
              child: TextFormField(
                onTap: () {
                  nextScreen(
                    context,
                    CountTubDonePage(
                      tubeDetail: state.travelDocDetail,
                    ),
                  );
                },
                readOnly: true,
                controller: _numberTubeController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.arrow_right,
                    color: kBlackColor,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget attachmentList(TravelDocState state) {
      return state.travelDocDetail.attachments != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Attachment',
                    style: greyFontStyle.copyWith(
                        fontSize: 12, fontWeight: regular),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: kPinkYoungColor),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  height: 100,
                  child: state.travelDocDetail.attachments!.length > 0
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.travelDocDetail.attachments!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  right: (index ==
                                          state.travelDocDetail.attachments!
                                              .last)
                                      ? 0
                                      : 6),
                              child: GestureDetector(
                                onTap: () => nextScreen(
                                    context,
                                    ImageFullscreenUrl(
                                        urlImage: state.travelDocDetail
                                            .attachments![index].url!)),
                                child: Container(
                                  width: 75,
                                  height: 75,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: kPinkYoungColor),
                                    image: DecorationImage(
                                      image: NetworkImage(state.travelDocDetail
                                          .attachments![index].url!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.picture_in_picture, color: kGreyColor),
                              SizedBox(height: 5),
                              Text("Tidak ada data",
                                  style: greyFontStyle.copyWith(fontSize: 12))
                            ],
                          ),
                        ),
                ),
                const SizedBox(height: 20),
              ],
            )
          : SizedBox();
    }

    Widget dataTravelDoc(TravelDocState state) {
      _customerController.text = state.travelDocDetail.customerData != null
          ? state.travelDocDetail.customerData!.name!
          : '';
      _dateController.text =
          state.travelDocDetail.date != null ? state.travelDocDetail.date! : '';
      _numberTubeController.text = state.travelDocDetail.tanksCount != null
          ? state.travelDocDetail.tanksCount!.toString()
          : '';

      _driverController.text = state.travelDocDetail.driverData != null &&
              state.travelDocDetail.driverData!.name != null
          ? state.travelDocDetail.driverData!.name!
          : "";

      _vehicleController.text = state.travelDocDetail.vehicleData != null
          ? "${state.travelDocDetail.vehicleData!.serialNumber} - ${state.travelDocDetail.vehicleData!.type} - ${state.travelDocDetail.vehicleData!.licensePlate}"
          : "";

      _qtyTubeController.text = state.travelDocDetail.tanksCount != null
          ? "${state.travelDocDetail.tanksCount}"
          : "";

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFieldBorder(
            title: 'Customer',
            isReadonly: true,
            controller: _customerController,
          ),
          state.travelDocDetail.status == "DELIVERY" ||
                  state.travelDocDetail.status == "DONE"
              ? state.travelDocDetail.status == "DONE"
                  ? countOfTubeDone(state)
                  : CustomTextFieldBorder(
                      title: 'Jumlah Tabung',
                      isReadonly: true,
                      controller: _qtyTubeController,
                    )
              : countOfTube(state),
          CustomTextFieldBorder(
            title: 'Tanggal Pengiriman',
            isReadonly: true,
            controller: _dateController,
          ),
          state.travelDocDetail.status == "DELIVERY" ||
                  state.travelDocDetail.status == "DONE"
              ? CustomTextFieldBorder(
                  title: 'Driver',
                  isReadonly: true,
                  controller: _driverController,
                )
              : dropdownDriver(state),
          state.travelDocDetail.status == "DELIVERY" ||
                  state.travelDocDetail.status == "DONE"
              ? CustomTextFieldBorder(
                  title: 'ID Kendaraan',
                  isReadonly: true,
                  controller: _vehicleController,
                )
              : dropdownVehicle(state),
          state.travelDocDetail.status == "DONE"
              ? attachmentList(state)
              : SizedBox(),
          notesList(state),
          addNoteList(state),
        ],
      );
    }

    return BlocConsumer<TravelDocBloc, TravelDocState>(
      listener: (context, state) {
        print("Kevin surat jalan status ${state.status}");
        getDropdownSeletced(state);
        if (state.status == TravelDocStatus.update_travel_doc_loaded) {
          successAlertDialog(
              context, "Data surat jalan sementara berhasil diupdate");

          Future.delayed(Duration(seconds: 1), () {
            context.read<PageCubit>().setPage(1);
            nextScreenRemoveUntil(context, MainPage());
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppbarDetail(
              title: state.travelDocDetail.code != null
                  ? state.travelDocDetail.code!
                  : ""),
          body: state.status != TravelDocStatus.loading
              ? SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      dataTravelDoc(state),
                    ],
                  ),
                )
              : Center(child: CircularProgressIndicator(color: kPrimaryColor)),
          bottomNavigationBar: Container(
            height: 100,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: _noteController.text.length != 0
                ? ButtonPrimary(
                    isLoading: state.status ==
                        TravelDocStatus.update_travel_doc_loading,
                    color: kYellowColor,
                    title: "Update data surat jalan sementara",
                    onTap: () => _submitForm(state),
                  )
                : ButtonPrimary(
                    color: kGreyNavColor,
                    title: "Update data surat jalan sementara",
                    onTap: () {},
                  ),
          ),
        );
      },
    );
  }

  void _submitForm(TravelDocState state) async {
    if (_noteController.text.length != 0 && statusScan != 0) {
      List<dynamic> categoryId =
          state.travelDocDetail.tankCategoriesData != null
              ? state.travelDocDetail.tankCategoriesData!
                  .map((e) => e.tankCategoryId)
                  .toList()
              : [];

      UpdateTravelDocRequest updateTravelDocRequest = UpdateTravelDocRequest(
        driverId: driverId,
        vehicleId: vehicleId,
        note: _noteController.text,
        categoryId: categoryId,
      );
      context.read<TravelDocBloc>()
        ..add(
          UpdateTravelDocEvent(
            id: "${state.travelDocDetail.id.toString()}",
            updateTravelDocRequest: updateTravelDocRequest,
          ),
        );
    } else {
      showDialog(
          context: context,
          builder: (context) => ErrorDialog(
              message:
                  "Anda belum melakukan scan tabung atau data yang anda scan belum tersimpan."));
    }
  }
}
