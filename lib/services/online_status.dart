import 'package:chatting_app/Services/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OnlineStatus{
  OnlineStatus._();
  static OnlineStatus onlineStatus = OnlineStatus._();
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  String currentUserEmail = AuthService.authService.getCurrentUser()!.email!;

  void updateOnlineStatus(bool isOnline){
    fireStore.collection("users").doc(currentUserEmail).update({"isOnline": isOnline});
  }

  void updateTypingStatus(bool status){
    fireStore.collection("users").doc(currentUserEmail).update({"isTyping" : status});
  }

  //todo update last seen of user when he is close app
  void updateLastSeenOfUser(){
    fireStore.collection("users").doc(currentUserEmail).update({"timestamp": Timestamp.now()});
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getReceiverStatus(String receiverEmail){
    return fireStore.collection("users").doc(receiverEmail).snapshots();
  }
}