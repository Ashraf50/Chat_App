import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../model/ChatBubble.dart';
import '../model/messageModel.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final massage_controller = TextEditingController();
  final _controller = ScrollController();
  final user_details = FirebaseAuth.instance.currentUser;

  CollectionReference messeges =
      FirebaseFirestore.instance.collection("Masages");
  send_message() {
    CollectionReference users =
        FirebaseFirestore.instance.collection("Masages");
    users.add(
      {
        'message': massage_controller.text,
        "createdAt": DateTime.now(),
        "id": user_details!.email,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messeges.orderBy("createdAt", descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List massages_list = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            massages_list.add(Message.fromjson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Color(0xff2B475E),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/scholar.png",
                    width: 55,
                  ),
                  Text("Chat"),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: massages_list.length,
                    itemBuilder: (context, index) {
                      return massages_list[index].id == user_details!.email
                          ? ChatBubble(
                              massage: massages_list[index],
                            )
                          : ChatBubbleFriend(massage: massages_list[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(7),
                  child: TextField(
                    controller: massage_controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Send Message",
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: IconButton(
                          onPressed: () async {
                            await send_message();
                            massage_controller.clear();
                            _controller.animateTo(0,
                                // _controller.position.maxScrollExtent,
                                duration: Duration(microseconds: 1),
                                curve: Curves.fastOutSlowIn);
                          },
                          icon: Icon(
                            Icons.send,
                            color: Color(0xff2B475E),
                            size: 27,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return Center(
            child: SpinKitFadingCircle(
              color: Color.fromARGB(255, 57, 79, 98),
              size: 160.0,
            ),
          );
        }
      },
    );
  }
}
