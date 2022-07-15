

import 'package:pohapp/model/autor_model.dart';

abstract class AutorService{
 Future<List<AutorModel>> listar();
 Future like(String nombre);
 Future<List> listarJson();
 Future<AutorModel> autor(int id);
 Future<AutorModel> agregar(AutorModel autor);
 Future<bool> eliminar(AutorModel autor);
 Future<bool> actualizar(AutorModel autor);
}