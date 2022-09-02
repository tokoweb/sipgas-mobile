part of '../../pages.dart';

class StockTubeFillingPage extends StatefulWidget {
  const StockTubeFillingPage({Key? key}) : super(key: key);

  @override
  _StockTubeFillingPageState createState() => _StockTubeFillingPageState();
}

class _StockTubeFillingPageState extends State<StockTubeFillingPage> {
  TubeBloc _tubeBloc = inject<TubeBloc>();

  List<SubTubeResponse>? records = [];
  final PagingController<int, SubTubeResponse> _pagingController =
      PagingController(firstPageKey: 1);
  int currentPage = 1;

  SharedPref pref = inject<SharedPref>();
  String status = "Terisi";

  @override
  void initState() {
    //*so at event add list of records
    _pagingController.addPageRequestListener(
      (pageKey) {
        print("hit $pageKey");
        _tubeBloc.add(FetchStockTubeFillingStafByStatusEvent(
            status: status, page: pageKey));
      },
    );
    super.initState();
    _pagingController.refresh();
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  goingToDetailPage(String id) async {
    context.read<TubeBloc>().add(FetchTubeDetailEvent(id: id));
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => TubeDetailPage()));
  }

  @override
  Widget build(BuildContext context) {
    Widget stockType() {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            StockTubeFillingType(
              index: 0,
              title: 'Terisi',
              status: "Terisi",
              onTap: () {
                pref.setStockTubeFillingStafStatus(0);
                context.read<StockTubeTypeFillingStafCubit>().setType(0);
                currentPage = 1;
                status = "Terisi";
                _pagingController.refresh();
              },
            ),
            StockTubeFillingType(
              index: 1,
              title: 'Kosong',
              status: "Kosong",
              onTap: () {
                pref.setStockTubeFillingStafStatus(1);
                context.read<StockTubeTypeFillingStafCubit>().setType(1);
                currentPage = 1;
                status = "Kosong";
                _pagingController.refresh();
              },
            )
          ],
        ),
      );
    }

    Widget listStock(TubeState state, int index) {
      return Column(
        children: [
          state.stockTubeFillingStaf.listTube != null
              ? state.stockTubeFillingStaf.listTube!.length > 0
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: state.stockTubeFillingStaf.listTube!.length,
                      itemBuilder: (context, index) {
                        return StockTubeFillingItem(
                          tubeData: state.stockTubeFillingStaf.listTube![index],
                        );
                      },
                    )
                  : Text("Data Kosong")
              : Center(child: CircularProgressIndicator())
        ],
      );
    }

    Widget buildBuildListStockTube() {
      return Flexible(
        flex: 1,
        child: PagedListView<int, SubTubeResponse>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<SubTubeResponse>(
            itemBuilder: (context, time, index) => StockTubeFillingItem(
              tubeData: time,
              onTap: () => goingToDetailPage(time.serialNumber!),
            ),
            noItemsFoundIndicatorBuilder: (context) {
              if (_pagingController.value.status == PagingStatus.completed) {
                if (_pagingController.value.itemList!.isNotEmpty) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Center(
                    child: Text("Data Kosong"),
                  );
                }
              } else if (_pagingController.value.status ==
                  PagingStatus.noItemsFound) {
                return Center(
                  child: Text("Data Kosong"),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      );
    }

    return BlocProvider(
      create: (context) => _tubeBloc,
      child: BlocBuilder<StockTubeTypeFillingStafCubit, int>(
        builder: (context, currentIndex) {
          return BlocConsumer<TubeBloc, TubeState>(
            listener: (context, state) {
              if (state.status == TubeStatus.stock_tube_filling_staf_loaded) {
                try {
                  records = state.stockTubeFillingStaf.listTube!;
                  var offset = state.stockTubeFillingStaf.pagination!.lastPage;

                  final isLastPage = currentPage == offset;
                  print("Current Page $currentPage, offset $offset");

                  if (isLastPage) {
                    _pagingController.appendLastPage(records!);
                  } else {
                    currentPage++;
                    _pagingController.appendPage(records!, currentPage);
                  }
                } catch (e) {
                  print("error $e");
                }
              }
            },
            builder: (context, state) {
              return Scaffold(
                appBar: CustomAppbarIcon(
                  title: 'Stok Tabung',
                  iconFilter: false,
                  iconSearch: true,
                  filterFunction: () => filterTubeAction(context),
                  searchFunction: () =>
                      nextScreen(context, SearchStockTubeFillingStafPage()),
                ),
                body: Column(
                  children: [
                    stockType(),
                    // listStock(state, currentIndex),
                    buildBuildListStockTube()
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
