part of '../../pages.dart';

class LoadTubeDriverPage extends StatefulWidget {
  const LoadTubeDriverPage({Key? key}) : super(key: key);

  @override
  _LoadTubeDriverPageState createState() => _LoadTubeDriverPageState();
}

class _LoadTubeDriverPageState extends State<LoadTubeDriverPage> {
  final PagingController<int, SubTubeResponse> _pagingController =
      PagingController(firstPageKey: 1);
  SharedPref pref = inject<SharedPref>();

  List<SubTubeResponse>? records = [];
  TubeBloc _tubeBloc = inject<TubeBloc>();
  String status = "Terisi";
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _tubeBloc.add(
        FetchLoadTubeDriverByStatusEvent(
          status: status,
          page: pageKey,
        ),
      );
    });

    _pagingController.refresh();
  }

  goingToDetailPage(String serialNumber) async {
    context.read<TubeBloc>().add(FetchTubeDetailEvent(id: serialNumber));
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
            LoadTubeDriverType(
              index: 0,
              title: 'Terisi',
              status: "Terisi",
              onTap: () {
                pref.setLoadTubeDriverStatus(0);
                context.read<LoadTubeTypeDriverCubit>().setType(0);
                status = "Terisi";
                currentPage = 1;
                _pagingController.refresh();
              },
            ),
            LoadTubeDriverType(
              index: 1,
              title: 'Kosong',
              status: "Kosong",
              onTap: () {
                pref.setLoadTubeDriverStatus(1);
                context.read<LoadTubeTypeDriverCubit>().setType(1);
                status = "kosong";
                currentPage = 1;
                 _pagingController.refresh();
              },
            ),
          ],
        ),
      );
    }

    Widget listStock(TubeState state) {
      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            state.loadTubeDriver.listTube != null
                ? state.loadTubeDriver.listTube!.length > 0
                    ? Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: state.loadTubeDriver.listTube!.length,
                          itemBuilder: (context, index) {
                            return TubeItem(
                                tubeData:
                                    state.loadTubeDriver.listTube![index]);
                          },
                        ),
                      )
                    : Center(child: Text("Data Kosong"))
                : Center(child: CircularProgressIndicator())
          ],
        ),
      );
    }

    Widget buildBuildListLoadTube() {
      return Flexible(
        flex: 1,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: PagedListView<int, SubTubeResponse>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<SubTubeResponse>(
              itemBuilder: (context, time, index) => TubeItem(
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
        ),
      );
    }

    return BlocProvider(
      create: (context) => _tubeBloc,
      child: BlocBuilder<LoadTubeTypeDriverCubit, int>(
        builder: (context, currentIndex) {
          return BlocConsumer<TubeBloc, TubeState>(
            listener: (context, state) {
              if (state.status == TubeStatus.load_tube_driver_loaded) {
                try {
                  records = state.loadTubeDriver.listTube!;
                  var offset = state.loadTubeDriver.pagination!.lastPage;

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
                  title: 'Load Tabung',
                  iconFilter: false,
                  iconSearch: true,
                  filterFunction: () => filterTubeAction(context),
                  searchFunction: () =>
                      nextScreen(context, SearchLoadTubeDriverPage()),
                ),
                body: Column(
                  children: [
                    stockType(),
                    // listStock(state),
                    buildBuildListLoadTube()
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
