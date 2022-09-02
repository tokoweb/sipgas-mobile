part of '../widgets.dart';

Widget alertLoginError(BuildContext context, String msg) {
  return Flushbar(
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
    padding: EdgeInsets.all(20),
    messageColor: kBlackColor,
    backgroundColor: kWhiteColor,
    borderRadius: BorderRadius.circular(10),
    message: msg,
    icon: CircleAvatar(
        backgroundColor: kPrimaryColor,
        child: Icon(
          Icons.close,
          color: kWhiteColor,
        )),
    duration: Duration(seconds: 2),
  )..show(context);
}
