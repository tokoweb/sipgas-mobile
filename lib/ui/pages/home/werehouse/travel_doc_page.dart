part of '../../pages.dart';

class TravelDocPage extends StatefulWidget {
  const TravelDocPage({Key? key}) : super(key: key);

  @override
  _TravelDocPageState createState() => _TravelDocPageState();
}

class _TravelDocPageState extends State<TravelDocPage> {
  List<SubFilterResponse>? selectedFilterList = [];
  List<SubTravelDocResponse>? records = [];

  SharedPref pref = inject<SharedPref>();
  TravelDocBloc _travelDocBloc = inject<TravelDocBloc>();

  final PagingController<int, SubTravelDocResponse> _pagingController =
      PagingController(firstPageKey: 1);

  int totalRecordCount = 0;
  int currentPage = 1;
  String status = "progress";

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener(
      (pageKey) {
        if (selectedFilterList != null && selectedFilterList!.length > 0) {
          print("hit with filter $pageKey");
          var resultList = selectedFilterList?.map((e) => e.value).toList();
          _travelDocBloc.add(FetchTravelDocStatusEvent(
              status: status,
              records: records!,
              filterList: resultList!.toList(),
              page: pageKey,
              perPage: int.parse(StringConst.perPageCount)));
        } else {
          print("hit tanpa filter");
          _travelDocBloc.add(FetchTravelDocStatusEvent(
              status: status,
              records: records!,
              page: pageKey,
              perPage: int.parse(StringConst.perPageCount)));
        }
      },
    );
    _pagingController.refresh();
  }

  void loadData() {
    _pagingController.refresh();
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  goingToDetailPage(String id) async {
    context.read<TravelDocBloc>()..add(DeleteNoteTravelDocEvent());
    context.read<TravelDocBloc>()..add(DeleteAllListTubeTravelDoc());
    context.read<TravelDocBloc>().add(FetchTravelDocDetailEvent(id: id));
    pref.setTubeScanTravel(0);

    var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TravelDocDetailWerehousePage()));

    if (result != null) {
      loadData();
    }
  }

  void filterTravelDocAction(
      BuildContext context, TravelDocState state, int currentIndex) {
    showModalBottomSheet(
      context: context,
      backgroundColor: kTransparantColor,
      builder: (ctx) {
        return IntrinsicHeight(
          child: Container(
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            padding: EdgeInsets.only(bottom: 20),
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
                state.filters.listFilter != null
                    ? Container(
                        height: 160,
                        child: FilterListWidget<SubFilterResponse>(
                          themeData: FilterListThemeData(context),
                          hideSelectedTextCount: true,
                          hideHeader: true,
                          applyButtonText: "Simpan",
                          listData: state.filters.listFilter,
                          controlButtons: [],
                          selectedListData: selectedFilterList,
                          onApplyButtonClick: (list) {
                            setState(() {
                              selectedFilterList = List.from(list!);
                            });
                            _pagingController.refresh();
                            currentPage = 1;

                            Navigator.pop(context);
                          },
                          choiceChipLabel: (item) {
                            return item!.label!;
                          },
                          validateSelectedItem: (list, val) {
                            print("selected" + list!.toString());
                            selectedFilterList = List.from(list);
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
                SizedBox(height: 20),
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
    Widget travelDocType() {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            TravelDocType(
              index: 0,
              title: 'Berjalan',
              status: "progress",
              filterList: selectedFilterList,
              onTap: () {
                context.read<TravelDocTypeCubit>().setType(0);
                pref.setTravelDocStatus(0);
                status = "progress";
                currentPage = 1;
                _pagingController.refresh();
              },
            ),
            TravelDocType(
                index: 1,
                title: 'Selesai',
                status: "done",
                filterList: selectedFilterList,
                onTap: () {
                  context.read<TravelDocTypeCubit>().setType(1);
                  pref.setTravelDocStatus(1);
                  status = "done";
                  currentPage = 1;
                  _pagingController.refresh();
                })
          ],
        ),
      );
    }

    Widget listTravelDoc(TravelDocState state) {
      return Column(
        children: [
          state.travelDoc.listTravelDoc != null
              ? state.travelDoc.listTravelDoc!.length > 0
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: state.travelDoc.listTravelDoc!.length,
                        itemBuilder: (context, index) {
                          return TravelDocItem(
                            data: state.travelDoc.listTravelDoc![index],
                            function: () async {
                              context.read<TravelDocBloc>()
                                ..add(DeleteNoteTravelDocEvent());
                              context.read<TravelDocBloc>()
                                ..add(DeleteAllListTubeTravelDoc());
                              context.read<TravelDocBloc>().add(
                                  FetchTravelDocDetailEvent(
                                      id: state
                                          .travelDoc.listTravelDoc![index].id!
                                          .toString()));
                              pref.setTubeScanTravel(0);
                              nextScreen(
                                  context, TravelDocDetailWerehousePage());
                            },
                          );
                        },
                      ),
                    )
                  : Text(
                      "Data kosong",
                      style: greyFontStyle,
                    )
              : Center(child: CircularProgressIndicator(color: kPrimaryColor))
        ],
      );
    }

    Widget buildBuildListTravelDoc(TravelDocState state) {
      return Expanded(
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: marginPage),
            child: PagedListView<int, SubTravelDocResponse>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<SubTravelDocResponse>(
                itemBuilder: (context, time, index) => TravelDocItem(
                    data: time,
                    function: () => goingToDetailPage(time.id!.toString())),
                noItemsFoundIndicatorBuilder: (context) {
                  if (_pagingController.value.status ==
                      PagingStatus.completed) {
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
            )),
      );
    }

    return BlocProvider(
      create: (context) => _travelDocBloc..add(FetchFiltersEvent()),
      child: BlocConsumer<TravelDocBloc, TravelDocState>(
        listener: (context, state) {
          if (state.status == TravelDocStatus.error) {
            showDialog(
                context: context,
                builder: (context) =>
                    ErrorDialog(message: state.failure.message));
          } else if (state.status == TravelDocStatus.travel_doc_loaded) {
            try {
              print("Data ${state.travelDoc.listTravelDoc!}");
              records = state.travelDoc.listTravelDoc!;
              var offset = state.travelDoc.pagination!.lastPage;
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
          return BlocBuilder<TravelDocTypeCubit, int>(
            builder: (context, currentIndex) {
              return Scaffold(
                appBar: CustomAppbarTravel(
                  title: 'Surat Jalan',
                  filterFunction: () =>
                      filterTravelDocAction(context, state, currentIndex),
                  searchFunction: () =>
                      nextScreen(context, SearchTravelDocWerehousePage()),
                ),
                body: Column(
                  children: [
                    travelDocType(),
                    buildBuildListTravelDoc(state),
                    // listTravelDoc(state),
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
