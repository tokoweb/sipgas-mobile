part of '../pages.dart';

class SearchStockTubeFillingStafPage extends StatefulWidget {
  const SearchStockTubeFillingStafPage({Key? key}) : super(key: key);

  @override
  _SearchStockTubeFillingStafPageState createState() =>
      _SearchStockTubeFillingStafPageState();
}

class _SearchStockTubeFillingStafPageState
    extends State<SearchStockTubeFillingStafPage> {
  TubeBloc _tubeBloc = inject<TubeBloc>();

  goingToDetailPage(String serialNumber) async {
    context.read<TubeBloc>().add(FetchTubeDetailEvent(id: serialNumber));

    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => TubeDetailPage()));
  }

  Widget getDataSearch(TubeState state) {
    if (state.status == TubeStatus.search_stock_tube_filling_staf_loaded) {
      if (state.searchStockTubeFilling.listTube != null) {
        if (state.searchStockTubeFilling.listTube!.length > 0) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: state.searchStockTubeFilling.listTube!.length,
                itemBuilder: (context, index) {
                  return StockTubeFillingItem(
                      tubeData: state.searchStockTubeFilling.listTube![index],
                      onTap: () => goingToDetailPage(state
                          .searchStockTubeFilling
                          .listTube![index]
                          .serialNumber!));
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
    } else if (state.status ==
        TubeStatus.search_stok_tube_filling_staf_loading) {
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
                      .add(SearchStockTubeFillingStafEvent(value: val));
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
