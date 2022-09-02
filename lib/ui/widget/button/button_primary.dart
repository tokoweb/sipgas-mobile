part of '../widgets.dart';

class ButtonPrimary extends StatelessWidget {
  final String title;
  final Function() onTap;
  final EdgeInsets? margin;
  final Color? color;
  final bool isLoading;

  ButtonPrimary({
    Key? key,
    required this.title,
    required this.onTap,
    this.color,
    this.margin,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin != null ? margin : EdgeInsets.zero,
      child: TextButton(
        style: ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: MaterialStateProperty.all(Size(double.infinity, 42)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
            backgroundColor: MaterialStateProperty.all(
                color == null ? kPrimaryColor : color)),
        onPressed: onTap,
        child: Container(
          child: Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLoading) ...[
                  Container(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
                Text(
                  title,
                  style: color == null ? whiteFontStyle : blackFontStyle,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
