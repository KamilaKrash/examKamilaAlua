part of "profile_page.dart";


class PhotoWidget extends StatefulWidget {
  const PhotoWidget({super.key});
  @override
  State<PhotoWidget> createState() => _PhotoWidgetState();
}

class _PhotoWidgetState extends State<PhotoWidget> {

  Future<Uint8List> loadImageFromSharedPreferences() async {
    try {
      String? base64Image = await StorageService.getString(key: 'image');
      if (base64Image != null) {
        return base64Decode(base64Image);
      } else {
        throw "null";  
      }
    } catch (e) {
      throw e.toString();
    }
  }

  late final Future<Uint8List> future = loadImageFromSharedPreferences();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: future, 
      builder:(context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          case ConnectionState.done:
            if (snapshot.hasError || !snapshot.hasData) {
              return const Icon(
                Icons.person,
                color: Colors.white,
              );
            } else {
              return Image.memory(
                snapshot.data!,
                width: 50,
                height: 50,
                fit: BoxFit.fill,
              );
            }
        }
      },
    );
  }
}
