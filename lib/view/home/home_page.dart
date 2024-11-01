import 'package:chatting_app/Model/user_model.dart';
import 'package:chatting_app/Services/cloud_firestore_service.dart';
import 'package:chatting_app/Services/online_status.dart';
import 'package:chatting_app/View/Chat/chat_page.dart';
import 'package:chatting_app/View/Search/search_page.dart';
import 'package:chatting_app/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/customUserTile.dart';
import '../components/my_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    print("----------------- init state -------------------");
    OnlineStatus.onlineStatus.updateOnlineStatus(true);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      print("----------------- Paused App -------------------");
      OnlineStatus.onlineStatus.updateOnlineStatus(false);
      OnlineStatus.onlineStatus.updateLastSeenOfUser();
    } else if (state == AppLifecycleState.resumed) {
      print("----------------- Resume App -------------------");
      OnlineStatus.onlineStatus.updateOnlineStatus(true);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    List<UserModel> allUsers = [];
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: MyDrawer(),
      appBar: AppBar(
        titleSpacing: 7,
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        title: Text(
          'QuickChat',
          style: TextStyle(fontFamily: 'pr',fontWeight: FontWeight.bold),//,fontSize: width * 0.062
        ),
      ),
      body: Column(
        children: [
          //todo -------------------------------> Search TextField
          Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 2),
            child: GestureDetector(
              onTap: () => Get.to(SearchPage(allUsers: allUsers,)),
              child: Hero(
                tag: "search",
                child: Material(
                  color: Colors.transparent,
                  child: TextField(
                    enabled: false,
                    style: TextStyle(fontSize: width * 0.04),//color: Colors.white60,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.secondary,//const Color(0xff24252a),
                      hintText: "Search",
                      hintStyle: const TextStyle(fontFamily: 'pr'),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: height * 0.014),
          //todo -------------------------------> Users List
          Expanded(
            child: Stack(
              children: [
                Center(child: Icon(Icons.message,size: width * 0.315,color: Colors.grey.shade200.withOpacity(controller.isDarkMode.value ? 0.061 : 0.44),)),
                StreamBuilder(
                  stream: CloudFireStoreService.cloudFireStoreService.getAllUsersFromFireStore(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString(),style: TextStyle(color: Colors.white),),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                        ),
                      );
                    }
                    List l1 = snapshot.data!.docs;
                    allUsers = l1.map((e) => UserModel.fromMap(e.data())).toList();
                    return ListView.separated(
                        itemCount: allUsers.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              chatController.getReceiver(allUsers[index].email!, allUsers[index].name!);
                              Get.to(() => ChatPage(userImg: allUsers[index].image!,tag: 'img-${allUsers[index].email}',));
                            },
                            child: CustomUserTile(allUsers: allUsers, tag: 'img-${allUsers[index].email}', index: index)
                          );
                        },
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                        indent: width * 0.195,
                        endIndent: 15,
                        color: controller.isDarkMode.value
                            ? Colors.white24
                            : Colors.black26,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
