import 'package:equatable/equatable.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

class HomePageState extends NavigationState {}

class ChatPageState extends NavigationState {
  final String chatId;

  const ChatPageState({required this.chatId});

  @override
  List<Object> get props => [chatId];
}

