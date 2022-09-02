part of '../../pages.dart';

class TravelDocDetailDriverPage extends StatefulWidget {
  const TravelDocDetailDriverPage({Key? key}) : super(key: key);

  @override
  _TravelDocDetailDriverPageState createState() =>
      _TravelDocDetailDriverPageState();
}

class _TravelDocDetailDriverPageState extends State<TravelDocDetailDriverPage> {
  final TextEditingController _customerController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _numberTubeController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _recipientNameController =
      TextEditingController();
  final TextEditingController _recipientNameNotNullController =
      TextEditingController();

  SharedPref pref = inject<SharedPref>();
  var statusScan;

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  XFile? pickedFile;

  getStatusScan() async {
    int? prefScan = await pref.getTubeScanTravel();

    setState(() {
      statusScan = prefScan;
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

  void _mutliImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage(
      imageQuality: 50,
    );

    if (selectedImages != null) {
      imageFileList!.addAll(selectedImages);
    }

    print("Image List Length:" + imageFileList!.length.toString());
    setState(() {});
  }

  _openGallery() async {
    pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedFile != null) {
      imageFileList!.add(pickedFile!);
      setState(() {});
    }
  }

  _openCamera() async {
    pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    if (pickedFile != null) {
      imageFileList!.add(pickedFile!);
      setState(() {});
    }
  }

  void addImageList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: kTransparantColor,
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          height: 180,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Pilih Media",
                          style: blackFontStyle.copyWith(
                              fontSize: 14, fontWeight: bold),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close, size: 20),
                    )
                  ],
                ),
              ),
              CustomButtonScan(
                title: 'Kamera',
                icon: 'assets/icon/ic_camera.svg',
                function: () {
                  Navigator.pop(context);
                  _openCamera();
                },
              ),
              CustomButtonScan(
                title: 'Galeri',
                icon: 'assets/icon/ic_album.svg',
                function: () {
                  Navigator.pop(context);
                  _mutliImages();
                },
              ),
            ],
          ),
        );
      },
    );
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
      _numberTubeController.text = state.travelDocDetail.tanksCount != null
          ? "${state.travelDocDetail.tanksCount}"
          : "";

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

    Widget attachment() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              'Attachment',
              style: greyFontStyle.copyWith(fontSize: 12, fontWeight: regular),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kPinkYoungColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => addImageList(context),
                    child: Container(
                      width: 75,
                      height: 75,
                      margin: EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: kPinkColor,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icon/ic_upload_file.svg',
                          width: 20,
                          height: 20,
                          color: kBlackColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 75,
                    child: ListView.builder(
                      itemCount: imageFileList!.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        if (imageFileList!.length == 0) {
                          return Text('data');
                        } else {
                          return Padding(
                            padding: EdgeInsets.only(
                                right: (index == imageFileList!.last) ? 0 : 6),
                            child: ImagePickerItem(
                              listImage: imageFileList,
                              imagePath: imageFileList![index].path,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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

    Widget addNoteResult(TravelDocState state) {
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
          state.travelDocDetail.status != "DONE"
              ? Align(
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
                )
              : SizedBox(),
        ],
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
              ],
            )
          : SizedBox();
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

    Widget data1(TravelDocState state) {
      _customerController.text = state.travelDocDetail.customerData != null &&
              state.travelDocDetail.customerData!.name != null
          ? state.travelDocDetail.customerData!.name!
          : "";
      _dateController.text =
          state.travelDocDetail.date != null ? state.travelDocDetail.date! : "";

      _numberTubeController.text = state.travelDocDetail.tanksCount != null
          ? "${state.travelDocDetail.tanksCount}"
          : "";

      return Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        decoration: BoxDecoration(
          color: kWhiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.10),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            CustomTextFieldBorder(
              title: 'Customer',
              isReadonly: true,
              controller: _customerController,
            ),
            state.travelDocDetail.status != "DONE"
                ? countOfTube(state)
                : countOfTubeDone(state),
            CustomTextFieldBorder(
              title: 'Tanggal pengiriman',
              isReadonly: true,
              controller: _dateController,
            ),
          ],
        ),
      );
    }

    Widget data2(TravelDocState state) {
      _recipientNameNotNullController.text =
          state.travelDocDetail.recipientName != null
              ? state.travelDocDetail.recipientName!
              : "";

      return Container(
        decoration: BoxDecoration(
          color: kWhiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.10),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            state.travelDocDetail.status != "DONE"
                ? CustomTextFieldPink(
                    title: 'Nama Penerima',
                    controller: _recipientNameController,
                  )
                : CustomTextFieldBorder(
                    title: 'Nama Penerima',
                    isReadonly: true,
                    controller: _recipientNameNotNullController,
                  ),
            state.travelDocDetail.status != "DONE"
                ? attachment()
                : attachmentList(state)
          ],
        ),
      );
    }

    Widget data3(TravelDocState state) {
      return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: kWhiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.10),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            notesList(state),
            SizedBox(height: 10),
            addNoteResult(state),
          ],
        ),
      );
    }

    Widget line() {
      return Container(
        height: 8,
        color: kScaffoldColor,
      );
    }

    return BlocConsumer<TravelDocBloc, TravelDocState>(
      listener: (context, state) {
        if (state.status == TravelDocStatus.update_travel_doc_loaded) {
          successAlertDialog(
              context, "Data surat jalan sementara berhasil diupdate");

          Future.delayed(Duration(seconds: 1), () {
            context.read<PageCubit>().setPage(1);
            nextScreenRemoveUntil(context, MainDriverPage());
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
                  child: Column(
                    children: [
                      data1(state),
                      line(),
                      data2(state),
                      line(),
                      data3(state),
                    ],
                  ),
                )
              : Center(child: CircularProgressIndicator(color: kPrimaryColor)),
          bottomNavigationBar: Container(
            height: 100,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            color: kWhiteColor,
            child: state.travelDocDetail != "DONE" &&
                    _noteController.text.length > 0 &&
                    _recipientNameController.text.length > 0 &&
                    imageFileList!.length > 0
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
    if (_noteController.text.length != 0 &&
        statusScan != 0 &&
        _recipientNameController.text.length != 0 &&
        imageFileList!.length > 0) {
      List<dynamic> categoryId =
          state.travelDocDetail.tankCategoriesData != null
              ? state.travelDocDetail.tankCategoriesData!
                  .map((e) => e.tankCategoryId)
                  .toList()
              : [];

      UpdateTravelDocRequest updateTravelDocRequest = UpdateTravelDocRequest(
        note: _noteController.text,
        categoryId: categoryId,
        recipientName: _recipientNameController.text,
      );

      List<MultipartFile>? dataImage = [];

      imageFileList!.forEach((element) async {
        dataImage.add(await MultipartFile.fromFile(
          element.path,
          filename: element.path.split('/').last,
          contentType: MediaType('image', 'png'),
        ));
      });

      AttachmentRequest imageRequest = AttachmentRequest(
        id: "${state.travelDocDetail.id.toString()}",
        attachments: dataImage,
      );

      context.read<TravelDocBloc>()
        ..add(
          UpdateTravelDocDriverEvent(
            id: "${state.travelDocDetail.id.toString()}",
            updateTravelDocRequest: updateTravelDocRequest,
            imageRequest: imageRequest,
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
