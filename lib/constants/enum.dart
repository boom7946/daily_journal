// ignore_for_file: constant_identifier_names

class HIVEMODEL {
  static const int JOURNALENTRY = 0;
}

class JournalEntryEnum {
  static const int TITLE = 0;
  static const int CONTENT = 1;
  static const int DATE = 2;
  static const int STATUS = 3;
  static const int FILE = 4;
  static const int TAG = 5;
}

class JournalStatus {
  static const String DRAFT = "Draft";
  static const String PUBLISHED = "Published";
  static const String ARCHIVED = "Archived";
  static const String DELETED = "Deleted";
}
