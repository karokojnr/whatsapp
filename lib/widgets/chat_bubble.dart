import 'package:flutter/material.dart';

import '../models/message.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
  });
  final Message message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: isMe
            ? const EdgeInsets.only(
                left: 50.0, right: 15.0, top: 7.0, bottom: 7.0)
            : const EdgeInsets.only(
                left: 15.0, right: 50.0, top: 7.0, bottom: 7.0),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xffE2FDC4) : Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: Colors.grey.withOpacity(.1),
              blurRadius: 5.0,
              spreadRadius: 1.0,
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        child: Text(message.text),
      ),
    );
  }
}
