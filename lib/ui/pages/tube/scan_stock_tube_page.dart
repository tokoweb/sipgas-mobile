part of '../pages.dart';

class ScanStockTubePage extends StatefulWidget {
  final String? serialNumber;
  const ScanStockTubePage({Key? key, this.serialNumber}) : super(key: key);

  @override
  _ScanStockTubePageState createState() => _ScanStockTubePageState();
}

class _ScanStockTubePageState extends State<ScanStockTubePage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

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
    Widget listTube(TubeState state) {
      return Container(
        child: state.tubeDao.length > 0
            ? ListView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: state.tubeDao.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ScanStockTubeItem(
                    data: state.tubeDao[index],
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
          } else if (state.status == TubeStatus.error ||
              state.status == TubeStatus.connection_error) {
            progress!.dismiss();
            showDialog(
                context: context,
                builder: (context) =>
                    ErrorDialog(message: state.failure.message));
          } else if (state.status == TubeStatus.tube_action_error) {
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
      print("serial number ${widget.serialNumber}");
      if (widget.serialNumber == result!.code!) {
        context
            .read<TubeBloc>()
            .add(ScanTubeEvent(serialNumber: result!.code!));
      } else {
        print("Anda salah scan tabung");
        controller.resumeCamera();
        errorAlertDialog(context, "Tabung yang Anda Scan Tidak Sesuai");
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
}
