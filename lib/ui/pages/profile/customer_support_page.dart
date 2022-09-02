part of '../pages.dart';

class CustomerSupportPage extends StatelessWidget {
  const CustomerSupportPage({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppbarDetail(title: 'Customer Support'),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => launchWhatsApp(state),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kYellowColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            child: SvgPicture.asset(
                                'assets/icon/ic_whatsapp.svg')),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Whatsapp customer support',
                              style: blackFontStyle.copyWith(
                                  fontSize: 14, fontWeight: regular),
                            ),
                          ),
                        ),
                        Container(width: 20)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
