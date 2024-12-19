import 'package:equatable/equatable.dart';

abstract class NavigationEvent extends Equatable{
    const NavigationEvent();


  @override
List<Object> get props => [];
}

class GoToHomePage extends NavigationEvent{}

class GoToChatPage extends NavigationEvent{
    final String chatID;

    const GoToChatPage(this.chatID);

    @override
    List<Object> get props => [chatID];
}

