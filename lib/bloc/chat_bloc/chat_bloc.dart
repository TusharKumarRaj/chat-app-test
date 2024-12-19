import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/database/chat_database.dart';
import 'package:chat_app/bloc/chat_bloc/chat_event.dart';
import 'package:chat_app/bloc/chat_bloc/chat_state.dart';
import 'package:drift/drift.dart';


class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final AppDatabase database;

  ChatBloc(this.database) : super(ChatInitial()) {
    on<LoadMessages>(_onLoadMessages);
    on<SendMessage>(_onSendMessage);
  }

  Future<void> _onLoadMessages(LoadMessages event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    try {
      final messages = await database.getMessagesByChat(event.chatId);
      emit(ChatLoaded(messages));
    } catch (e) {
      emit(ChatError("Failed to load messages: $e"));
    }
  }

  Future<void> _onSendMessage(SendMessage event, Emitter<ChatState> emit) async {
    try {
      final message = MessagesCompanion(
        chatId: Value(event.chatId),
        sender: Value(event.sender),
        content: Value(event.content),
        timestamp: Value(DateTime.now()),
      );
      await database.insertMessage(message);

      // Reload messages after sending
      add(LoadMessages(event.chatId));
    } catch (e) {
      emit(ChatError("Failed to send message: $e"));
    }
  }
}