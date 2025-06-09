import 'package:daily_journal/model/journal_entry.dart';
import 'package:hive_flutter/adapters.dart';

class HiveHelper {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(JournalEntryAdapter());
    await openBox<JournalEntry>('journalBox');
  }

  static Future<Box<T>> openBox<T>(String boxName) async {
    return await Hive.openBox<T>(boxName);
  }
}
