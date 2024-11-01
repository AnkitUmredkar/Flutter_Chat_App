import 'package:animate_do/animate_do.dart';
import 'package:chatting_app/Model/chat_model.dart';
import 'package:chatting_app/Services/auth_services.dart';
import 'package:chatting_app/Services/chat_service.dart';
import 'package:chatting_app/Services/cloud_storage_service.dart';
import 'package:chatting_app/Services/online_status.dart';
import 'package:chatting_app/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Services/call services/video_call_service.dart';
import '../../Services/call services/voice_call_service.dart';
import '../components/chat_bubble.dart';
import '../components/my_date_util.dart';

class ChatPage extends StatefulWidget {
  final String userImg,tag;
  ChatPage({super.key,required this.userImg,required this.tag});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {


  final ScrollController _scrollController = ScrollController();
  final FocusNode myFocusNode = FocusNode();
  final FocusNode editFocusNode = FocusNode();

  void scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
  }

  void jumpDown(){
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      print(_scrollController.offset);
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        chatController.showScrollButton(false);
        print("at Maximum");
      }
      else chatController.showScrollButton(true);

    },);
    myFocusNode.addListener(
      () {
        if(myFocusNode.hasFocus){
          OnlineStatus.onlineStatus.updateTypingStatus(true);
        }
        else{
          OnlineStatus.onlineStatus.updateTypingStatus(false);
        }
        Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var color = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: color.surface,//const Color(0xff12131e),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8,0,8,8),
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  //todo -------------------------> chatPage header
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.fromLTRB(8, 12, 8, 6),
                    child: Row(
                      children: [
                        Hero(
                          tag: widget.tag,
                          child: Container(
                            height: width * 0.128,
                            width: width * 0.128,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    strokeAlign: BorderSide.strokeAlignOutside,
                                    width: 1.3,
                                    color: controller.isDarkMode.value
                                        ? Colors.green.shade600
                                        : Colors.green.shade500),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(widget.userImg),
                                ),
                                color: Colors.grey.shade300,
                                shape: BoxShape.circle),
                          ),
                        ),
                        SizedBox(width: 8),
                        FadeInDown(
                          from: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                chatController.receiverName.value,
                                style: TextStyle(
                                    fontFamily: 'pr',
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 3),
                              StreamBuilder(
                                stream: OnlineStatus.onlineStatus.getReceiverStatus(chatController.receiverEmail.value),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Text('');
                                  }
                                  Map? data = snapshot.data!.data();
                                  // String nightOrDay = '';
                                  // if (data!["timestamp"].toDate().hour > 11) {
                                  //   nightOrDay = 'pm';
                                  // } else {
                                  //   nightOrDay = 'am';
                                  // }
                                  // DateTime messageTime = data["timestamp"].toDate();
                                  // String formattedTime = DateFormat("hh:mm").format(messageTime);
                                  return Text(
                                    data!["isOnline"]
                                        ? data["isTyping"] ? "Typing..."  : "Online"
                                        : "Last seen ${MyDateUtil.getLastSeenTime(data["timestamp"], context)}",
                                    style: TextStyle(
                                        color: controller.isDarkMode.value ? Colors.white60 : Colors.grey.shade700,
                                        fontFamily: 'pr',
                                        fontSize: data["isOnline"] ? width * 0.035 : width * 0.029,
                                        fontWeight: FontWeight.w500),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                        Obx(() => (chatController.isLongPressed.value)
                              ? Row(
                                  children: [
                                    //todo -----------------------> update message
                                    GestureDetector(
                                      onTap: () {
                                        chatController.txtMessage.text = chatController.msg.value;
                                        chatController.isEditOrNot(true);
                                        FocusScope.of(context).requestFocus(myFocusNode);
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        size: width * 0.06,
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    //todo -----------------------> delete message
                                    GestureDetector(
                                        onTap: () {
                                          ChatService.chatService
                                              .deleteChatInFireStore(
                                                  chatController.receiverEmail.value,
                                                  chatController.docId.value);
                                          chatController.valueAssigning(
                                              false, "", (-1), "");
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red.shade400,
                                          size: width * 0.06,
                                        )),
                                    SizedBox(width: 8),
                                  ],
                                )
                              : buildCallBar(width),
                        ),
                      ],
                    ),
                  ),
                  //todo -------------------------> messages list
                  Expanded(
                    child: Stack(
                      children: [
                        Center(child: Icon(Icons.message,size: width * 0.315,color: Colors.grey.shade200.withOpacity(controller.isDarkMode.value ? 0.061 : 0.44),)),
                        MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: StreamBuilder(
                            stream: ChatService.chatService.getChatFromFireStore(chatController.receiverEmail.value),
                            builder: (context, snapshot) {
                              if(snapshot.hasError){
                                return Center(child: Text(snapshot.error.toString()),);
                              }
                              if(snapshot.connectionState == ConnectionState.waiting){
                                return Center(child: Text(""));
                              }
                              WidgetsBinding.instance.addPostFrameCallback((_) => scrollDown());
                              List data = snapshot.data!.docs;
                              List<String> docId = [];
                              List<ChatModel> chatList = [];
                              for(QueryDocumentSnapshot snap in data){
                                docId.add(snap.id);
                              }
                              chatList = data.map((e) => ChatModel.fromMap(e.data() as Map)).toList();
              
                              return ListView.builder(
                                controller: _scrollController,
                                  itemCount: chatList.length,
                                  itemBuilder: (context, index) {
                                  DateTime messageTime = chatList[index].time!.toDate();
                                  // Use TimeOfDay to format according to user settings (AM/PM or 24-hour)
                                  String formattedTime = TimeOfDay.fromDateTime(messageTime).format(context);
                                  bool isCurrentUser = chatList[index].sender == AuthService.authService.getCurrentUser()!.email;
                                  return GestureDetector(
                                        onTap: (){
                                          if(isCurrentUser){
                                            chatController.txtMessage.clear();
                                            chatController.valueAssigning(false, "",(-1),"");
                                          }
                                        },
                                      onLongPress: (){
                                        if (isCurrentUser) {
                                          chatController.valueAssigning(true, chatList[index].message!, index, docId[index]);
                                        }
                                      },child: ChatBubble(
                                        isCurrentUser: isCurrentUser,
                                        chatList: chatList,
                                        index: index,
                                        formattedTime: formattedTime,
                                      ),
                                  );
                                  },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  //todo -------------------------> TextField to send msg
                  _buildUserInput(height),
                ],
              ),
            ),
            Obx(
              () => (chatController.isScroll.value)
                  ? jumpToDownButton(color)
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  //todo --------------------------> send message
  Future<void> sendMessage() async {
    if ((chatController.txtMessage.text.isNotEmpty) || chatController.image.value != "") {
      ChatModel chat = ChatModel(
          sender: AuthService.authService.getCurrentUser()!.email,
          receiver: chatController.receiverEmail.value,
          message: chatController.txtMessage.text == "Send image" ? "" : chatController.txtMessage.text,
          time: Timestamp.now(),
          read: false,
          image: chatController.image.value);
      await ChatService.chatService.addChatInFireStore(chat);
      chatController.getImage("");
      chatController.txtMessage.clear();
      // await LocalNotificationService.localNotificationService.showNotification(AuthService.authService.getCurrentUser()!.displayName!, chat.message!);
    }
    scrollDown();
  }

  //todo --------------------------> update message method
  void updateMessage() {
    ChatService.chatService.updateChatInFireStore(
        chatController.receiverEmail.value,
        chatController.docId.value,
        chatController.txtMessage.text);
    chatController.valueAssigning(false, "", (-1), "");
    chatController.txtMessage.clear();
    chatController.isEditOrNot(false);
  }

  //todo --------------------------> TextField to send message
  Widget _buildUserInput(double height) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              focusNode: myFocusNode,
              controller: chatController.txtMessage,
              cursorColor: Color(0xff7cda45),
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                fontFamily: 'pr'
              ),
              decoration: InputDecoration(
                suffixIcon: IconButton(onPressed: () async {
                  chatController.txtMessage.text = "Wait to load image..";
                  String url = await CloudStorageService.cloudStorageService.uploadChatImage();
                  chatController.getImage(url);
                }, icon: Icon(Icons.attach_file_rounded, color: controller.isDarkMode.value ? Colors.white38 : Colors.black38),),
                hintText: 'Message',
                hintStyle: TextStyle(color: controller.isDarkMode.value ? Colors.white38 : Colors.black38),
                filled: true,
                fillColor: Theme.of(context).colorScheme.secondary,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              ),
            ),
          ),
          //todo send Button
          Obx(
            () => Container(
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.only(left: 10),
              decoration: const BoxDecoration(shape: BoxShape.circle, color: const Color(0xff2AD516),),
              child: IconButton(
                onPressed: chatController.isLongPressed.value ? updateMessage : sendMessage,
                icon: Icon(
                    chatController.isEdit.value ? Icons.check_rounded : Icons.send,
                    color: Colors.grey.shade900,
                  ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //todo --------------------------> video and voice call
  Row buildCallBar(double width) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(VoiceCallScreen());
          },
          child: Icon(
            Icons.phone,
            size: width * 0.06,
          ),
        ),
        SizedBox(width: 15),
        GestureDetector(
          onTap: (){
            Get.to(VideoCallScreen());
          },
          child: Icon(
            Icons.video_call,
            size: width * 0.06,
          ),
        ),
        SizedBox(width: 8),
      ],
    );
  }

  //todo --------------------------> Jump down button
  Align jumpToDownButton(ColorScheme color) {
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: jumpDown,
        child: Container(
            padding: EdgeInsets.all(5.5),
            margin: EdgeInsets.only(bottom: 70),
            decoration:
            BoxDecoration(color: color.surface, shape: BoxShape.circle),
            child: Icon(Icons.keyboard_double_arrow_down)),
      ),
    );
  }
}

