import 'package:chatting_app/Model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFireStoreService {
  CloudFireStoreService._();

  static CloudFireStoreService cloudFireStoreService =
      CloudFireStoreService._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> insertUserIntoFireStore(UserModel user) async {
    await fireStore.collection("users").doc(user.email).set({
      'name': user.name,
      'email': user.email,
      'image': user.image,
      'phone': user.phone,
      'token': user.token,
    });
  }
}

//collection(name) ka name hoga -> doc(id) ki id unique hoti he

//Collection : is a collection of multiple documents
//Document : Document hole information (Data - Map) or collection
