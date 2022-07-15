


import 'package:pohapp/model/poha_model.dart';

abstract class PohaService{
 Future<List<PohaModel>> listar();
 Future like(String nombre);
 Future<List> listarJson();
 Future<PohaModel> poha(int id);
 Future<bool> agregar(PohaModel poha);
 Future<bool> eliminar(PohaModel poha);
 Future<bool> actualizar(PohaModel poha);
}