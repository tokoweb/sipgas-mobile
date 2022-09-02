part of '../../pages.dart';

class SearchLoadTubeDriverPage extends StatefulWidget {
  const SearchLoadTubeDriverPage({Key? key}) : super(key: key);

  @override
  _SearchLoadTubeDriverPageState createState() =>
      _SearchLoadTubeDriverPageState();
}

class _SearchLoadTubeDriverPageState extends State<SearchLoadTubeDriverPage> {
  TubeBloc _tubeBloc = inject<TubeBloc>();

  goingToDetailPage(String serialNumber) async {
    context.read<TubeBloc>().add(FetchTubeDetailEvent(id: serialNumber));
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => TubeDetailPage()));
  }

  Widget getDataSearch(TubeState state) {
    if (state.status == TubeStatus.search_load_tube_driver_loaded) {
      if (state.searchLoadTubeDriver.listTube != null) {
        if (state.searchLoadTubeDriver.listTube!.length > 0) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: state.searchLoadTubeDriver.listTube!.length,
                itemBuilder: (context, index) {
                  return TubeItem(
                    tubeData: state.searchLoadTubeDriver.listTube![index],
                    onTap: () => goingToDetailPage(state
                        .searchLoadTubeDriver.listTube![index].serialNumber!),
                  );
                }),
          );
        } else {
          return Container(
            child: Center(
              child: Text("Pencarian tidak ditemukan"),
            ),
          );
        }
      } else {
        return SizedBox();
      }
    } else if (state.status == TubeStatus.search_load_tube_driver_loading) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _tubeBloc,
      child: BlocConsumer<TubeBloc, TubeState>(
        listener: (context, state) {
          print("state status load ${state.status}");
        },
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppbarSearch(
              widgetSearch: TextFormField(
                cursorColor: kBlackColor,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 6.0),
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search, color: kBlackColor),
                ),
                onChanged: (val) {
                  context
                      .read<TubeBloc>()
                      .add(SearchLoadTubeDriverEvent(value: val));
                },
              ),
            ),
            body: getDataSearch(state),
          );
        },
      ),
    );
  }
}
