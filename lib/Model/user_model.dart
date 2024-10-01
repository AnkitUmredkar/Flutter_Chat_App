import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? name, email, image, phone, token, about;
  Timestamp timestamp;
  bool isOnline,isTyping;

  UserModel(
      {required this.name,
      required this.email,
      required this.image,
      required this.phone,
      required this.token,
      required this.isOnline,
      required this.isTyping,
      required this.timestamp,
      required this.about});

  factory UserModel.fromMap(Map m1) {
    return UserModel(
      name: m1['name'],
      email: m1['email'],
      image: m1['image'],
      phone: m1['phone'],
      token: m1['token'],
      isOnline: m1['isOnline'],
      isTyping: m1['isTyping'],
      timestamp: m1['timestamp'],
      about: m1['about'],
    );
  }

  Map<String, dynamic> toMap(UserModel user) {
    return {
      'name': user.name,
      'email': user.email,
      'image': user.image,
      'phone': user.phone,
      'token': user.token,
      'isOnline': user.isOnline,
      'isTyping': user.isTyping,
      'about': user.about,
      'timestamp': user.timestamp
    };
  }
}
