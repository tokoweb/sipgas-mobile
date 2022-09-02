part of '../pages.dart';

class StockTubePage extends StatefulWidget {
  const StockTubePage({Key? key}) : super(key: key);

  @override
  _StockTubePageState createState() => _StockTubePageState();
}

class _StockTubePageState extends State<StockTubePage> {
  List<SubFiltersTubeResponse>? selectedFilterCategoriesList = [];

  List<SubFiltersTubeResponse>? selectedFilterStatusList = [];
  final PagingController<int, SubTubeResponse> _pagingController =
      PagingController(firstPageKey: 1);
  SharedPref pref = inject<SharedPref>();

  List<SubTubeResponse>? records = [];
  TubeBloc _tubeBloc = inject<TubeBloc>();
  String status = "in-house";
  int currentPage = 1;

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener(
      (pageKey) {
        if (selectedFilterCategoriesList != null &&
            selectedFilterCategoriesList!.length > 0) {
          print("hit with filter $pageKey");
          var resultCategoriesList =
              selectedFilterCategoriesList?.map((e) => e.value).toList();

          List<String>? statusFilter;
          if (selectedFilterStatusList != null &&
              selectedFilterStatusList!.length > 0) {
            var resultStatusSelected =
                selectedFilterStatusList?.map((e) => e.label!).toList();
            statusFilter = resultStatusSelected;
          }
          print("status filter $statusFilter");

          _tubeBloc.add(FetchStockTubeByStatusEvent(
            status: status,
            page: pageKey,
            filterCategoryList: resultCategoriesList!,
            filterStatusList: statusFilter,
          ));
        } else if (selectedFilterStatusList != null &&
            selectedFilterStatusList!.length > 0) {
          print("hit with status");
          var resultStatusSelected =
              selectedFilterStatusList?.map((e) => e.label!).toList();
          _tubeBloc.add(FetchStockTubeByStatusEvent(
            status: status,
            page: pageKey,
            filterStatusList: resultStatusSelected,
          ));
        } else {
          print("hit tanpa filter");
          _tubeBloc
              .add(FetchStockTubeByStatusEvent(status: status, page: pageKey));
        }
      },
    );
    _pagingController.refresh();
  }

  void loadData() {
    _pagingController.refresh();
  }

  goingToDetailPage(String serialNumber) async {
    context.read<TubeBloc>().add(FetchTubeDetailEvent(id: serialNumber));

    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => TubeDetailPage()));

    if (result != null) {
      loadData();
    }
  }

  void filterTubeAction(BuildContext context, TubeState state) {
    showModalBottomSheet(
      context: context,
      backgroundColor: kTransparantColor,
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          padding: EdgeInsets.only(bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 15, horizontal: marginPage),
                  child: Row(
                    children: [
                      Container(width: 20),
                      Expanded(
                        child: Center(
                          child: Text(
                            "Filter",
                            style: blackFontStyle.copyWith(
                                fontSize: 15, fontWeight: bold),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _pagingController.refresh();
                          currentPage = 1;
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close, size: 20),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: marginPage, right: marginPage),
                  child: Text(
                    'Kategori tabung',
                    style: blackFontStyle.copyWith(
                        fontSize: 14, fontWeight: regular),
                  ),
                ),
                state.filtersTube.listCategories != null
                    ? Container(
                        height: 200,
                        child: FilterListWidget<SubFiltersTubeResponse>(
                          themeData: FilterListThemeData(context),
                          hideSelectedTextCount: true,
                          hideHeader: true,
                          applyButtonText: "Simpan",
                          listData: state.filtersTube.listCategories,
                          controlButtons: [],
                          selectedListData: selectedFilterCategoriesList,
                          onApplyButtonClick: (list) {
                            setState(() {
                              selectedFilterCategoriesList = List.from(list!);
                            });
                            _pagingController.refresh();
                            currentPage = 1;

                            Navigator.pop(context);
                          },
                          choiceChipLabel: (item) {
                            return item!.label!;
                          },
                          validateSelectedItem: (list, val) {
                            print("selected categories" + list!.toString());
                            selectedFilterCategoriesList = List.from(list);
                            return list.contains(val);
                          },
                          onItemSearch: (user, query) {
                            return user.label!
                                .toLowerCase()
                                .contains(query.toLowerCase());
                          },
                          choiceChipBuilder: (context, item, isSelected) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color:
                                    isSelected! ? kPrimaryColor : kWhiteColor,
                                border: Border.all(
                                  color:
                                      isSelected ? kPrimaryColor : kPinkColor,
                                ),
                              ),
                              child: Text(item.label,
                                  style: isSelected
                                      ? whiteFontStyle.copyWith(
                                          fontSize: 14, fontWeight: regular)
                                      : blackFontStyle.copyWith(
                                          fontSize: 14, fontWeight: medium)),
                            );
                          },
                        ),
                      )
                    : SizedBox(),
                Container(
                  margin: EdgeInsets.only(
                      left: marginPage, right: marginPage, top: 10),
                  child: Text(
                    'Status tabung',
                    style: blackFontStyle.copyWith(
                        fontSize: 14, fontWeight: regular),
                  ),
                ),
                state.filtersTube.listStatus != null
                    ? Container(
                        height: 200,
                        child: FilterListWidget<SubFiltersTubeResponse>(
                          themeData: FilterListThemeData(context),
                          hideSelectedTextCount: true,
                          hideHeader: true,
                          applyButtonText: "Simpan",
                          listData: state.filtersTube.listStatus,
                          controlButtons: [],
                          selectedListData: selectedFilterStatusList,
                          onApplyButtonClick: (list) {
                            setState(() {
                              selectedFilterStatusList = List.from(list!);
                            });
                            _pagingController.refresh();
                            currentPage = 1;

                            Navigator.pop(context);
                          },
                          choiceChipLabel: (item) {
                            return item!.label!;
                          },
                          validateSelectedItem: (list, val) {
                            print("selected status" + list!.toString());
                            selectedFilterStatusList = List.from(list);
                            return list.contains(val);
                          },
                          onItemSearch: (user, query) {
                            return user.label!
                                .toLowerCase()
                                .contains(query.toLowerCase());
                          },
                          choiceChipBuilder: (context, item, isSelected) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color:
                                    isSelected! ? kPrimaryColor : kWhiteColor,
                                border: Border.all(
                                  color:
                                      isSelected ? kPrimaryColor : kPinkColor,
                                ),
                              ),
                              child: Text(item.label,
                                  style: isSelected
                                      ? whiteFontStyle.copyWith(
                                          fontSize: 14, fontWeight: regular)
                                      : blackFontStyle.copyWith(
                                          fontSize: 14, fontWeight: medium)),
                            );
                          },
                        ),
                      )
                    : SizedBox(),
                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 120),
                  child: ButtonPrimary(
                    title: "Simpan",
                    onTap: () {
                      _pagingController.refresh();
                      currentPage = 1;
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget stockType() {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            StockTubeType(
              index: 0,
              title: 'Tabung di gudang',
              status: "in-house",
              onTap: () {
                pref.setStockTubeStatus(0);
                context.read<StockTubeTypeCubit>().setType(0);
                currentPage = 1;

                status = "in-house";
                _pagingController.refresh();
              },
            ),
            StockTubeType(
              index: 1,
              title: 'Tabung diluar gudang',
              status: "outside",
              onTap: () {
                pref.setStockTubeStatus(1);
                context.read<StockTubeTypeCubit>().setType(1);
                currentPage = 1;

                status = "outside";
                _pagingController.refresh();
              },
            )
          ],
        ),
      );
    }

    Widget buildBuildListStockTube(TubeState state) {
      return Flexible(
        flex: 1,
        child: PagedListView<int, SubTubeResponse>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<SubTubeResponse>(
            itemBuilder: (context, time, index) => StockTubeItem(
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
      create: (context) => _tubeBloc..add(FetchFiltersTubeEvent()),
      child: BlocBuilder<StockTubeTypeCubit, int>(
        builder: (context, currentIndex) {
          return BlocConsumer<TubeBloc, TubeState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state.status == TubeStatus.stock_tube_loaded) {
                try {
                  records = state.stockTube.listTube!;
                  var offset = state.stockTube.pagination!.lastPage;

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
              print("status ${selectedFilterStatusList}");
              return Scaffold(
                appBar: CustomAppbarIcon(
                  title: 'Stok Tabung',
                  iconFilter: true,
                  iconSearch: true,
                  filterFunction: () => filterTubeAction(context, state),
                  searchFunction: () =>
                      nextScreen(context, SearchStockTubePage()),
                ),
                body: Column(
                  children: [
                    stockType(),
                    buildBuildListStockTube(state),
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
