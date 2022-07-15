import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pohanhanapp/model/poha_model.dart';
import 'package:pohanhanapp/service/poha_service.dart';

class PohaImplement implements PohaService {
  var httpClient = http.Client();

  @override
  Future<bool> agregar(PohaModel poha) async {

    final response = await http.post(
        Uri.parse(
            'http://186.158.152.141:4000/api/pohapp/poha/post'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          //"Authorization": "Bearer " + token
        },
        body: poha.toJson()
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
  Future<PohaModel> poha(int id) async {
    // ignore: prefer_typing_uninitialized_variables
    var poha;

    final response = await http.get(
      Uri.parse(
          'http://186.158.152.141:4000/api/pohapp/poha/get/$id'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
    );

    if (response.body.isNotEmpty) {
      var data = json.decode(response.body);
      for (var u in data['body']) {
        poha = PohaModel(
            preparado: u["preparado"],
            recomendacion: u["recomendacion"],
            estado: u["estado"],
            idpoha: u["idpoha"],
            mate: u["mate"],
            te: u["te"],
            terere: u["terere"],
            idautor: u["idautor"],
            idusuario: u["idusuario"],
            );
      }
    }
    return poha;
  }

  @override
  Future<bool> eliminar(PohaModel poha) async {
      final response = await http.delete(
        Uri.parse(
            'http://186.158.152.141:4000/api/pohapp/poha/delete/' +
                poha.idpoha.toString()),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        //body: poha.toJson()
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
  Future<List<PohaModel>> listar() async {
    List<PohaModel> pohas = [];
    try {
      final response = await http.get(
        Uri.parse(
            'http://186.158.152.141:4000/api/pohapp/poha/get/'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );

      if (response.body.isNotEmpty) {
        var data = json.decode(response.body);
        for (var u in data) {
          PohaModel c = PohaModel(
              preparado: u["preparado"],
            recomendacion: u["recomendacion"],
            estado: u["estado"],
            idpoha: u["idpoha"],
            mate: u["mate"],
            te: u["te"],
            terere: u["terere"],
            idautor: u["idautor"],
            idusuario: u["idusuario"],
              );
          pohas.add(c);
        }
      }
    } catch (e) {
      print(e);
    }
    return pohas;
  }


  @override
  Future like(String preparado) async {

    // ignore: prefer_typing_uninitialized_variables
    var data=[];
    try {
      final response = await http.get(
        Uri.parse(
            'http://186.158.152.141:4000/api/pohapp/poha/getsql/$preparado'),
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
            'http://186.158.152.141:4000/api/pohapp/poha/get/'),
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
  Future<bool> actualizar(PohaModel poha) async {

    final response = await http.put(
        Uri.parse(
            'http://186.158.152.141:4000/api/pohapp/poha/put/' +
                poha.idpoha.toString()),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: poha.toJson());

    var data = json.decode(response.body);
    print(data);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
