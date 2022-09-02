part of '../pages.dart';

class TermConditionPage extends StatelessWidget {
  const TermConditionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppbarDetail(title: 'Syarat dan Ketentuan'),
          body: SingleChildScrollView(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              children: [
                Html(
                  data: "${state.appSetting.terms!}",
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
