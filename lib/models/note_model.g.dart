// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteModelAdapter extends TypeAdapter<NoteModel> {
  @override
  final int typeId = 0;

  @override
  NoteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteModel(
      title: fields[0] as String,
      descraption: fields[1] as String,
      colornote: fields[2] as int,
      date: fields[3] as String,
      datetime: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.descraption)
      ..writeByte(2)
      ..write(obj.colornote)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.datetime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
