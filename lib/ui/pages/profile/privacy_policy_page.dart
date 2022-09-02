part of '../pages.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppbarDetail(title: 'Kebijakan Privasi'),
          body: SingleChildScrollView(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              children: [
                Html(
                  data: "${state.appSetting.privacyPolicy!}",
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
              ],
            ),
          ),
        );
      },
    );
  }
}
