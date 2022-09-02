part of '../pages.dart';

class LoadTubePage extends StatefulWidget {
  const LoadTubePage({Key? key}) : super(key: key);

  @override
  State<LoadTubePage> createState() => _LoadTubePageState();
}

class _LoadTubePageState extends State<LoadTubePage> {
  TubeBloc _tubeBloc = inject<TubeBloc>();

  List<SubTubeResponse> records = [];
  final PagingController<int, SubTubeResponse> _pagingController =
      PagingController(firstPageKey: 1);

  int totalRecordCount = 0;
  int currentPage = 1;

  @override
  void initState() {
    //*so at event add list of records
    _pagingController.addPageRequestListener(
      (pageKey) {
        print("hit $pageKey");
        _tubeBloc.add(
            FetchLoadTubeEvent(records: records, page: pageKey, perPage: 10));
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  void loadData() {
    _pagingController.refresh();
  }

  goingToDetailPage(String id) async {
    context.read<TubeBloc>().add(FetchTubeDetailEvent(id: id));

    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => TubeDetailPage()));

    if (result != null) {
      loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget listLoadTube(TubeState state) {
      return Container(
        margin: EdgeInsets.all(20),
        child: PagedListView<int, SubTubeResponse>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<SubTubeResponse>(
            itemBuilder: (context, time, index) => TubeItem(
                tubeData: time,
                onTap: () {
                  goingToDetailPage(time.serialNumber!);
                }),
            noItemsFoundIndicatorBuilder: (context) {
              if (_pagingController.value.status == PagingStatus.completed) {
                if (_pagingController.value.itemList!.isNotEmpty) {
                  return Center(
                      child: CircularProgressIndicator(color: kPrimaryColor));
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
                  child: CircularProgressIndicator(color: kPrimaryColor),
                );
              }
            },
          ),
        ),
      );
    }

    return BlocProvider(
      create: (context) => _tubeBloc,
      child: BlocConsumer<TubeBloc, TubeState>(
        listener: (context, state) {
          print("state status = ${state.status}");

          if (state.status == TubeStatus.load_tube_loaded) {
            try {
              records = state.loadTube.listTube!;
              var offset = state.loadTube.pagination!.lastPage;
              final isLastPage = currentPage == offset;
              print("Current Page  $currentPage");
              if (isLastPage) {
                _pagingController.appendLastPage(records);
              } else {
                currentPage++;
                _pagingController.appendPage(records, currentPage);
              }
            } catch (e) {
              print("error $e");
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: CustomAppbarIcon(
                title: 'Load Tabung',
                iconFilter: false,
                iconSearch: true,
                filterFunction: () => filterTubeAction(context),
                searchFunction: () => nextScreen(context, SearchLoadTubePage()),
              ),
              body: listLoadTube(state)

              // SingleChildScrollView(
              //   padding: EdgeInsets.all(20),
              //   child: Column(
              //     children: [
              //       listLoadTube(state),
              //       // TubeItem(),
              //     ],
              //   ),
              // ),
              );
        },
      ),
    );
  }
}
