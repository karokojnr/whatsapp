import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/models/user_data.dart';
import 'package:whatsapp/provider.dart';
import '../models/chat.dart';
import 'chat_page.dart';

class SelectPersonToChat extends ConsumerWidget {
  const SelectPersonToChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Person to Chat"),
      ),
      body: SafeArea(
          child: StreamBuilder<List<UserData>>(
        stream: ref.read(databaseProvider)!.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong!"),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final users = snapshot.data ?? [];

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final myUser = ref.read(firebaseAuthProvider).currentUser!;

              // if the user is the same as the current user, don't show it
              if (user.uid == myUser.uid) {
                return Container();
              }
              return Column(
                children: [
                  ListTile(
                    title: Text(user.name),
                    onTap: () async {
                      final chatId = await ref
                              .read(databaseProvider)
                              ?.getChatStarted(myUser.uid, user.uid) ??
                          false;
                      if (chatId == "") {
                        await ref
                            .read(databaseProvider)
                            ?.startChat(myUser.uid, user.uid, user.name)
                            .then((value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatPage(
                                  chat: Chat(
                                myUid: myUser.uid,
                                myName: "",
                                otherUid: user.uid,
                                otherName: user.name,
                                chatId: value,
                              )),
                            ),
                          );
                        });
                      } else {
                        if (context.mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatPage(
                                  chat: Chat(
                                myUid: myUser.uid,
                                myName: "",
                                otherUid: user.uid,
                                otherName: user.name,
                                chatId: chatId.toString(),
                              )),
                            ),
                          );
                        }
                      }
                    },
                  ),
                  const Divider(),
                ],
              );
            },
          );
        },
      )),
    );
  }
}
