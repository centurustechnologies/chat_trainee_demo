import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  final String myEmail, userEmail, userName, userImage;
  const ChatScreen(
      {super.key,
      required this.myEmail,
      required this.userEmail,
      required this.userName,
      required this.userImage});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String getEmailCombination() {
    List<String> emails = [widget.myEmail, widget.userEmail];
    emails.sort();
    return "${emails[0]}-${emails[1]}";
  }

  TextEditingController msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10),
                color: Colors.teal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back),
                        ),
                        SizedBox(width: 8),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(widget.userImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.userName,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'time pass', // Replace with actual time
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.video_call),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.call),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.more_vert),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.green.shade100,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: width,
                          // height: MediaQuery.of(context).size.height / 1.1,
                          padding: EdgeInsets.all(10),
                          color: Colors.green.shade100,
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('msg')
                                .doc(getEmailCombination())
                                .collection('chatmsg')
                                .orderBy('time', descending: true)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  reverse: true,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot documentSnapshot =
                                        snapshot.data!.docs[index];
                                    return Wrap(
                                      children: [
                                        Align(
                                          alignment:
                                              documentSnapshot['email'] ==
                                                      widget.myEmail
                                                  ? Alignment.centerRight
                                                  : Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: documentSnapshot[
                                                              'email'] ==
                                                          widget.myEmail
                                                      ? Colors.blueAccent
                                                          .withOpacity(0.5)
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                      blurRadius: 10,
                                                      spreadRadius: 1,
                                                    )
                                                  ]),
                                              padding: EdgeInsets.all(4),
                                              child:
                                                  Text(documentSnapshot['msg']),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  // Emoji button

                                  IconButton(
                                    onPressed: () {
                                      FocusScope.of(context).unfocus();
                                    },
                                    icon: Icon(
                                      Icons.emoji_emotions,
                                      color: Colors.blueAccent,
                                      size: 25,
                                    ),
                                  ),

                                  Expanded(
                                    child: TextField(
                                      keyboardType: TextInputType.multiline,
                                      controller: msgController,
                                      maxLines: null,
                                      onTap: () {},
                                      decoration: const InputDecoration(
                                        hintText: 'Type Something...',
                                        hintStyle:
                                            TextStyle(color: Colors.blueAccent),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),

                                  // Pick image from gallery button
                                  IconButton(
                                    onPressed: () async {
                                      final ImagePicker picker = ImagePicker();
                                      final List<XFile>? images = await picker
                                          .pickMultiImage(imageQuality: 70);

                                      if (images != null) {
                                        for (var i in images) {
                                          debugPrint('Image Path: ${i.path}');
                                        }
                                      }
                                    },
                                    icon: const Icon(Icons.image,
                                        color: Colors.blueAccent, size: 26),
                                  ),

                                  // Take image from camera button
                                  IconButton(
                                    onPressed: () async {
                                      final ImagePicker picker = ImagePicker();
                                      final XFile? image =
                                          await picker.pickImage(
                                              source: ImageSource.camera,
                                              imageQuality: 70);

                                      if (image != null) {
                                        debugPrint('Image Path: ${image.path}');
                                      }
                                    },
                                    icon: const Icon(Icons.camera_alt_rounded,
                                        color: Colors.blueAccent, size: 26),
                                  ),

                                  // Adding some space
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          20),
                                ],
                              ),
                            ),
                          ),

                          // Send message button
                          MaterialButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('msg')
                                  .doc(getEmailCombination())
                                  .collection('chatmsg')
                                  .add(
                                {
                                  'msg': msgController.text,
                                  'email': widget.myEmail,
                                  'time': DateTime.now().toString(),
                                },
                              );
                              msgController.clear();
                            },
                            minWidth: 0,
                            padding: EdgeInsets.all(6),
                            shape: CircleBorder(),
                            color: Colors.teal,
                            child:
                                Icon(Icons.send, color: Colors.white, size: 26),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
