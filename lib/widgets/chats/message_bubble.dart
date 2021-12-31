import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message, this.userName, this.userImage, this.userId);
  final String message;
  final String userName;
  final String userImage;
  final String userId;
  // final Key key;

  final User? user = FirebaseAuth.instance.currentUser;

  bool isMe() {
    if (userId == user!.uid) {
      return true;
    }
    return false;
  }
  // const MessageBubble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      Row(
        mainAxisAlignment:
            isMe() ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: isMe() ? Colors.grey : Colors.purple,
                borderRadius: BorderRadius.only(
                    bottomLeft: !isMe()
                        ? const Radius.circular(0)
                        : const Radius.circular(14),
                    bottomRight: isMe()
                        ? const Radius.circular(0)
                        : const Radius.circular(14),
                    topLeft: const Radius.circular(14),
                    topRight: const Radius.circular(14))),
            width: 150,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Column(
              crossAxisAlignment:
                  isMe() ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                // FutureBuilder<DocumentSnapshot>(
                //     future: FirebaseFirestore.instance
                //         .collection("users")
                //         .doc(userId)
                //         .get(),
                //     builder: (context, snapshot) {
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         return const Text('Loading..');
                //       }
                //       if (!snapshot.hasData) {
                //         return const Text('Loading..');
                //       }
                //       return

                Text(userName, style: TextStyle(fontWeight: FontWeight.bold))
                // ;
                // })
                ,
                Text(
                  message,
                  textAlign: isMe() ? TextAlign.end : TextAlign.start,
                  style: TextStyle(
                      color: isMe()
                          ? Colors.black
                          : const Color.fromRGBO(255, 253, 208, 6),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
      Positioned(
          top: 0,
          left: isMe() ? null : 120,
          right: isMe() ? 120 : null,
          child: CircleAvatar(backgroundImage: NetworkImage(userImage))),
    ]);
  }
}
