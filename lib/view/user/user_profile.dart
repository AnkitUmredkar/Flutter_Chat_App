import 'package:animated_button/animated_button.dart';
import 'package:chatting_app/Services/cloud_firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Services/cloud_storage_service.dart';
import '../../global.dart';

TextEditingController _txtName = TextEditingController();
TextEditingController _txtAbout = TextEditingController();

class UserProfile extends StatefulWidget {
  UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Map? data;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var color = Theme.of(context).colorScheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        titleSpacing: 7,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        title: Text(
          'Profile',
          style: TextStyle(
              fontFamily: 'pr',
              fontWeight: FontWeight.w600,
              fontSize: width * 0.061),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 18),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.06,
            ),
            StreamBuilder(
              stream: CloudFireStoreService.cloudFireStoreService.getCurrentUserFromFireStore(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Container(
                    height: width * 0.31,
                    width: width * 0.31,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                  );
                }
                data = snapshot.data!.data();

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _txtName.text = data!["name"];
                  _txtAbout.text = data!["about"];
                });
                return Column(
                  children: [
                    //todo --------------------------> user profileImage
                    Stack(
                      children: [
                        Container(
                          height: width * 0.31,
                          width: width * 0.31,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: FadeInImage(
                              fit: BoxFit.cover,
                              placeholder: AssetImage("assets/placeholder.jpeg"),
                              image: NetworkImage(data!["image"]),
                              fadeInDuration: Duration(seconds: 1),
                              fadeOutDuration: Duration(milliseconds: 200),
                            ),
                          ),
                        ),
                        //todo --------------------------> button to pick image
                        Positioned(
                          bottom: 0,
                          right: -25,
                          child: MaterialButton(
                            elevation: 1,
                            onPressed: () async {
                              String url = await CloudStorageService.cloudStorageService.updateProfilePhoto();
                              profileController.getImage(url,data!["email"]);
                            },
                            color: const Color(0xffacda4b),
                            shape: const CircleBorder(),
                            child: const Icon(
                              Icons.photo_camera_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.044),
                    //todo --------------------------> user name
                    TextField(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: color.surface,
                                title: Text(
                                  'Edit name',
                                  style: TextStyle(
                                      fontFamily: 'pr',
                                      fontWeight: FontWeight.w500),
                                ),
                                content: editTextField(_txtName,color),
                                actions: [
                                  cancelButton(color),
                                  TextButton(
                                      onPressed: () {
                                        CloudFireStoreService.cloudFireStoreService.updateUserInFireStore(data!["email"], _txtName.text , _txtAbout.text);
                                        Get.back();
                                      },
                                      child: Text(
                                        'Update',
                                        style: TextStyle(fontFamily: 'pr',color: color.inversePrimary),
                                      )),
                                ],
                              );
                            });
                      },
                      readOnly: true,
                      controller: _txtName,
                      cursorColor: Color(0xffacda4b),
                      style: TextStyle(
                          fontFamily: 'pr',
                          fontSize: width * 0.0382),
                      decoration: buildInputDecoration(color),
                    ),
                    SizedBox(height: height * 0.0305),
                    //todo --------------------------> about
                    TextField(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: color.surface,
                                title: Text(
                                  'Edit name',
                                  style: TextStyle(
                                      fontFamily: 'pr',
                                      fontWeight: FontWeight.w500),
                                ),
                                content: editTextField(_txtAbout,color),
                                actions: [
                                  cancelButton(color),
                                  TextButton(
                                      onPressed: () {
                                        CloudFireStoreService.cloudFireStoreService.updateUserInFireStore(data!["email"], _txtName.text , _txtAbout.text);
                                        Get.back();
                                      },
                                      child: Text(
                                        'Update',
                                        style: TextStyle(fontFamily: 'pr', color: color.inversePrimary),
                                      ),
                                  ),
                                ],
                              );
                            });
                      },
                      readOnly: true,
                      controller: _txtAbout,
                      cursorColor: Color(0xff7cda45),
                      style: TextStyle(
                          fontFamily: 'pr',
                          color: color.inversePrimary,
                          fontSize: width * 0.0382),
                      decoration: buildInputDecoration(color),
                    ),
                  ],
                );
              },),
            //todo --------------------------> User Img
            Spacer(),
            AnimatedButton(
              width: width * 0.85,
              height: height * 0.072,
              color: const Color(0xffacda4b),
              onPressed: () {
                if (_txtName.text == data!["name"] && _txtAbout.text == data!["about"])
                {
                  showToast("No changes made");
                } else {
                  CloudFireStoreService.cloudFireStoreService
                      .updateUserInFireStore(
                          data!["email"],
                          _txtName.text,
                          _txtAbout.text,);
                }
              },
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.black,
                    fontFamily: 'pr',
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //todo -------------> cancel button
  TextButton cancelButton(var color) {
    return TextButton(
        onPressed: () {
          Get.back();
        },
        child: Text(
          'Cancel',
          style: TextStyle(fontFamily: 'pr',color: color.inversePrimary//controller.isDarkMode.value ? Colors.white60 : Colors.black54,
          ),
        ));
  }

  //todo -------------> dialog box TextField
  TextField editTextField(TextEditingController controller,var color) {
    return TextField(
      controller: controller,
      cursorColor: Color(0xff7cda45),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        filled: true,
        fillColor: color.secondary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      ),
    );
  }

  //todo -------------> input decoration of both TextField
  InputDecoration buildInputDecoration(ColorScheme color) {
    return InputDecoration(
      filled: true,
      fillColor: color.secondary,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color.primary),
          borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade600, width: 1.5),
          borderRadius: BorderRadius.circular(10)),
    );
  }

}

// errorBuilder: (context, error, stackTrace) {
//                           return Icon(Icons.person,
//                               color: Colors.grey.shade700,
//                               size: 50); // Fallback to user icon
//                         },
