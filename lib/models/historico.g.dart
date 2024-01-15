// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historico.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoricoAdapter extends TypeAdapter<Historico> {
  @override
  final int typeId = 1;

  @override
  Historico read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Historico(
      prdId: fields[0] as int,
      producto: fields[1] as String,
      tipo: fields[2] as int,
      valor: fields[3] as int,
      fecha: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Historico obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.prdId)
      ..writeByte(1)
      ..write(obj.producto)
      ..writeByte(2)
      ..write(obj.tipo)
      ..writeByte(3)
      ..write(obj.valor)
      ..writeByte(4)
      ..write(obj.fecha);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoricoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
