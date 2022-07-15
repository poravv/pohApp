

import 'package:pohapp/model/planta_model.dart';

abstract class PlantaService{
 Future<List<PlantaModel>> listar();
 Future like(String nombre);
 Future<List> listarJson();
 Future<PlantaModel> planta(int id);
 Future<bool> agregar(PlantaModel planta);
 Future<bool> eliminar(PlantaModel planta);
 Future<bool> actualizar(PlantaModel planta);
}