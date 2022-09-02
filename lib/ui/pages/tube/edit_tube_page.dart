part of '../pages.dart';

class EditTubePage extends StatefulWidget {
  final TubeDao? dataDao;
  final String? scanType;
  const EditTubePage({Key? key, this.dataDao, this.scanType}) : super(key: key);

  @override
  _EditTubePageState createState() => _EditTubePageState();
}

class _EditTubePageState extends State<EditTubePage> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _locationController.text =
        widget.dataDao != null ? widget.dataDao!.location : "";
    _categoryController.text =
        widget.dataDao != null ? widget.dataDao!.categoryName : "";
    _statusController.text =
        widget.dataDao != null ? widget.dataDao!.status : "";

    _noteController.text = widget.dataDao != null ? widget.dataDao!.note : "";

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

    Widget dataTube() {
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
          CustomTextFieldBorder(
            title: 'Kategori Tabung',
            hintText: '',
            isReadonly: true,
            controller: _categoryController,
          ),
          CustomTextFieldBorder(
            title: 'Status Tabung',
            hintText: '',
            isReadonly: true,
            controller: _statusController,
          ),
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
        if (state.status == TubeStatus.edit_note_loaded) {
          context.read<TubeBloc>()..add(GetListTubeScanEvent());
          context.read<TravelDocBloc>()..add(FetchListScanTubeTravelDoc());

          successAlertDialog(context, state.message);
          // nextScreenRemoveUntil(
          //     context, ScanTubePage(scanType: widget.scanType));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppbarDetail(title: 'Detail Tabung'),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                dataTube(),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ButtonPrimary(
                title: 'Simpan',
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
    context.read<TubeBloc>()
      ..add(UpdateNoteTube(
          tubeId: widget.dataDao!.id!, note: _noteController.text));
  }
}
