part of '../pages.dart';

class SearchStockTubePage extends StatefulWidget {
  const SearchStockTubePage({Key? key}) : super(key: key);

  @override
  _SearchStockTubePageState createState() => _SearchStockTubePageState();
}

class _SearchStockTubePageState extends State<SearchStockTubePage> {
  TubeBloc _tubeBloc = inject<TubeBloc>();

  goingToDetailPage(String serialNumber) async {
    context.read<TubeBloc>().add(FetchTubeDetailEvent(id: serialNumber));
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => TubeDetailPage()));
  }

  Widget getDataSearch(TubeState state) {
    if (state.status == TubeStatus.search_stock_tube_loaded) {
      if (state.searchStockTube.listTube != null) {
        if (state.searchStockTube.listTube!.length > 0) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: state.searchStockTube.listTube!.length,
                itemBuilder: (context, index) {
                  return StockTubeItem(
                      tubeData: state.searchStockTube.listTube![index],
                      onTap: () => goingToDetailPage(state
                          .searchStockTube.listTube![index].serialNumber!));
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
    } else if (state.status == TubeStatus.search_stock_tube_loading) {
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
                  context
                      .read<TubeBloc>()
                      .add(SearchStockTubeEvent(value: val));
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