// GestureDetector
// (
// onTap: () {
// chatController.txtUpdateMessage.text = chatController.msg.value;
// showDialog(
// context: context,
// builder: (context) {
// return AlertDialog(
// backgroundColor: bgColor,
// title: Text(
// 'Edit message',
// style: TextStyle(
// color: Colors.white,
// fontFamily: 'pr',
// fontWeight: FontWeight.w500),
// ),
// content: TextField(
// focusNode: editFocusNode,
// controller: chatController.txtUpdateMessage,
// cursorColor: Color(0xff7cda45),
// textAlignVertical:
// TextAlignVertical.center,
// style: TextStyle(
// color: Colors.white,
// ),
// decoration: InputDecoration(
// filled: true,
// fillColor: const Color.fromARGB(
// 255, 48, 48, 48),
// //const Color(0xff24252a),
// border: OutlineInputBorder(
// borderRadius:
// BorderRadius.circular(20),
// borderSide: BorderSide.none,
// ),
// contentPadding:
// EdgeInsets.symmetric(
// horizontal: 16,
// vertical: 15),
// ),
// ),
// actions: [
// TextButton(
// onPressed: () {
// Get.back();
// },
// child: Text(
// 'Cancel',
// style: TextStyle(
// color: Colors.white,
// fontFamily: 'pr'),
// )),
// TextButton(
// onPressed: () {
// ChatService.chatService
//     .updateChatInFireStore(
// chatController
//     .receiverEmail
//     .value,
// chatController
//     .docId.value,
// chatController
//     .txtUpdateMessage
//     .text);
// chatController.valueAssigning(
// false, "", (-1), "");
// Get.back();
// },
// child: Text(
// 'Update',
// style: TextStyle(
// color: Colors.white,
// fontFamily: 'pr'),
// )),
// ],
// );
// },
// );
// },