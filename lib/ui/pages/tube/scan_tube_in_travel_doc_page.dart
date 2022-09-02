part of '../pages.dart';

class ScanTubeInTravelDocPage extends StatefulWidget {
  final String? tankCategoryId;
  final String? countTanks;
  const ScanTubeInTravelDocPage(
      {Key? key, this.tankCategoryId, this.countTanks})
      : super(key: key);

  @override
  _ScanTubeInTravelDocPageState createState() =>
      _ScanTubeInTravelDocPageState();
}

class _ScanTubeInTravelDocPageState extends State<ScanTubeInTravelDocPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  int? jumlahTabung;

  @override
  void initState() {
    super.initState();
    context.read<TravelDocBloc>()..add(FetchListScanTubeTravelDoc());
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Tanks Category Id ${widget.tankCategoryId}");

    Widget listTube(TravelDocState state) {
      List<TubeDao>? listTubeByCategory = state.tubeDaoTravel.length > 0
          ? state.tubeDaoTravel
              .where(
                (element) =>
                    element.tankCategoryId == int.parse(widget.tankCategoryId!),
              )
              .toList()
          : [];

      jumlahTabung = listTubeByCategory.length;

      return Container(
        child: listTubeByCategory.length > 0
            ? ListView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: listTubeByCategory.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ScanItem(
                    data: listTubeByCategory[index],
                    scanType: null,
                    actionDelete: () => questionAlertDialog(
                      context,
                      "Hapus Tabung",
                      "Apakah anda yakin ingin menghapus?",
                      () {
                        context.read<TravelDocBloc>().add(
                            DeleteListScanByIdTubeTravelDoc(
                                id: listTubeByCategory[index].id.toString()));
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              )
            : SizedBox(),
      );
    }

    print("jumlah Tabung $jumlahTabung, count tanks ${widget.countTanks}");

    return ProgressHUD(
      child: BlocConsumer<TravelDocBloc, TravelDocState>(
        listener: (context, state) {
          print("Kevin status ${state.status}");
          final progress = ProgressHUD.of(context);
          if (state.status == TravelDocStatus.scan_tube_travel_loading) {
            progress!.showWithText('Loading...');
            progress.show();
          } else if (state.status == TravelDocStatus.scan_tube_travel_loaded) {
            Future.delayed(Duration(seconds: 2), () {
              // deleayed code here
              print('delayed execution');
              progress!.dismiss();
              context.read<TravelDocBloc>()..add(FetchListScanTubeTravelDoc());
              controller!.resumeCamera();
            });
          } else if (state.status == TravelDocStatus.error) {
            progress!.dismiss();
            controller!.resumeCamera();
            errorAlertDialog(context, state.message);
          } else if (state.status == TravelDocStatus.tube_action_error) {
            progress!.dismiss();
            controller!.resumeCamera();
            errorAlertDialog(context, state.failure.message);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppbarDetail(title: 'Scan Tabung'),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    margin: EdgeInsets.only(bottom: 40),
                    child: _buildQrView(context),
                  ),
                  listTube(state),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              height: 88,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              color: kWhiteColor,
              child: jumlahTabung! > 0
                  ? ButtonPrimary(
                      isLoading: state.status ==
                          TubeStatus.save_data_scan_tube_loading,
                      title: 'Simpan Data Tabung',
                      color: kYellowColor,
                      onTap: () => _submitTube(),
                    )
                  : ButtonPrimary(
                      title: 'Simpan Data Tabung',
                      color: kGreyNavColor,
                      onTap: () {},
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderColor: kPrimaryColor,
            borderRadius: 4,
            borderLength: 30,
            borderWidth: 5,
            cutOutSize: 500.0),
        onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      controller.pauseCamera();

      if (jumlahTabung! < int.parse(widget.countTanks!)) {
        context.read<TravelDocBloc>().add(ScanTubeTravelDocEvent(
            serialNumber: result!.code!,
            tankCategoryId: widget.tankCategoryId!));
      } else {
        errorAlertDialog(context, "Anda sudah scan melebihi jumlah tabung.");
        Future.delayed(Duration(seconds: 3), () {
          controller.resumeCamera();
        });
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    // log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _submitTube() {
    Navigator.pop(context);
  }
}
