// ignore_for_file: file_names

import 'dart:convert';

PlantaModel userFromJson(String str) => PlantaModel.fromJson(json.decode(str));

String userToJson(PlantaModel data) => json.encode(data.toJson());

class PlantaModel {
  int idplanta;
  String nombre;
  String descripcion;
  String estado;
  dynamic img;

  PlantaModel({
    required this.idplanta,
    required this.nombre,
    required this.descripcion,
    required this.estado,
    required this.img,
  });


  factory PlantaModel.fromJson(Map<String,dynamic> json)=> PlantaModel(
    nombre: json["nombre"],
    descripcion: json["descripcion"],
    estado: json["estado"],
    idplanta: json["idplanta"],
    img: json["img"]
  );

  Map<String,dynamic> toJson()=>{
    "descripcion":descripcion,
    "estado":estado,
    "nombre":nombre,
    "img":img
  };

}
