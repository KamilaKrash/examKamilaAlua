part of "profile_page.dart";

class BuildUser extends StatelessWidget {
  final User? user;
  final List<PlatformUiSettings> uiSettings = [
    AndroidUiSettings(
        toolbarColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.square,
        lockAspectRatio: true),
    IOSUiSettings(
      resetAspectRatioEnabled: false,
      aspectRatioLockEnabled: true,
      doneButtonTitle: 'Готово',
      cancelButtonTitle: 'Отмена',
    ),
  ];

  Future showEditPicture(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (context) {
        return Container(
          height: 240,
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Text(
                      'Изменить фото профиля',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    iconSize: 15,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      CupertinoIcons.clear_circled_solid,
                      size: 30,
                    ),
                    color: Colors.grey[400],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                trailing: const Icon(CupertinoIcons.camera),
                title: Text(
                  'Сделать фото',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  )
                ),
                onTap: () async {
                  try {
                    var img = await Utils.takeImageFromCamera();
                    if (img == null) return;
                    await ImageCropper().cropImage(
                      aspectRatioPresets: [
                        CropAspectRatioPreset.square,
                      ],
                      sourcePath: img.path,
                      compressFormat: ImageCompressFormat.jpg,
                      compressQuality: 100,
                      aspectRatio: const CropAspectRatio(
                        ratioX: 1, 
                        ratioY: 1
                      ),
                      uiSettings: uiSettings,
                    ).then((value) async {
                      if (value == null) return;
                      await Utils.uploadImg(
                        File(value.path), 
                        context
                      )
                      .then((_) => context.read<ProfileBloc>().add(LoadUser()));
                    });
                  } catch (e) {
                    if (context.mounted) {
                      showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return AlertDialog.adaptive(
                            title: const Text('Ошибка'),
                            content: Text('Произошла ошибка: ${e.toString()}'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(dialogContext).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
              ),
              const Divider(
                height: 0,
              ),
              ListTile(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                trailing: const Icon(CupertinoIcons.photo),
                title: Text(
                  'Выбрать из галереи',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  )
                ),
                onTap: () async {
                  try {
                    var img = await Utils.getImageFromGallery();
                    if (img == null) return;
                    var croppedImg = await ImageCropper().cropImage(
                      aspectRatioPresets: [
                        CropAspectRatioPreset.square,
                      ],
                      sourcePath: img.path,
                      compressFormat: ImageCompressFormat.jpg,
                      compressQuality: 100,
                      aspectRatio: const CropAspectRatio(
                        ratioX: 1, 
                        ratioY: 1
                      ),
                      uiSettings: uiSettings,
                    );
                    if (croppedImg != null) {
                      if (context.mounted) {
                        await Utils.uploadImg(
                          File(
                            croppedImg.path),
                            context
                        ).then(
                          (value) => context.read<ProfileBloc>().add(LoadUser())
                        );
                      }
                    }
                  } catch (e) {
                    if (context.mounted) {
                      showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return AlertDialog.adaptive(
                            title: const Text('Ошибка'),
                            content: Text('Произошла ошибка: ${e.toString()}'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(dialogContext).pop(); 
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
              ),
            ],
          ),
        );
      });
  }

  BuildUser({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final users = user;
    return GestureDetector(
      onTap: () async => await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const EditProfile(),
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        padding: const EdgeInsets.only(left: 5, right: 5),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                showEditPicture(context);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.grey
                ),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: const PhotoWidget()
                  )
                )
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: users?.name ?? "Имя",
                        ),
                        const TextSpan(
                          text: " ",
                        ),
                        TextSpan(
                          text: users?.surname ?? "Фамилия",
                        ),  
                        const TextSpan(
                          text:"\n"
                        ),
                        const TextSpan(
                          text: 'Пользователь',
                          style: TextStyle(
                            color: Color.fromARGB(255, 103, 103, 103),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ), 
                      ],
                      style: const TextStyle(
                        color: Color.fromARGB(255, 41, 41, 41),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            IconButton(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerRight,
              icon: const Icon(
                Icons.edit,
                color: Colors.black,
                size: 20,
              ),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context)=> const EditProfile(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
