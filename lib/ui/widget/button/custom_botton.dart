part of '../widgets.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final Color? color;
  final Function()? function;
  const CustomButton(
      {Key? key,
      required this.title,
      required this.color,
      required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title!,
            style: blackFontStyle.copyWith(fontSize: 14, fontWeight: regular),
          ),
        ),
      ),
    );
  }
}
