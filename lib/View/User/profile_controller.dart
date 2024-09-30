import 'package:get/get.dart';
import '../../Services/cloud_firestore_service.dart';

class ProfileController extends GetxController {
  RxString image = "".obs;

  void getImage(String url,String currentUserEmail) {
    image.value = url;
    CloudFireStoreService.cloudFireStoreService.updateProfilePhoto(currentUserEmail, url);
  }
}