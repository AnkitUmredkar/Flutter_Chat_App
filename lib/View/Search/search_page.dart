import 'package:chatting_app/Components/customUserTile.dart';
import 'package:chatting_app/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Model/user_model.dart';
import '../Chat/chat_page.dart';

class SearchPage extends StatelessWidget {
  final List<UserModel> allUsers;
  const SearchPage({super.key,required this.allUsers});

  void runFilter(String value){
    List<UserModel> result = [];
    if(value.isEmpty){
      result = [];
    }
    else{
      result = allUsers.where((user) => user.name!.toLowerCase().contains(value.toLowerCase())).toList();
    }
    chatController.showList(result);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          //todo ---------------------> Search Box
          Padding(
            padding: EdgeInsets.fromLTRB(8,54,8,0),
            child: Row(
              children: [
                IconButton(onPressed: (){
                  Get.back();
                  chatController.showUsersList.clear();
                }, icon: const Icon(Icons.arrow_back_ios)),
                Expanded(
                  child: Hero(
                  tag: "search",
                  child: Material(
                    color: Colors.transparent,
                    child: TextField(
                      cursorColor: Color(0xff7cda45),
                      onChanged: (value) => runFilter(value),
                      style: TextStyle(fontSize: width * 0.04),//color: Colors.white60,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.secondary,//const Color(0xff24252a),
                        hintText: "Search",
                        hintStyle: const TextStyle(fontFamily: 'pr'),
                        // contentPadding: EdgeInsets.symmetric(
                        //     vertical: 13.h, horizontal: 15.w),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ),)
              ],
            ),
          ),
          //todo ---------------------> User List
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(4, 0, 4, 2),
              child: Obx(
                () => ListView.builder(
                  itemCount: chatController.showUsersList.length,
                  itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      chatController.getReceiver(chatController.showUsersList[index].email!, chatController.showUsersList[index].name!);
                      Get.to(() => ChatPage(userImg: chatController.showUsersList[index].image!,tag: 'img-${chatController.showUsersList[index].email}',));
                    },
                    child: Column(
                      children: [
                        CustomUserTile(allUsers: chatController.showUsersList, tag: 'img-${chatController.showUsersList[index].email}', index: index),
                        Divider(
                          indent: width * 0.21,
                          endIndent: 15,
                          color: controller.isDarkMode.value ? Colors.white24 : Colors.black26,
                        ),
                      ],
                    ),
                  );
                },),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
