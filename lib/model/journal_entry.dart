import 'dart:io';

import 'package:daily_journal/constants/enum.dart';
import 'package:hive/hive.dart';

part 'journal_entry.g.dart';

@HiveType(typeId: HIVEMODEL.JOURNALENTRY)
class JournalEntry extends HiveObject {
  @HiveField(JournalEntryEnum.TITLE)
  String title;

  @HiveField(JournalEntryEnum.CONTENT)
  String content;

  @HiveField(JournalEntryEnum.DATE)
  DateTime date;

  @HiveField(JournalEntryEnum.STATUS)
  String? status;

  @HiveField(JournalEntryEnum.FILE)
  String? filePath;

  @HiveField(JournalEntryEnum.TAG)
  List<String>? tagList;

  JournalEntry(
      {required this.title,
      required this.content,
      required this.date,
      required this.status,
      this.filePath,
      this.tagList});
}
