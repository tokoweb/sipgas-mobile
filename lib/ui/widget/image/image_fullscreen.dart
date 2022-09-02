part of '../widgets.dart';

class ImageFullscreen extends StatelessWidget {
 
  final List<XFile>? listImage;
  final String imagePath;

  const ImageFullscreen(
      {Key? key, required this.imagePath, this.listImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("List image nih ${listImage!.length}");
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
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(File(imagePath)),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        child: Center(
          child: GestureDetector(
            onTap: () => questionAlertDialog(
              context,
              "Hapus gambar",
              "Apakah anda ingin menghapus gambar ini?",
              () {
                listImage!.removeWhere((element) => element.path == imagePath);
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            child: SvgPicture.asset(
              'assets/icon/ic_trash.svg',
              width: 20,
              color: kWhiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
