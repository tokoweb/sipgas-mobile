part of '../pages.dart';

class SearchTravelDocDriverPage extends StatefulWidget {
  const SearchTravelDocDriverPage({Key? key}) : super(key: key);

  @override
  _SearchTravelDocDriverPageState createState() =>
      _SearchTravelDocDriverPageState();
}

class _SearchTravelDocDriverPageState
    extends State<SearchTravelDocDriverPage> {
  TravelDocBloc _travelDocBloc = inject<TravelDocBloc>();

  goingToDetailPage(String id) async {
    context.read<TravelDocBloc>().add(FetchTravelDocDetailEvent(id: id));

    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TravelDocDetailDriverPage()));
  }

  Widget getDataSearch(TravelDocState state) {
    if (state.status == TravelDocStatus.travel_doc_search_loaded) {
      if (state.searchTravelDoc.listTravelDoc != null) {
        if (state.searchTravelDoc.listTravelDoc!.length > 0) {
          return Container(
            margin: EdgeInsets.all(20),
            child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: state.searchTravelDoc.listTravelDoc!.length,
                itemBuilder: (context, index) {
                  return TravelDocItem(
                    data: state.searchTravelDoc.listTravelDoc![index],
                    function: () => goingToDetailPage(state
                        .searchTravelDoc.listTravelDoc![index].id!
                        .toString()),
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
    } else if (state.status == TravelDocStatus.loading) {
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
      create: (context) => _travelDocBloc,
      child: BlocConsumer<TravelDocBloc, TravelDocState>(
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
                      .read<TravelDocBloc>()
                      .add(SearchTravelDocEvent(value: val));
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
