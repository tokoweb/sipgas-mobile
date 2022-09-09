part of '../pages.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String? currentLogin = "warehouse staff";
  bool _passwordInVisible = true;
  int? index;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget logo() {
      return Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 60),
          width: 240,
          child: Image.asset('assets/icon/ic_logo_white.png'),
        ),
      );
    }

    Widget loginCard() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 16),
            child: Text(
              "Login Sebagai",
              style: whiteFontStyle.copyWith(fontWeight: bold, fontSize: 16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => setState(() {
                  currentLogin = "warehouse staff";
                }),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: (currentLogin == "warehouse staff")
                            ? kWhiteColor
                            : kYoungRedColor,
                        borderRadius: BorderRadius.circular(4.0),
                        boxShadow: [
                          (currentLogin == "warehouse staff")
                              ? BoxShadow(
                                  color: Colors.black.withOpacity(0.10),
                                  spreadRadius: 4,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                )
                              : BoxShadow(),
                        ],
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icon/ic_werehouse.svg',
                          color: (currentLogin == "warehouse staff")
                              ? kRedColor
                              : kPinkColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Staff Gudang',
                      style: whiteFontStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => setState(() {
                  currentLogin = "driver staff";
                }),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: (currentLogin == "driver staff")
                            ? kWhiteColor
                            : kYoungRedColor,
                        borderRadius: BorderRadius.circular(4.0),
                        boxShadow: [
                          (currentLogin == "driver staff")
                              ? BoxShadow(
                                  color: Colors.black.withOpacity(0.10),
                                  spreadRadius: 4,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                )
                              : BoxShadow(),
                        ],
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icon/ic_driver.svg',
                          color: (currentLogin == "driver staff")
                              ? kRedColor
                              : kPinkColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Driver',
                      style: whiteFontStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => setState(() {
                  currentLogin = "refill staff";
                }),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: (currentLogin == "refill staff")
                            ? kWhiteColor
                            : kYoungRedColor,
                        borderRadius: BorderRadius.circular(4.0),
                        boxShadow: [
                          (currentLogin == "refill staff")
                              ? BoxShadow(
                                  color: Colors.black.withOpacity(0.10),
                                  spreadRadius: 4,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                )
                              : BoxShadow(),
                        ],
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icon/ic_staff.svg',
                          color: (currentLogin == "refill staff")
                              ? kRedColor
                              : kPinkColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Staff Pengisi',
                      style: whiteFontStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Divider(
              color: kYoungGreyColor,
            ),
          ),
        ],
      );
    }

    Widget formLogin(LoginState state) {
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                "Masukkan Username dan Password",
                style: whiteFontStyle.copyWith(fontSize: 14, fontWeight: bold),
              ),
            ),
            CustomTextField(
              textHint: "Username",
              isPassword: false,
              controller: emailController,
            ),
            SizedBox(height: 20),
            CustomTextField(
              textHint: "Password",
              isPassword: true,
              controller: passwordController,
              obsecureText: _passwordInVisible,
              icon: GestureDetector(
                onTap: () {
                  setState(() {
                    _passwordInVisible =
                        !_passwordInVisible; //change boolean value
                  });
                },
                child: Icon(
                  _passwordInVisible
                      ? Icons.visibility_off
                      : Icons.visibility, //change icon based on boolean value
                  color: kGreyColor,
                ),
              ),
            ),
            // SizedBox(height: 15),
            // Align(
            //   alignment: Alignment.bottomRight,
            //   child: GestureDetector(
            //     onTap: () => nextScreen(context, ForgotPassword()),
            //     child: RichText(
            //       text: TextSpan(
            //         style: whiteFontStyle.copyWith(
            //             fontWeight: light, fontSize: 12),
            //         children: [
            //           TextSpan(text: "Lupa password? "),
            //           TextSpan(
            //             text: "Reset password",
            //             style: TextStyle(
            //               decoration: TextDecoration.underline,
            //               fontWeight: bold,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(height: 60),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 100),
              child: ButtonPrimary(
                isLoading: state.status == LoginStatus.submitting,
                onTap: () => _submitForm(
                    context, state.status == LoginStatus.submitting),
                title: "Login",
                color: kYellowColor,
              ),
            ),
            SizedBox(height: 30)
          ],
        ),
      );
    }

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.error) {
          // showDialog(
          //     context: context,
          //     builder: (context) =>
          //         ErrorDialog(message: state.failure.message));
          alertLoginError(context, state.failure.message);
        } else if (state.status == LoginStatus.success) {
          if (currentLogin == "warehouse staff") {
            context.read<PageCubit>().setPage(0);
            context.read<ProfileBloc>()..add(FetchProfileEvent());

            nextScreenRemoveUntil(context, MainPage());
          } else if (currentLogin == "driver staff") {
            context.read<PageCubit>().setPage(0);
            context.read<ProfileBloc>()..add(FetchProfileEvent());

            nextScreenRemoveUntil(context, MainDriverPage());
          } else if (currentLogin == "refill staff") {
            context.read<PageCubit>().setPage(0);
            context.read<ProfileBloc>()..add(FetchProfileEvent());

            nextScreenRemoveUntil(context, MainFillingPage());
          }
        }
      },
      builder: (context, state) {
        print("Kevin adada" + state.status.toString());
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg_login.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            backgroundColor: kTransparantColor,
            body: ListView(
              children: [
                SafeArea(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        logo(),
                        loginCard(),
                        formLogin(state),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _submitForm(BuildContext context, bool isSubmitting) {
    if (emailController.text.length > 0 && passwordController.text.length > 0) {
      if (!isSubmitting) {
        context.read<LoginCubit>().loginProcess(
            emailController.text, passwordController.text, currentLogin!);
      }
      print("yoit");
    } else {
      showDialog(
          context: context,
          builder: (context) => ErrorDialog(message: "Lengkapi Form"));
    }
  }
}
