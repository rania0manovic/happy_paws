import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageHelper {
  static Future<dynamic> pickImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? selectedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      try {
        File imageFile = File(selectedImage.path);
        return {
          'selectedImage': imageFile,
        };
      } catch (e) {
        rethrow;
      }
    }
  }

  static Future<dynamic> addImage(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("images/$fileName");
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      return {'downloadUrl': downloadURL};
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> updateImage(File imageFile, String downloadUrl) async {
    try {
      /*
        NOTE: Update should not be executed in the testing environments because it's essential not to change seed data URLs. 
        Uncomment the code below only in production env!
       */
      // FirebaseStorage storage = FirebaseStorage.instance;
      // Reference ref = storage.refFromURL(downloadUrl);
      // UploadTask uploadTask = ref.putFile(imageFile);
      // TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
      // String newDownloadURL = await taskSnapshot.ref.getDownloadURL();
      // return {'downloadUrl': newDownloadURL};
      return addImage(imageFile);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> removeImage(String downloadUrl) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.refFromURL(downloadUrl);
      await ref.delete();
    } catch (e) {
      rethrow;
    }
  }
}
