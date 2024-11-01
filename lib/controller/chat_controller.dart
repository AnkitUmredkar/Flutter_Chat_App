import 'package:chatting_app/Model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  RxString receiverEmail = "".obs,
      receiverName = "".obs,
      msg = "".obs,
      docId = "".obs,
      lastMsg = "".obs,
      image = "".obs;
  RxInt selectedIndex = (-1).obs;
  RxBool isLongPressed = false.obs, isEdit = false.obs,isScroll = false.obs;
  TextEditingController txtMessage = TextEditingController();
  RxList<UserModel> showUsersList = <UserModel>[].obs;

  void showScrollButton(bool value){
    isScroll.value = value;
  }

   void getImage(String url){
     image.value = url;
     txtMessage.text = "Send image";//todo if you change here the must be also change in send message method in chat_page.dart
   }

  //todo ---------------> get receiver name and email
  void getReceiver(String email, String name) {
    receiverEmail.value = email;
    receiverName.value = name;
  }

  //todo ---------------> onLongPressed process need update values
  void valueAssigning(bool value, String message, int index, String dcId) {
    isLongPressed.value = value;
    msg.value = message;
    selectedIndex.value = index;
    docId.value = dcId;
  }

  //todo ---------------> after edit get normal view
  void isEditOrNot(bool value) {
    isEdit.value = value;
  }

  //todo ---------------> on Live Search Feature update userList
  void showList(List<UserModel> result) {
    showUsersList.value = result;
  }
}
