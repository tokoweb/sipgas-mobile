part of '../pages.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void launchWhatsApp(ProfileState state) async {
      String url() {
        if (Platform.isAndroid) {
          return 'https://wa.me/${state.appSetting.whatsapp!}/?text=${Uri.parse("Hallo")}';
        } else {
          return 'https://api.whatsapp.com/send?phone=${state.appSetting.whatsapp!}=${Uri.parse("Hallo")}';
        }
      }

      if (await canLaunch(url())) {
        await launch(url());
      } else {
        throw 'Could not launch ${url()}';
      }
    }

    Widget body(ProfileState state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: SvgPicture.asset(
              "assets/icon/ic_back.svg",
              color: kWhiteColor,
              width: 20,
            ),
          ),
          Center(
            child: Container(
              height: 110.0,
              width: 115.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/icon/ic_logo_white.png"),
                ),
              ),
            ),
          ),
          SizedBox(height: 100),
          Text(
            'Reset password',
            style: whiteFontStyle.copyWith(
              fontWeight: bold,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Silahkan hubungi Admin untuk melakukan perubahan password.',
            style: whiteFontStyle.copyWith(
              fontWeight: regular,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 50),
          Center(
            child: GestureDetector(
              onTap: () => launchWhatsApp(state),
              child: Container(
                width: 200,
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: kYellowColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        child: SvgPicture.asset('assets/icon/ic_whatsapp.svg')),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Hubungi Admin',
                          style: blackFontStyle.copyWith(
                              fontSize: 14, fontWeight: regular),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg_login.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: kTransparantColor,
            body: ListView(
              children: [
                SafeArea(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: body(state),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
