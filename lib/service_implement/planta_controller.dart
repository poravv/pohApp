import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pohanhanapp/model/planta_model.dart';
import 'package:pohanhanapp/service/planta_service.dart';

class PlantaImplement implements PlantaService {
  var httpClient = http.Client();

  @override
  Future<bool> agregar(PlantaModel planta) async {

    final response = await http.post(
        Uri.parse(
            'http://186.158.152.141:4000/api/pohapp/planta/post'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          //"Authorization": "Bearer " + token
        },
        body: planta.toJson()
        );

    //var data = json.decode(response.body);
    //print(data);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<PlantaModel> planta(int id) async {
    // ignore: prefer_typing_uninitialized_variables
    var planta;

    final response = await http.get(
      Uri.parse(
          'http://186.158.152.141:4000/api/pohapp/planta/get/$id'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
    );

    if (response.body.isNotEmpty) {
      var data = json.decode(response.body);
      for (var u in data['body']) {
        planta = PlantaModel(
            nombre: u["nombre"],
            descripcion: u["descripcion"],
            estado: u["estado"],
            idplanta: u["idplanta"],
            img: u["img"]??"");
      }
    }
    return planta;
  }

  @override
  Future<bool> eliminar(PlantaModel planta) async {
      final response = await http.delete(
        Uri.parse(
            'http://186.158.152.141:4000/api/pohapp/planta/delete/' +
                planta.idplanta.toString()),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        //body: planta.toJson()
      );

      //var data = json.decode(response.body);

      //print(data);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
  }

  @override
  Future<List<PlantaModel>> listar() async {
    List<PlantaModel> plantas = [];
    try {
      final response = await http.get(
        Uri.parse(
            'http://186.158.152.141:4000/api/pohapp/planta/get/'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );

      if (response.body.isNotEmpty) {
        var data = json.decode(response.body);
        for (var u in data) {
          PlantaModel c = PlantaModel(
              nombre: u["nombre"],
              descripcion: u["descripcion"],
              estado: u["estado"],
              idplanta: u["idplanta"],
              img:u["img"]??""
              );
          plantas.add(c);
        }
      }
    } catch (e) {
      print(e);
    }
    return plantas;
  }


  @override
  Future like(String nombre) async {

    // ignore: prefer_typing_uninitialized_variables
    var data=[];
    try {
      final response = await http.get(
        Uri.parse(
            'http://186.158.152.141:4000/api/pohapp/planta/getsql/$nombre'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );

      if (response.body.isNotEmpty) {
        data = json.decode(response.body);
      }
      //print(data);
    } catch (e) {
      //print(e);
    }
    return data;
  }

  @override
  Future<List> listarJson() async {
    // ignore: prefer_typing_uninitialized_variables
    var data;
    try {
      final response = await http.get(
        Uri.parse(
            'http://186.158.152.141:4000/api/pohapp/planta/get/'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );

      if (response.body.isNotEmpty) {
        data = json.decode(response.body);
      }
    } catch (e) {
      print(e);
    }
    return data['body'];
  }

  @override
  Future<bool> actualizar(PlantaModel planta) async {

    final response = await http.put(
        Uri.parse(
            'http://186.158.152.141:4000/api/pohapp/planta/put/' +
                planta.idplanta.toString()),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: planta.toJson());

    var data = json.decode(response.body);
    print(data);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
