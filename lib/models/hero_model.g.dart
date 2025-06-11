// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hero_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HeroModelAdapter extends TypeAdapter<HeroModel> {
  @override
  final int typeId = 0;

  @override
  HeroModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HeroModel(
      image: fields[0] as String?,
      name: fields[1] as String?,
      gender: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HeroModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.gender);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeroModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
