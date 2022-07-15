// ignore_for_file: file_names

import 'dart:convert';

AutorModel userFromJson(String str) => AutorModel.fromJson(json.decode(str));

String userToJson(AutorModel data) => json.encode(data.toJson());

class AutorModel {
  int idautor;
  String nombre;
  String apellido;
  DateTime nacimiento;
  String ciudad;
  String pais;

  AutorModel({
    required this.idautor,
    required this.nombre,
    required this.apellido,
    required this.nacimiento,
    required this.ciudad,
    required this.pais,
  });


  factory AutorModel.fromJson(Map<String,dynamic> json)=> AutorModel(
    nombre: json["nombre"],
    apellido: json["apellido"],
    nacimiento: json["nacimiento"],
    idautor: json["idautor"],
    ciudad: json["ciudad"],
    pais: json["pais"],

  );

  Map<String,dynamic> toJson()=>{
    "apellido":apellido,
    "nacimiento":nacimiento.toString().substring(0,10),
    "nombre":nombre,
    "ciudad":ciudad,
    "pais":pais
  };

}
