part of '../widgets.dart';

class ImagePickerItem extends StatelessWidget {
  final List<XFile>? listImage;
  final String imagePath;

  const ImagePickerItem(
      {Key? key,
      required this.imagePath,
      required this.listImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => nextScreen(
          context,
          ImageFullscreen(
            
            imagePath: imagePath,
            listImage: listImage,
          )),
      child: Container(
        width: 75,
        height: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: kPinkColor,
          border: Border.all(color: kPinkColor),
          image: DecorationImage(
            image: FileImage(File(imagePath)),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
