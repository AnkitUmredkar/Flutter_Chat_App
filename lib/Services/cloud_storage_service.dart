import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class CloudStorageService{
  CloudStorageService._();
  static CloudStorageService cloudStorageService = CloudStorageService._();

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadChatImage() async {
    XFile? xFileImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    final storageRef  = FirebaseStorage.instance.ref();
    final imageReference = storageRef.child("images/${xFileImage!.name}");
    await imageReference.putFile(File(xFileImage.path));
    String url = await imageReference.getDownloadURL();
    return url;
  }

  Future<String> updateProfilePhoto() async {
    XFile? xFileImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    final storageRef  = FirebaseStorage.instance.ref();
    final imageReference = storageRef.child("profileImage/${xFileImage!.name}");
    await imageReference.putFile(File(xFileImage.path));
    String url = await imageReference.getDownloadURL();
    return url;
  }
}