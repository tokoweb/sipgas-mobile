part of '../../pages.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  SharedPref pref = inject<SharedPref>();

  @override
  initState() {
    super.initState();
    getSecure();
    initPusherBeams();
  }

  getSecure() async {
    await PusherBeams.instance.start(StringConst.beemsToken);
    var token = await pref.getTokenUser();
    String? userId = await pref.getUserId();

    if (userId != "") {
      final BeamsAuthProvider provider = BeamsAuthProvider()
        ..authUrl = '${ApiConstant.baseUrlDev}pusher/beams-auth'
        ..headers = {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token"
        }
        ..queryParams = {'page': '1'}
        ..credentials = 'omit';

      await PusherBeams.instance.setUserId(
        '${userId}',
        provider,
        (error) => {
          if (error != null) {print(error)}

          // Success! Do something...
        },
      );
    } else {
      print("Clear beems");
      await PusherBeams.instance.clearDeviceInterests();
    }
  }

  initPusherBeams() async {
    // Let's see our current interests
    print("Pusher ${await PusherBeams.instance.getDeviceInterests()}");

    // This is not intented to use in web
    if (!kIsWeb) {
      await PusherBeams.instance
          .onInterestChanges((interests) => {print('Interests: $interests')});

      await PusherBeams.instance
          .onMessageReceivedInTheForeground(_onMessageReceivedInTheForeground);
    }
  }

  void _onMessageReceivedInTheForeground(Map<Object?, Object?> data) {
    _showAlert(data["title"].toString(), data["body"].toString());
  }

  void _showAlert(String title, String message) {
    context.read<NotifBloc>().add(FetchSummaryNotifEvent());

    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      padding: EdgeInsets.all(20),
      messageColor: kWhiteColor,
      backgroundColor: Colors.green,
      title: title,
      message: message,
      icon: CircleAvatar(
          backgroundColor: kPrimaryColor,
          child: Icon(
            Icons.notifications_active,
            color: kWhiteColor,
          )),
      duration: Duration(seconds: 4),
    )..show(context);

    // AlertDialog alert = AlertDialog(
    //     title: Text(title), content: Text(message), actions: const []);
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return alert;
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    Widget buildContent(int currentIndex) {
      switch (currentIndex) {
        case 0:
          return InventoryPage();
        case 1:
          context.read<TravelDocTypeCubit>().setType(0);
          pref.setTravelDocStatus(0);
          return TravelDocPage();
        default:
          return ProfilePage();
      }
    }

    Widget bottomNav() {
      return BottomAppBar(
        child: BottomNavigationBar(
          backgroundColor: kWhiteColor,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            print(value);
            context.read<PageCubit>().setPage(value);
          },
          selectedLabelStyle: TextStyle(fontSize: 12),
          selectedItemColor: kPrimaryColor,
          currentIndex: context.read<PageCubit>().state,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(top: 0, bottom: 5),
                child: context.read<PageCubit>().state == 0
                    ? SvgPicture.asset("assets/icon/ic_inventory_active.svg",
                        width: 24, color: kPrimaryColor)
                    : SvgPicture.asset("assets/icon/ic_inventory.svg",
                        width: 24, color: kYoungGreyColor),
              ),
              label: "Inventaris",
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(top: 0, bottom: 5),
                child: context.read<PageCubit>().state == 1
                    ? SvgPicture.asset("assets/icon/ic_letter_active.svg",
                        width: 24, color: kPrimaryColor)
                    : SvgPicture.asset("assets/icon/ic_letter.svg",
                        width: 24, color: kYoungGreyColor),
              ),
              label: "Surat Jalan",
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(top: 0, bottom: 5),
                child: context.read<PageCubit>().state == 2
                    ? SvgPicture.asset("assets/icon/ic_profile_active.svg",
                        width: 24, color: kPrimaryColor)
                    : SvgPicture.asset("assets/icon/ic_profile.svg",
                        width: 24, color: kYoungGreyColor),
              ),
              label: "Lainnya",
            ),
          ],
        ),
      );
    }

    return BlocBuilder<PageCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          body: buildContent(currentIndex),
          bottomNavigationBar: bottomNav(),
        );
      },
    );
  }
}
