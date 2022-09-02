part of '../pages.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _currentPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarDetail(title: "Ganti Password"),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.status == ProfileStatus.error) {
            showDialog(
                context: context,
                builder: (context) =>
                    ErrorDialog(message: state.failure.message));
          } else if (state.status == ProfileStatus.change_password_loaded) {
            successAlertDialog(context, "Berhasil Ganti Password");
          }
        },
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 20),
                CustomTextFieldPink(
                  isPassword: true,
                  title: 'Ketik password lama',
                  inputType: TextInputType.name,
                  controller: _currentPassController,
                ),
                CustomTextFieldPink(
                  isPassword: true,
                  title: 'Ketik password baru',
                  inputType: TextInputType.name,
                  controller: _newPassController,
                ),
                CustomTextFieldPink(
                  isPassword: true,
                  title: 'Ketik ulang password lama',
                  inputType: TextInputType.name,
                  controller: _confirmPassController,
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            height: 50,
            child: ButtonPrimary(
                isLoading:
                    state.status == ProfileStatus.change_password_loading,
                title: 'Simpan',
                color: kYellowColor,
                onTap: () => _submitForm(context)),
          );
        },
      ),
    );
  }

  void _submitForm(BuildContext context) {
    if (_currentPassController.text.length > 0 &&
        _newPassController.text.length > 0 &&
        _confirmPassController.text.length > 0) {
      if (_currentPassController.text.length >= 6) {
        if (_newPassController.text == _confirmPassController.text) {
          context.read<ProfileBloc>().add(ChangePasswordEvent(
              currentPassword: _currentPassController.text,
              newPassword: _newPassController.text,
              confirmPassword: _confirmPassController.text));
        } else {
          showDialog(
              context: context,
              builder: (context) =>
                  ErrorDialog(message: "Password tidak sama"));
        }
      } else {
        showDialog(
            context: context,
            builder: (context) =>
                ErrorDialog(message: "Password harus lebih dari 5"));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => ErrorDialog(message: "Lengkapi Form"));
    }
  }
}
