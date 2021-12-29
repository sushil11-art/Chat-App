import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message, this.userId);
  final String message;
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
    return Row(
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
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Text(
            message,
            style: TextStyle(
                color: isMe()
                    ? Colors.black
                    : const Color.fromRGBO(255, 253, 208, 6),
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}