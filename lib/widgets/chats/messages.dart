import 'package:chat_app/widgets/chats/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  // var isMe = falses;
  // const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy("createdAt", descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data!.docs as List;
          User? user = FirebaseAuth.instance.currentUser;
          return ListView.builder(
            reverse: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(8),
                child: MessageBubble(
                    docs[index]["text"],
                    docs[index]["username"],
                    docs[index]["userImage"],
                    docs[index]["userId"]),
              );
            },
          );
        });
  }
}
