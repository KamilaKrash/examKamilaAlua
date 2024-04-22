import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:application/screens/qr/qr_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:application/services/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';

class Utils {
  static showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  static String get getNewsApiKey => "a3b16ea239634110ad304d76d62224fd";

  static void disableScanner(currentIndex) async {
    try {
      if (currentIndex == 1) {
        QRScannerState.getController?.resumeCamera();
      } else {
        QRScannerState.getController?.pauseCamera();
      }
    } catch (e) {
      log(e.toString());
    }
  }


  static Future<File?> getImageFromGallery() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return null;
      return File(pickedFile.path);
    } catch (e) {
      rethrow;
    }
  }


  static Future<File?> takeImageFromCamera() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile == null) return null;
      File rotatedImage = await FlutterExifRotation.rotateImage(path: pickedFile.path);
      return File(rotatedImage.path);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> uploadImg(File imageFile, BuildContext context) async {
    final BuildContext contextt = context;
    try {
      contextt.loaderOverlay.show();

      List<int> imageBytes = await imageFile.readAsBytes();
      Uint8List uint8list = Uint8List.fromList(imageBytes);
      String base64Image = base64Encode(uint8list);

      await StorageService.setString(key: 'image', value: base64Image);

      if (contextt.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog.adaptive(
              title: const Text('Успешно'),
              content: const Text('Фото успешно загружено!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ок'),
                )
              ],
            );
          }
        );
      }
    } catch (e) {
      debugPrint("error at uploadImg");
    } finally {
      if (contextt.mounted) {
        contextt.loaderOverlay.hide();    
      }
    }
  }
}