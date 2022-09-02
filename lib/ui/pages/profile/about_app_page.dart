part of '../pages.dart';

class AboutAppPage extends StatefulWidget {
  const AboutAppPage({Key? key}) : super(key: key);

  @override
  _AboutAppPageState createState() => _AboutAppPageState();
}

class _AboutAppPageState extends State<AboutAppPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppbarDetail(title: 'Tentang Aplikasi'),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: 140,
                      height: 140,
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/icon/ic_logo.png'),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 30, top: 10),
                      child: Column(
                        children: [
                          Text(
                            'Versi Aplikasi',
                            style: blackFontStyle.copyWith(
                              fontSize: 14,
                              fontWeight: semibold,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            '1.0.0',
                            style: navFontStyle.copyWith(
                              fontSize: 12,
                              fontWeight: regular,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Html(
                      data: "${state.appSetting.about!}",
                      style: {
                        "body": Style(
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.zero,
                          fontSize: FontSize(14.0),
                          lineHeight: LineHeight(1.4),
                          fontWeight: regular,
                        ),
                      },
                    ),
                    // Text(
                    //   '${state.appSetting.about}',
                    //   style: blackFontStyle.copyWith(
                    //       fontSize: 14, fontWeight: regular),
                    // ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
