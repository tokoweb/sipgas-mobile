part of '../widgets.dart';

class StockTubeFillingType extends StatelessWidget {
  final index;
  final title;
  final status;
  final Function()? onTap;

  const StockTubeFillingType(
      {Key? key,
      required this.index,
      required this.title,
      this.status,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    bottom:
                        context.read<StockTubeTypeFillingStafCubit>().state ==
                                index
                            ? 19
                            : 21),
                child: Text(
                  title,
                  style: context.read<StockTubeTypeFillingStafCubit>().state ==
                          index
                      ? blackFontStyle.copyWith(fontSize: 14, fontWeight: bold)
                      : greyFontStyle.copyWith(
                          fontSize: 14, fontWeight: regular),
                ),
              ),
              Container(
                height:
                    context.read<StockTubeTypeFillingStafCubit>().state == index
                        ? 4
                        : 2,
                color:
                    context.read<StockTubeTypeFillingStafCubit>().state == index
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
