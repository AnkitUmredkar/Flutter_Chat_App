import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/chat_model.dart';
import 'auth_services.dart';

class ChatService{
  ChatService._();
  static ChatService chatService = ChatService._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  //todo -----------------------------> add chat in fireStore
  Future<void> addChatInFireStore(ChatModel chat) async {
    String? sender = chat.sender;
    String? receiver = chat.receiver;
    List doc = [sender,receiver];
    doc.sort();
    String docId = doc.join("_");
    await fireStore.collection("chatroom").doc(docId).collection("chat").add(chat.toMap(chat));
  }

  //todo -----------------------------> get chat from fireStore
  Stream<QuerySnapshot<Map<String, dynamic>>> getChatFromFireStore(String receiver){
    String sender = AuthService.authService.getCurrentUser()!.email!;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join('_');
    return fireStore.collection("chatroom").doc(docId).collection("chat").orderBy("time", descending: false).snapshots();
  }

  //todo -----------------------------> update chat in fireStore
  Future<void> updateChatInFireStore(String receiver,String id,String message) async {
    String sender = AuthService.authService.getCurrentUser()!.email!;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join('_');
    await fireStore.collection("chatroom").doc(docId).collection("chat").doc(id).update({'message': message});
  }

  //todo -----------------------------> delete chat in fireStore
  Future<void> deleteChatInFireStore(String receiver,String id) async {
    String sender = AuthService.authService.getCurrentUser()!.email!;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join('_');
    await fireStore.collection("chatroom").doc(docId).collection("chat").doc(id).delete();
  }

  //todo -----------------------------> get last message
  Stream<QuerySnapshot<Map<String, dynamic>>> getLastChatFromFireStore(String receiver) {
    String sender = AuthService.authService.getCurrentUser()!.email!;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join('_');
    return fireStore.collection("chatroom").doc(docId).collection("chat").orderBy("time", descending: true).limit(1).snapshots();
  }

}