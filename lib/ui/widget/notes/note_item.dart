part of '../widgets.dart';

class NoteItem extends StatelessWidget {
  final NotesData? data;
  const NoteItem({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          border: Border.all(color: kPinkYoungColor),
          borderRadius: BorderRadius.circular(4.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data != null && data!.userName != null ? data!.userName! : '',
            style: greyFontStyle.copyWith(fontSize: 14, fontWeight: regular),
          ),
          SizedBox(height: 4),
          Text(
            data != null && data!.note != null ? data!.note! : '',
            style: blackFontStyle.copyWith(fontSize: 14, fontWeight: regular),
          ),
        ],
      ),
    );
  }
}
