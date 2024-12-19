import 'package:bloc/bloc.dart';
import 'navigation_event.dart';
import 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(HomePageState()) {
    on<GoToHomePage>((event, emit) => emit(HomePageState()));
    on<GoToChatPage>((event, emit) => emit(ChatPageState(chatId: event.chatID)));

  }
}
