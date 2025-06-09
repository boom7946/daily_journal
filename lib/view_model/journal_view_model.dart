import 'package:daily_journal/model/journal_entry.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class JournalViewModel extends ChangeNotifier {
  final Box<JournalEntry> _journalBox = Hive.box<JournalEntry>('journalBox');

  List<JournalEntry> get entries =>
      _journalBox.values.toList().reversed.toList();

  void addEntry(JournalEntry entry) {
    _journalBox.add(entry);
    notifyListeners();
  }

  void deleteEntry(JournalEntry entry) {
    entry.delete();
    notifyListeners();
  }

  void updateEntry(JournalEntry entry, String newTitle, String newContent,
      {String? status, List<String>? tagList}) {
    entry.title = newTitle;
    entry.content = newContent;
    entry.status = status;
    entry.tagList = tagList ?? [];
    entry.save();
    notifyListeners();
  }
}
