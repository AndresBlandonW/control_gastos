
import 'package:control_gastos/models/detallesusuario.dart';
import 'package:control_gastos/providers/usuario/usuario_box_provider.dart';
import 'package:control_gastos/providers/usuario/usuario_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


final setDetallesUsuarioViewModelProvider =
    ChangeNotifierProvider.autoDispose((ref) => SetDetallesUsuarioViewModel(ref));

    
class SetDetallesUsuarioViewModel extends ChangeNotifier {
  final Ref _ref;

  SetDetallesUsuarioViewModel(this._ref);

  Future<void> write(DetallesUsuario usuario) async {
      try {
        final box = await _ref.read(detallesUsuarioBoxProvider.future);
        await box.add(usuario);
        _ref.refresh(detallesusuarioProvider);
        _ref.refresh(detallesUsuarioBoxProvider);

      } catch (e) {
        return Future.error(e);
      }
  }

  Future<void> update(DetallesUsuario usuario) async {
      try {
        final box = await _ref.read(detallesUsuarioBoxProvider.future);
        await box.put(0, usuario);
        _ref.refresh(detallesUsuarioBoxProvider);
        _ref.refresh(detallesusuarioProvider);

      } catch (e) {
        return Future.error(e);
      }
  }

}