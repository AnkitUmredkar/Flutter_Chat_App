import 'package:chatting_app/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Model/chat_model.dart';
import '../../Services/auth_services.dart';


class ChatBubble extends StatelessWidget {
  final bool isCurrentUser;
  final List<ChatModel> chatList;
  final String formattedTime;
  final int index;

  ChatBubble(
      {super.key,
      required this.isCurrentUser,
      required this.chatList,
      required this.formattedTime,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.5,horizontal: 2),
      child: Column(
        children: [
          Obx(
          () => Container(
            alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: index == chatController.selectedIndex.value &&
                    chatList[chatController.selectedIndex.value].sender == AuthService.authService.getCurrentUser()!.email
                    ? Colors.green.shade400.withOpacity(0.35)
                    : Colors.transparent,
              ),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 3),
                padding: EdgeInsets.all((chatList[index].image!.isEmpty) ? 12 : 3.5),
                decoration: BoxDecoration(
                  borderRadius: isCurrentUser
                      ? BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),)
                      : BorderRadius.only(
                          topRight: Radius.circular(12),
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                  color: isCurrentUser
                      ? (controller.isDarkMode.value
                          ? Colors.green.shade600
                          : Colors.green.shade500)
                      : (controller.isDarkMode.value
                          ? Colors.grey.shade800
                          : Colors.grey.shade200),
                ), //isCurrentUser ? Colors.green.shade600 : Colors.grey.shade800),
                child: (chatList[index].image! == "") ? Text(
                        chatList[index].message!,
                        style: TextStyle(
                            color: isCurrentUser
                                ? Colors.white
                                : (controller.isDarkMode.value
                                    ? Colors.white
                                    : Colors.black),
                            fontFamily: 'pr'),
                      )
                    : Container(
                          width: 200,
                          height: 220,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              chatList[index].image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
              ),
            ),
          ),
          Align(
            alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
            child: Text(
              formattedTime,
              style: TextStyle(
                  fontFamily: 'pr',
                  fontSize: 10,
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),
          )
        ],
      ),
    );
  }
}
