import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/database/chat_database.dart';
import 'package:chat_app/bloc/chat_bloc/chat_bloc.dart';
import 'package:chat_app/bloc/chat_bloc/chat_event.dart';
import 'package:chat_app/bloc/chat_bloc/chat_state.dart';


class ChatScreen extends StatelessWidget {
  final String chatId;

  const ChatScreen({Key? key, required this.chatId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatBloc(AppDatabase())..add(LoadMessages(chatId)),
      child: Scaffold(
        appBar: AppBar(title: Text("Chat")),
        body: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state is ChatLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ChatLoaded) {
              return ListView.builder(
                itemCount: state.messages.length,
                itemBuilder: (context, index) {
                  final message = state.messages[index];
                  return ListTile(
                    title: Text(message.sender),
                    subtitle: Text(message.content),
                    trailing: Text(message.timestamp.toString()),
                  );
                },
              );
            } else if (state is ChatError) {
              return Center(child: Text(state.error));
            } else {
              return Center(child: Text("Start chatting!"));
            }
          },
        ),
        bottomNavigationBar: _MessageInput(chatId: chatId),
      ),
    );
  }
}

class _MessageInput extends StatelessWidget {
  final String chatId;

  const _MessageInput({Key? key, required this.chatId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(hintText: "Type your message..."),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              final content = controller.text.trim();
              if (content.isNotEmpty) {
                context.read<ChatBloc>().add(SendMessage(
                  chatId: chatId,
                  sender: "You", // Replace with actual sender
                  content: content,
                ));
                controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}