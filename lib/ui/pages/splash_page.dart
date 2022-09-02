part of 'pages.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SharedPref pref = inject<SharedPref>();

  Future _afterSplash() async {
    var loginStatus = await pref.getPrefLogin();
    var roleUser = await pref.getRoleUser();

    Future.delayed(Duration(milliseconds: 1500)).then((value) {
      print("Kevin" + roleUser.toString());

      if (loginStatus == 1) {
        if (roleUser == "warehouse staff") {
          _gotoHomePage();
        } else if (roleUser == "refill staff") {
          _gotoHomeFillingPage();
        } else if (roleUser == "driver staff") {
          _gotoHomeDriverPage();
        }
      } else {
        _gotoSignInPage();
      }
    });
  }

  void _gotoHomePage() {
    nextScreenRemoveUntil(context, MainPage());
  }

  void _gotoHomeFillingPage() {
    nextScreenRemoveUntil(context, MainFillingPage());
  }

  void _gotoHomeDriverPage() {
    nextScreenRemoveUntil(context, MainDriverPage());
  }

  void _gotoSignInPage() {
    nextScreenRemoveUntil(context, SignInPage());
  }

  @override
  void initState() {
    _afterSplash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 250),
                Image(
                  image: AssetImage('assets/icon/ic_logo.png'),
                  width: 200,
                ),
                SizedBox(height: 10),
                Text(
                  'Sistem Informasi Pencatatan Gas',
                  style: primaFontStyle.copyWith(
                    fontWeight: bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
