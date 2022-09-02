part of '../widgets.dart';

class StockTubeType extends StatelessWidget {
  final index;
  final title;
  final status;
  final Function()? onTap;

  const StockTubeType(
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
                    bottom: context.read<StockTubeTypeCubit>().state == index
                        ? 19
                        : 21),
                child: Text(
                  title,
                  style: context.read<StockTubeTypeCubit>().state == index
                      ? blackFontStyle.copyWith(fontSize: 14, fontWeight: bold)
                      : greyFontStyle.copyWith(
                          fontSize: 14, fontWeight: regular),
                ),
              ),
              Container(
                height:
                    context.read<StockTubeTypeCubit>().state == index ? 4 : 2,
                color: context.read<StockTubeTypeCubit>().state == index
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
