part of '../widgets.dart';

class CustomTextFieldBorder extends StatelessWidget {
  final String? title;
  final String? hintText;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final bool? isReadonly;

  const CustomTextFieldBorder(
      {Key? key,
      required this.title,
      this.hintText,
      this.inputType,
      this.controller,
      this.onChanged, required this.isReadonly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
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
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              border: Border.all(color: kPinkYoungColor),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: TextFormField(
              keyboardType: inputType,
              onChanged: (value) => onChanged,
              controller: controller,
              readOnly: isReadonly!,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle:
                    blackFontStyle.copyWith(fontSize: 14, fontWeight: regular),
              ),
            ),
          )
        ],
      ),
    );
  }
}
