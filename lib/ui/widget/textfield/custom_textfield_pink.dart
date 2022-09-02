part of '../widgets.dart';

class CustomTextFieldPink extends StatelessWidget {
  final String? title;
  final String? textHint;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final int? maxlines;
  final Function(String)? onChanged;
  final bool? isPassword;

  const CustomTextFieldPink(
      {Key? key,
      required this.title,
      this.textHint,
      this.inputType,
      this.controller,
      this.maxlines,
      this.onChanged,
      this.isPassword})
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
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0), color: kPinkYoungColor),
          child: TextFormField(
            obscureText: isPassword == true ? true : false,
            keyboardType: inputType,
            onChanged: (value) => onChanged,
            controller: controller,
            maxLines: maxlines != null ? maxlines : 1,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: textHint,
              hintStyle:
                  hintFontStyle.copyWith(fontSize: 14, fontWeight: regular),
            ),
          ),
        ),
      ],
    );
  }
}
