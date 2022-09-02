part of '../widgets.dart';

class TravelDocType extends StatelessWidget {
  final index;
  final title;
  final status;
  final Function()? onTap;
  final List<SubFilterResponse>? filterList;

  const TravelDocType(
      {Key? key,
      required this.index,
      required this.title,
      this.onTap,
      this.status,
      this.filterList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SharedPref pref = inject<SharedPref>();

    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: GestureDetector(
        onTap: onTap,
        // () async {
        //   // var resultList = filterList?.map((e) => e.value).toList();
        //   context.read<TravelDocTypeCubit>().setType(index);
        //   pref.setTravelDocStatus(index);

        //   // if (resultList != null && resultList.length > 0) {
        //   //   context.read<TravelDocBloc>().add(FetchTravelDocStatusEvent(
        //   //       status: status, filterList: resultList.toList()));
        //   // } else {
        //   //   context.read<TravelDocBloc>().add(
        //   //       FetchTravelDocStatusEvent(status: status, filterList: null));
        //   // }
        // },
        child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    bottom: context.read<TravelDocTypeCubit>().state == index
                        ? 19
                        : 21),
                child: Text(
                  title,
                  style: context.read<TravelDocTypeCubit>().state == index
                      ? blackFontStyle.copyWith(fontSize: 14, fontWeight: bold)
                      : greyFontStyle.copyWith(
                          fontSize: 14, fontWeight: regular),
                ),
              ),
              Container(
                height:
                    context.read<TravelDocTypeCubit>().state == index ? 4 : 2,
                color: context.read<TravelDocTypeCubit>().state == index
                    ? kRedColor
                    : kYoungGreyColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
