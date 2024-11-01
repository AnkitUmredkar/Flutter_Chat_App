import 'package:chatting_app/Model/user_model.dart';
import 'package:chatting_app/global.dart';
import 'package:flutter/material.dart';

import '../../Services/chat_service.dart';
import 'my_date_util.dart';

class CustomUserTile extends StatelessWidget {
  final List<UserModel> allUsers;
  final String tag;
  final int index;
  CustomUserTile({super.key, required this.allUsers, required this.tag, required this.index});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 10, 15, 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Hero(
            tag: tag,
            child: Container(
              height: width * 0.13,
              width: width * 0.13,
              padding: EdgeInsets.all(2.5),
              decoration: BoxDecoration(
                border: Border.all(
                    strokeAlign: BorderSide.strokeAlignOutside,
                    width: 1.3,
                    color: controller.isDarkMode.value
                        ? Colors.green.shade600
                        : Colors.green.shade500),
                color: controller.isDarkMode.value
                    ? Colors.black
                    : Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(allUsers[index].image!),
                  ),
                ),
                child: Stack(
                  children: [
                    //todo ------------------> if user is Online then show green dot
                    if (allUsers[index].isOnline)
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Transform.translate(
                          offset: Offset(2, 2),
                          child: Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                              shape: BoxShape.circle,
                              color: Color(0xff4eca1e),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(),
              Text(allUsers[index].name!, style: TextStyle(fontFamily: 'pr')),//color: Colors.white
              SizedBox(height: 6),
              StreamBuilder(
                stream: ChatService.chatService.getLastChatFromFireStore(allUsers[index].email!),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty)
                    return Text(allUsers[index].about!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontFamily: 'pr',
                          ),
                    );

                  if (snapshot.connectionState == ConnectionState.waiting) return Text('');

                  Map data = snapshot.data!.docs[0].data();
                  //todo ------------------------------> return last message
                  if (data["message"].isNotEmpty) {
                    return Container(
                      width: width * 0.545,
                      margin: EdgeInsets.only(right: 5),
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        data["message"],
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontFamily: 'pr', // fontSize: width * 0.0375
                        ),
                      ),
                    );
                  }
                  else {
                    return Row(
                      children: [
                        Icon(Icons.image, color: Theme.of(context).colorScheme.inversePrimary, size: 15,),
                        Text(
                          " Image",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontFamily: 'pr', // fontSize: width * 0.0375
                          ),
                        )
                      ],
                    );
                  }
                },
              ),
            ],
          ),
          Spacer(),
          StreamBuilder(
            stream: ChatService.chatService.getLastChatFromFireStore(allUsers[index].email!),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) return Text('');
              Map data = snapshot.data!.docs[0].data();
              return Text(
                  MyDateUtil.getLastMessageTime(data["time"], context),//formattedTime!.toString(),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontFamily: 'pr',
                      // fontSize: width * 0.0375
                  ),
              );
            },
          ),
        ],
      ),
    );
  }
}