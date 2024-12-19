import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:chat_app/bloc/navigation_bloc/navigation_state.dart';
import 'package:chat_app/ui/chat.dart'; 
import 'package:chat_app/ui/home%20page/home.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: MaterialApp(
        title: 'Chatting App',
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            if (state is ChatPageState) {
              // Ensure ChatScreen expects required arguments
              return ChatScreen(chatId: state.chatId);
            }
            return const HomePage();
          },
        ),
      ),
    );
  }
}
