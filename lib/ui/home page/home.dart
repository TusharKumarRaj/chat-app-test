import 'package:flutter/material.dart';
import 'top_button.dart';
import 'package:chat_app/bloc/navigation_bloc/navigation_event.dart';
import 'package:chat_app/bloc/navigation_bloc/navigation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/bloc/navigation_bloc/navigation_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final String chatID='1';
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text('Chats'),
        ),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        backgroundColor: const Color.fromARGB(255, 8, 52, 4),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
              children: [
                IconButton(onPressed: (){}, icon: Icon(Icons.search), color: Colors.white,),
                IconButton(onPressed: (){}, icon: Icon(Icons.archive), color: Colors.white,),
              ],
            ),
          ),

          
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<NavigationBloc, NavigationState>(
                  builder: (context, state) {
                    return  TopButton(
                  label: 'TrailPals',
                  onPressed: () {
                     //TODO: Write logic for switching to "mytrailpals" section also it should get filled when clicked on 
                  },
                );
                  },
                ),
                const SizedBox(width: 8),
               
                BlocBuilder<NavigationBloc, NavigationState>(
                  builder: (context, state) {
                    return  TopButton(
                  label: 'Events',
                  onPressed: () {
                    //TODO: write logic for switching to "Events" section also it should get filled when clicked on 
                  },
                );
                  },
                ),
               
                const SizedBox(width: 8), 
                TopButton(
                  label: 'Dummy',
                  onPressed: () {
                    
                  },
                ),
              ],
            ),
          ),
           BlocBuilder<NavigationBloc, NavigationState>(
                  builder: (context, state) {
                    return  ElevatedButton(onPressed: (){ context.read<NavigationBloc>().add(GoToChatPage(chatID));  }, child: Text('Go to this chat'));
                  },
                ),
          
        ],
      ),
    );
  }
}