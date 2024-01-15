// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detallesusuario.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DetallesUsuarioAdapter extends TypeAdapter<DetallesUsuario> {
  @override
  final int typeId = 2;

  @override
  DetallesUsuario read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DetallesUsuario(
      nombre: fields[0] as String,
      salario: fields[1] as int,
      tipoPago: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DetallesUsuario obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.nombre)
      ..writeByte(1)
      ..write(obj.salario)
      ..writeByte(2)
      ..write(obj.tipoPago);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetallesUsuarioAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
