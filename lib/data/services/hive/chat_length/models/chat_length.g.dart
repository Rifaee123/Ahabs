// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_length.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatLengthModelAdapter extends TypeAdapter<ChatLengthModel> {
  @override
  final int typeId = 0;

  @override
  ChatLengthModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatLengthModel(
      latestMsg: fields[2] as String?,
      latestTime: fields[3] as DateTime?,
      latestCount: fields[4] as int?,
      roomId: fields[0] as String?,
      chatLength: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ChatLengthModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.roomId)
      ..writeByte(1)
      ..write(obj.chatLength)
      ..writeByte(2)
      ..write(obj.latestMsg)
      ..writeByte(3)
      ..write(obj.latestTime)
      ..writeByte(4)
      ..write(obj.latestCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatLengthModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
