// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productos.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductosAdapter extends TypeAdapter<Productos> {
  @override
  final int typeId = 3;

  @override
  Productos read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Productos(
      nombre: fields[0] as String,
      valor: fields[1] as int,
      estado: fields[2] as int,
      mes: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Productos obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.nombre)
      ..writeByte(1)
      ..write(obj.valor)
      ..writeByte(2)
      ..write(obj.estado)
      ..writeByte(3)
      ..write(obj.mes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductosAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
