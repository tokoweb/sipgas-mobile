part of '../pages.dart';

class EditProfilePage extends StatefulWidget {
  final String? name;
  final String? email;
  final String? username;
  final String? phone;
  final String? avatar;
  const EditProfilePage(
      {Key? key, this.name, this.email, this.username, this.phone, this.avatar})
      : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? pictureFile;
  XFile? pickedFile;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void updateProfileBottomSheet(BuildContext context) {
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
                  _openGallery();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _nameController.text = widget.name!;
    _emailController.text = widget.email!;
    _usernameController.text = widget.username!;
    _phoneController.text = widget.phone!;

    return Scaffold(
      appBar: CustomAppbarDetail(
        title: 'Edit Profile',
      ),
      body: BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
        listener: (context, state) {
          if (state.status == UpdateProfileStatus.error) {
            showDialog(
                context: context,
                builder: (context) =>
                    ErrorDialog(message: state.failure.message));
            context.read<ProfileBloc>().add(FetchProfileEvent());
          } else if (state.status == UpdateProfileStatus.success) {
            context.read<ProfileBloc>().add(FetchProfileEvent());
            successAlertDialog(context, "Berhasil Update Profile");
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Stack(
                        fit: StackFit.expand,
                        clipBehavior: Clip.none,
                        children: [
                          (pictureFile == null)
                              ? widget.avatar != ''
                                  ? Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        image: DecorationImage(
                                          image: NetworkImage(widget.avatar!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/sample_avatar.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                              : Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    image: DecorationImage(
                                      image: FileImage(pictureFile!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: GestureDetector(
                              onTap: () => updateProfileBottomSheet(context),
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                      'assets/icon/ic_camera.svg',
                                      width: 18.0,
                                      height: 18.0,
                                      color: kWhiteColor),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                CustomTextFieldPink(
                  title: 'Nama',
                  inputType: TextInputType.name,
                  controller: _nameController,
                ),
                CustomTextFieldPink(
                  title: 'Email',
                  inputType: TextInputType.emailAddress,
                  controller: _emailController,
                ),
                CustomTextFieldPink(
                  title: 'Username',
                  inputType: TextInputType.number,
                  controller: _usernameController,
                ),
                CustomTextFieldPink(
                  title: 'Telepon',
                  inputType: TextInputType.number,
                  controller: _phoneController,
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ButtonPrimary(
                isLoading: state.status == UpdateProfileStatus.submitting,
                title: 'Simpan',
                color: kYellowColor,
                onTap: () {
                  _submitForm();
                  //  successAlertDialog(context, "Berhasil Update Data"),
                }),
          );
        },
      ),
    );
  }

  _openGallery() async {
    pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedFile != null) {
      pictureFile = File(pickedFile!.path);
      setState(() {});
    }
  }

  _openCamera() async {
    pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    if (pickedFile != null) {
      pictureFile = File(pickedFile!.path);
      setState(() {});
    }
  }

  bool isValidateTextEdit() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _usernameController.text.isEmpty) {
      return false;
    }

    return true;
  }

  void _submitForm() async {
    if (pickedFile != null) {
      var avatar = await MultipartFile.fromFile(
        pickedFile!.path,
        filename: pickedFile!.path.split('/').last,
        contentType: MediaType('image', 'png'),
      );
      if (isValidateTextEdit()) {
        context.read<UpdateProfileCubit>().updateProfileProcess(
            _nameController.text,
            _emailController.text,
            _usernameController.text,
            _phoneController.text,
            avatar);
      } else {
        showDialog(
            context: context,
            builder: (context) => ErrorDialog(message: "Lengkapi form"));
      }
    } else {
      print("tanpa image");
      if (isValidateTextEdit()) {
        context.read<UpdateProfileCubit>().updateProfileWithoutImageProcess(
              _nameController.text,
              _emailController.text,
              _usernameController.text,
              _phoneController.text,
            );
      } else {
        showDialog(
            context: context,
            builder: (context) => ErrorDialog(message: "Lengkapi form"));
      }
    }
  }
}
