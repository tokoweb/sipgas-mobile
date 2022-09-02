part of '../pages.dart';

class ScanTubePage extends StatefulWidget {
  final String? scanType;
  const ScanTubePage({Key? key, this.scanType}) : super(key: key);

  @override
  _ScanTubePageState createState() => _ScanTubePageState();
}

class _ScanTubePageState extends State<ScanTubePage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    super.initState();
    context.read<TubeBloc>().add(GetListTubeScanEvent());
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
    print("Scan type ${widget.scanType}");
    Widget listTube(TubeState state) {
      return Container(
        child: state.tubeDao.length > 0
            ? ListView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: state.tubeDao.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ScanItem(
                    data: state.tubeDao[index],
                    scanType: widget.scanType != null ? widget.scanType! : "",
                    actionDelete: () => questionAlertDialog(
                      context,
                      "Hapus Tabung",
                      "Apakah anda yakin ingin menghapus?",
                      () {
                        context.read<TubeBloc>().add(DeleteTubeEvent(
                            id: state.tubeDao[index].id.toString()));
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              )
            : SizedBox(),
      );
    }

    return ProgressHUD(
      child: BlocConsumer<TubeBloc, TubeState>(
        listener: (context, state) {
          print("Kevin status ${state.status}");
          final progress = ProgressHUD.of(context);
          if (state.status == TubeStatus.scan_tube_loading) {
            progress!.showWithText('Loading...');
            progress.show();
          } else if (state.status == TubeStatus.scan_tube_loaded) {
            Future.delayed(Duration(seconds: 2), () {
              // deleayed code here
              print('delayed execution');
              progress!.dismiss();
              context.read<TubeBloc>()..add(GetListTubeScanEvent());
              controller!.resumeCamera();
            });
          } else if (state.status == TubeStatus.save_data_scan_tube_loaded ||
              state.status == TubeStatus.save_data_scan_tube_out_loaded) {
            successAlertDialog(context, "Data Tabung Berhasil Disimpan");

            Future.delayed(Duration(seconds: 1), () {
              context.read<PageCubit>().setPage(0);
              nextScreenRemoveUntil(context, MainPage());
            });
          } else if (state.status == TubeStatus.tube_action_error) {
            errorAlertDialog(context, state.failure.message);
          } else if (state.status ==
              TubeStatus.save_data_scan_tube_filling_loaded) {
            successAlertDialog(context, "Data Tabung Berhasil Disimpan");

            Future.delayed(Duration(seconds: 1), () {
              context.read<PageCubit>().setPage(0);
              nextScreenRemoveUntil(context, MainFillingPage());
            });
          } else if (state.status ==
              TubeStatus.save_data_scan_tube_taking_driver_staf_loaded) {
            successAlertDialog(context, "Data Tabung Berhasil Disimpan");

            Future.delayed(Duration(seconds: 1), () {
              context.read<PageCubit>().setPage(0);
              nextScreenRemoveUntil(context, MainDriverPage());
            });
          } else if (state.status == TubeStatus.error ||
              state.status == TubeStatus.connection_error) {
            progress!.dismiss();
            showDialog(
                context: context,
                builder: (context) =>
                    ErrorDialog(message: state.failure.message));
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
              child: state.tubeDao.length > 0
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
      print("Kevin berscan scan");
      setState(() {
        result = scanData;
      });
      controller.pauseCamera();
      context.read<TubeBloc>().add(ScanTubeEvent(serialNumber: result!.code!));
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
    if (widget.scanType == "Kosong" ||
        widget.scanType == "Terisi" ||
        widget.scanType == "Maintenance") {
      context.read<TubeBloc>()
        ..add(SaveDataScanTubeEvent(status: widget.scanType!));
    } else if (widget.scanType == "out") {
      context.read<TubeBloc>()..add(SaveDataScanTubeOutEvent());
    } else if (widget.scanType == "pengisian_terisi") {
      context.read<TubeBloc>()..add(SaveDataScanTubeFillingStaf());
    } else if (widget.scanType == "taking_driver") {
      context.read<TubeBloc>()..add(SaveDataScanTubeDriverStaf());
    }
  }
}
