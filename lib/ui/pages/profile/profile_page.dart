part of '../pages.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  SharedPref pref = inject<SharedPref>();

  Widget infoProfile(ProfileState state) {
    return Container(
      width: double.infinity,
      height: 100,
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          state.user.avatarUrl != null
              ? Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: NetworkImage(state.user.avatarUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/sample_avatar.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.user.name != null ? state.user.name! : "",
                    style:
                        blackFontStyle.copyWith(fontSize: 16, fontWeight: bold),
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        '${state.user.phone != null ? state.user.phone! : ""}',
                        style: greyFontStyle.copyWith(
                            fontSize: 12, fontWeight: regular),
                      ),
                      state.user.phone != null
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Image.asset(
                                "assets/icon/ic_round.png",
                                width: 4,
                                height: 4,
                              ),
                            )
                          : SizedBox(),
                      Expanded(
                        child: Text(
                          '${state.user.email != null ? state.user.email! : ""}',
                          style: greyFontStyle.copyWith(
                              fontSize: 12, fontWeight: regular),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => nextScreen(
                context,
                EditProfilePage(
                  name: state.user.name != null ? state.user.name! : "",
                  email: state.user.email != null ? state.user.email! : "",
                  username:
                      state.user.username != null ? state.user.username! : "",
                  phone: state.user.phone != null ? state.user.phone! : "",
                  avatar:
                      state.user.avatarUrl != null ? state.user.avatarUrl! : "",
                )),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: kYellowColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: SvgPicture.asset('assets/icon/ic_pencil.svg', width: 20),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget information() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(color: Color(0xffeeeeef)),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileItem(
                icon: "assets/icon/ic_change_password.svg",
                title: "Ganti Password",
                function: () => nextScreen(context, ChangePasswordPage()),
              ),
              ProfileItem(
                icon: "assets/icon/ic_customer.svg",
                title: "Customer Support",
                function: () => nextScreen(context, CustomerSupportPage()),
              ),
              ProfileItem(
                icon: "assets/icon/ic_terms.svg",
                title: "Syarat dan Ketentuan",
                function: () => nextScreen(context, TermConditionPage()),
              ),
              ProfileItem(
                icon: "assets/icon/ic_privacy.svg",
                title: "Kebijakan Privasi",
                function: () => nextScreen(context, PrivacyPolicyPage()),
              ),
              ProfileItem(
                icon: "assets/icon/ic_about.svg",
                title: "Tentang Aplikasi",
                function: () => nextScreen(context, AboutAppPage()),
              ),
              ProfileItem(
                icon: "assets/icon/ic_logout.svg",
                title: "Logout",
                function: () => questionAlertDialog(
                  context,
                  "Logout",
                  "Apakah anda yakin ingin keluar?",
                  () {
                    _submitLogout(context);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          print("state : ${state.status}");
          final progress = ProgressHUD.of(context);

          if (state.status == ProfileStatus.error) {
            progress!.dismiss();
            showDialog(
                context: context,
                builder: (context) =>
                    ErrorDialog(message: state.failure.message));
          } else if (state.status == ProfileStatus.logout_loaded) {
            progress!.dismiss();
            nextScreenRemoveUntil(context, SignInPage());
            context.read<PageCubit>().setPage(0);
          } else if (state.status == ProfileStatus.logout_loading) {
            progress!.showWithText('Loading...');
            progress.show();
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(title: "Lainnya"),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  infoProfile(state),
                  information(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _submitLogout(BuildContext context) async {
    String? userId = await pref.getUserId();
    String? userRole = await pref.getRoleUser();

    if (userRole == "warehouse staff") {
      print("Clear beems");
      await PusherBeams.instance.removeDeviceInterest('$userId');
      await PusherBeams.instance.clearDeviceInterests();
      await PusherBeams.instance.clearAllState();
      await PusherBeams.instance.stop();
    }

    context.read<ProfileBloc>().add(LogoutEvent());
  }
}
