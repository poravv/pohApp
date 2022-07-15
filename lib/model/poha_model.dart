// ignore_for_file: file_names

import 'dart:convert';

PohaModel userFromJson(String str) => PohaModel.fromJson(json.decode(str));

String userToJson(PohaModel data) => json.encode(data.toJson());

class PohaModel {
  int idpoha;
  String preparado;
  int mate;
  int te;
  int terere;
  String recomendacion;
  String estado;
  int idautor;
  int idusuario;

  PohaModel({
    required this.idpoha,
    required this.preparado,
    required this.recomendacion,
    required this.estado,
    required this.idautor,
    required this.idusuario,
    required this.mate,
    required this.te,
    required this.terere,
  });


  factory PohaModel.fromJson(Map<String,dynamic> json)=> PohaModel(
    preparado: json["preparado"],
    recomendacion: json["recomendacion"],
    estado: json["estado"],
    idpoha: json["idpoha"],
    idautor: json["idautor"],
    mate: json["mate"],
    te: json["te"],
    terere: json["terere"],
    idusuario: json["idusuario"]
  );

  Map<String,dynamic> toJson()=>{
    "recomendacion":recomendacion,
    "estado":estado,
    "preparado":preparado,
    "idautor":idautor,
    "idusuario":idusuario,
    "mate":mate,
    "te":te,
    "terere":terere,
  };

}
