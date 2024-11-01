import 'package:chatting_app/Model/user_model.dart';
import 'package:chatting_app/Services/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../global.dart';

class CloudFireStoreService {
  CloudFireStoreService._();
 // static UserModel? currentUser;
  static CloudFireStoreService cloudFireStoreService =
      CloudFireStoreService._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  //todo insert user in fire store
  Future<void> insertUserIntoFireStore(UserModel user) async {
    await fireStore.collection("users").doc(user.email).set({
      'name': user.name,
      'email': user.email,
      'image': user.image,
      'phone': user.phone,
      'token': user.token,
      'isOnline': user.isOnline,
      'isTyping': user.isTyping,
      'timestamp': user.timestamp,
      'about': user.about,
    });
  }

  //todo get all user from fire store
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsersFromFireStore() {
    String currentUserEmail = AuthService.authService.getCurrentUser()!.email!;
    return fireStore.collection("users").where("email", isNotEqualTo: currentUserEmail).snapshots();
  }

  //todo get currentUser from fireStore
  Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentUserFromFireStore() {
    String currentUserEmail = AuthService.authService.getCurrentUser()!.email!;
    return fireStore.collection("users").doc(currentUserEmail).snapshots();
  }

  //todo update user name or about
  Future<void> updateUserInFireStore(String currentUserEmail,String name,String about) async {
    await fireStore.collection("users").doc(currentUserEmail).update({"name": name,"about": about});
    showToast("data update successfully");
  }

  //todo update user profile photo
  Future<void> updateProfilePhoto(String currentUserEmail,String url) async {
    await fireStore.collection("users").doc(currentUserEmail).update({"image": url});
    showToast("Profile photo updated");
  }

  //todo get current user from fire store
  // void getCurrentUserFromFireStore() async {
  //   User? user = AuthService.authService.getCurrentUser();
  //   // return fireStore.collection("users").doc(user!.email).snapshots();
  //   final doc = await fireStore.collection("users").doc(user!.email).get();
  //   if(doc.data()!=null){
  //     currentUser = UserModel.fromMap(doc.data()!);
  //   }
  // }

}

// add chat in fire store
//chatroom -> sender_receiver -> chat -> list chat


//collection(name) ka name hoga -> doc(id) ki id unique hoti he

//Collection : is a collection of multiple documents
//Document : Document hole information (Data - Map) or collection
