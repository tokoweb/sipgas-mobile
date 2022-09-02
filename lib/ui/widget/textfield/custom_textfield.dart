part of '../widgets.dart';

class CustomTextField extends StatelessWidget {
  final String? textHint;
  final TextEditingController? controller;
  final GestureDetector? icon;
  final Function(String)? onChanged;
  final bool? obsecureText;
  final bool? isPassword;

  const CustomTextField({
    Key? key,
    this.textHint,
    this.controller,
    this.icon,
    this.onChanged,
    this.obsecureText,
    this.isPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: EdgeInsets.only(left: 20, right: (isPassword == true) ? 5 : 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: kWhiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            spreadRadius: 4,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: TextFormField(
        onChanged: (value) => onChanged,
        controller: controller,
        obscureText: obsecureText == true,
        
        decoration: InputDecoration(
          contentPadding: (isPassword == true) ? EdgeInsets.symmetric(vertical: 15.0) : EdgeInsets.zero,
          border: InputBorder.none,
          hintText: textHint,
          hintStyle: hintFontStyle.copyWith(fontSize: 14, fontWeight: regular),
          suffixIcon: icon,
        ),
      ),
    );
  }
}
