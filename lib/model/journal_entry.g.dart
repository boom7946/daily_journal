// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JournalEntryAdapter extends TypeAdapter<JournalEntry> {
  @override
  final int typeId = 0;

  @override
  JournalEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JournalEntry(
      title: fields[0] as String,
      content: fields[1] as String,
      date: fields[2] as DateTime,
      status: fields[3] as String?,
      filePath: fields[4] as String?,
      tagList: (fields[5] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, JournalEntry obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.filePath)
      ..writeByte(5)
      ..write(obj.tagList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JournalEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
