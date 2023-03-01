import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/chat.dart';
import '../models/message.dart';
import '../provider.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/send_message_field.dart';

class ChatPage extends ConsumerStatefulWidget {
  final Chat chat;
  const ChatPage({
    required this.chat,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final myUid = ref.read(firebaseAuthProvider).currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chat.myUid == myUid
            ? widget.chat.otherName
            : widget.chat.myName),
        actions: const <Widget>[
          Icon(Icons.video_call),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
          ),
          Icon(Icons.call),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
          ),
          Icon(Icons.more_vert),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Image.network(
                "https://i.pinimg.com/736x/8c/98/99/8c98994518b575bfd8c949e91d20548b.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                Column(
                  children: [
                    Expanded(
                        child: StreamBuilder<List<Message>>(
                      stream: ref
                          .read(databaseProvider)!
                          .getMessages(widget.chat.chatId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.active &&
                            snapshot.hasData) {
                          final messages = snapshot.data ?? [];

                          return ListView.builder(
                            reverse: true,
                            itemCount: messages.length,
                            itemBuilder: (_, index) {
                              final message = messages[index];
                              final isMe = message.myUid ==
                                  ref
                                      .read(firebaseAuthProvider)
                                      .currentUser!
                                      .uid;
                              return ChatBubble(
                                message: message,
                                isMe: isMe,
                              );
                            },
                          );
                        }
                        return Container();
                      },
                    )),
                    SendMessageField(
                      chat: widget.chat,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
