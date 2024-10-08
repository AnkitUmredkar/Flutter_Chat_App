import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String? sender, receiver, message, image;
  bool read;
  Timestamp? time;

  ChatModel(
      {required this.sender,
      required this.receiver,
      required this.message,
      required this.time,
      required this.image,
      required this.read});

  factory ChatModel.fromMap(Map m1) {
    return ChatModel(
        sender: m1['sender'],
        receiver: m1['receiver'],
        message: m1['message'],
        time: m1['time'],
        read: m1['read'],
        image: m1['image']);
  }

  Map<String, dynamic> toMap(ChatModel chat) {
    return {
      'sender': chat.sender,
      'receiver': chat.receiver,
      'message': chat.message,
      'time': chat.time,
      'read': chat.read,
      'image': chat.image,
    };
  }
}
