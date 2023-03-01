import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/chat.dart';
import '../models/message.dart';
import '../provider.dart';

class SendMessageField extends ConsumerWidget {
  const SendMessageField({
    super.key,
    required this.chat,
  });

  final Chat chat;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController textMessageController =
        TextEditingController();
    return Container(
      margin: const EdgeInsets.only(bottom: 30, left: 4, right: 4),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.2),
                        offset: const Offset(0.0, 0.50),
                        spreadRadius: 1,
                        blurRadius: 1),
                  ]),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.insert_emoticon,
                    color: Colors.grey[500],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 60,
                      ),
                      child: Scrollbar(
                        child: TextField(
                          maxLines: null,
                          style: const TextStyle(fontSize: 14),
                          controller: textMessageController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type a message",
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.link),
                      const SizedBox(
                        width: 10,
                      ),
                      textMessageController.text.isEmpty
                          ? const Icon(Icons.camera_alt)
                          : const Text(""),
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          InkWell(
            onTap: () async {
              if (textMessageController.text.isNotEmpty) {
                await ref.read(databaseProvider)!.sendMessage(
                    chat.chatId,
                    Message(
                        text: textMessageController.text,
                        myUid: ref.read(firebaseAuthProvider).currentUser!.uid,
                        time: DateTime.now().toString()));
                print("'message sent'");
              }
            },
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              child: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
