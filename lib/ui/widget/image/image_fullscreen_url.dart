part of '../widgets.dart';

class ImageFullscreenUrl extends StatelessWidget {
  final String urlImage;

  const ImageFullscreenUrl({
    Key? key,
    required this.urlImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kBlackColor,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: EdgeInsets.only(right: 20),
              child: Icon(Icons.close),
            ),
          )
        ],
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: 350,
          child: Image.network(
            urlImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
