part of '../widgets.dart';

class CustomTextArea extends StatelessWidget {
  final String? title;
  final String? description;
  const CustomTextArea(
      {Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
            title!,
            style: greyFontStyle.copyWith(fontSize: 12, fontWeight: regular),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
              border: Border.all(color: kPinkYoungColor),
              borderRadius: BorderRadius.circular(4.0)),
          child: Text(
            description!,
            style: blackFontStyle.copyWith(fontSize: 14, fontWeight: regular),
          ),
        ),
      ],
    );
  }
}
