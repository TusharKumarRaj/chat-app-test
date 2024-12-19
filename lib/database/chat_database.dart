import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part 'chat_database.g.dart';



class Messages extends Table {
  IntColumn get id => integer().autoIncrement()(); 
  TextColumn get chatId => text()(); 
  TextColumn get sender => text()(); 
  TextColumn get content => text()(); 
  DateTimeColumn get timestamp => dateTime()(); 
}


@DriftDatabase(tables: [Messages])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  
  Future<List<Message>> getMessagesByChat(String chatId) {
    return (select(messages)..where((m) => m.chatId.equals(chatId))).get();
  }

  
  Future<int> insertMessage(MessagesCompanion message) {
    return into(messages).insert(message);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}