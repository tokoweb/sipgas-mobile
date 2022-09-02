part of '../../pages.dart';

class MainDriverPage extends StatefulWidget {
  MainDriverPage({Key? key}) : super(key: key);

  @override
  State<MainDriverPage> createState() => _MainDriverPageState();
}

class _MainDriverPageState extends State<MainDriverPage> {
  SharedPref pref = inject<SharedPref>();

  @override
  Widget build(BuildContext context) {
    Widget buildContent(int currentIndex) {
      switch (currentIndex) {
        case 0:
          return InventoryDriverPage();
        case 1:
          context.read<TravelDocTypeCubit>().setType(0);
          pref.setTravelDocStatus(0);
          return TravelDocDriverPage();
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
                          width: 24, color: kYoungGreyColor)),
              label: "Surat Jalan",
            ),
            BottomNavigationBarItem(
              icon: Container(
                  margin: EdgeInsets.only(top: 0, bottom: 5),
                  child: context.read<PageCubit>().state == 2
                      ? SvgPicture.asset("assets/icon/ic_profile_active.svg",
                          width: 24, color: kPrimaryColor)
                      : SvgPicture.asset("assets/icon/ic_profile.svg",
                          width: 24, color: kYoungGreyColor)),
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
