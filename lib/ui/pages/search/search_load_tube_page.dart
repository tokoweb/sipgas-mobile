part of '../pages.dart';

class SearchLoadTubePage extends StatefulWidget {
  const SearchLoadTubePage({Key? key}) : super(key: key);

  @override
  _SearchLoadTubePageState createState() => _SearchLoadTubePageState();
}

class _SearchLoadTubePageState extends State<SearchLoadTubePage> {
  TubeBloc _tubeBloc = inject<TubeBloc>();

  goingToDetailPage(String serialNumber) async {
    context.read<TubeBloc>().add(FetchTubeDetailEvent(id: serialNumber));

    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => TubeDetailPage()));
  }

  Widget getDataSearch(TubeState state) {
    if (state.status == TubeStatus.search_load_tube_loaded) {
      if (state.searchLoadTube.listTube != null) {
        if (state.searchLoadTube.listTube!.length > 0) {
          return Container(
            margin: EdgeInsets.all(20),
            child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: state.searchLoadTube.listTube!.length,
                itemBuilder: (context, index) {
                  return TubeItem(
                    tubeData: state.searchLoadTube.listTube![index],
                    onTap: () => goingToDetailPage(
                        state.searchLoadTube.listTube![index].serialNumber!),
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
    } else if (state.status == TubeStatus.search_load_tube_loading) {
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
        listener: (context, state) {},
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
                  context.read<TubeBloc>().add(SearchLoadTubeEvent(value: val));
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
