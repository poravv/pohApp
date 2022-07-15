import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pohapp/model/autor_model.dart';
import 'package:pohapp/service/autor_service.dart';

class AutorImplement implements AutorService {
  var httpClient = http.Client();

  @override
  Future<AutorModel> agregar(AutorModel autor) async {
    
    // ignore: prefer_typing_uninitialized_variables
    var rsautor;
    final response = await http.post(
        Uri.parse('http://186.158.152.141:4000/api/pohapp/autor/post'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          //"Authorization": "Bearer " + token
        },
        body: autor.toJson()
        );

    var data = json.decode(response.body);
    print(data);

    if (response.statusCode == 200) {

      if (response.body.isNotEmpty) {
        var data = json.decode(response.body);
        rsautor = AutorModel(
            nombre: data["nombre"],
            apellido: data["apellido"],
            nacimiento: DateTime.parse(data["nacimiento"]),
            idautor: data["idautor"],
            ciudad: data["ciudad"],
            pais: data["pais"],
          );
      }
    }
    return rsautor;

  }

  @override
  Future<AutorModel> autor(int id) async {
    // ignore: prefer_typing_uninitialized_variables
    var autor;

    final response = await http.get(
      Uri.parse('http://186.158.152.141:4000/api/pohapp/autor/get/$id'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
    );

    if (response.body.isNotEmpty) {
      var data = json.decode(response.body);
      for (var u in data['body']) {
        autor = AutorModel(
          nombre: u["nombre"],
          apellido: u["apellido"],
          nacimiento: u["nacimiento"],
          idautor: u["idautor"],
          ciudad: u["ciudad"],
          pais: u["pais"],
        );
      }
    }
    return autor;
  }

  @override
  Future<bool> eliminar(AutorModel autor) async {
    final response = await http.delete(
      Uri.parse('http://186.158.152.141:4000/api/pohapp/autor/delete/' +
          autor.idautor.toString()),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      //body: autor.toJson()
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
  Future<List<AutorModel>> listar() async {
    List<AutorModel> autors = [];
    try {
      final response = await http.get(
        Uri.parse('http://186.158.152.141:4000/api/pohapp/autor/get/'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );

      if (response.body.isNotEmpty) {
        var data = json.decode(response.body);
        for (var u in data) {
          AutorModel c = AutorModel(
            nombre: u["nombre"],
            apellido: u["apellido"],
            nacimiento: u["nacimiento"],
            idautor: u["idautor"],
            ciudad: u["ciudad"],
            pais: u["pais"],
          );
          autors.add(c);
        }
      }
    } catch (e) {
      print(e);
    }
    return autors;
  }

  @override
  Future like(String nombre) async {
    // ignore: prefer_typing_uninitialized_variables
    var data = [];
    try {
      final response = await http.get(
        Uri.parse(
            'http://186.158.152.141:4000/api/pohapp/autor/getsql/$nombre'),
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
        Uri.parse('http://186.158.152.141:4000/api/pohapp/autor/get/'),
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
  Future<bool> actualizar(AutorModel autor) async {
    final response = await http.put(
        Uri.parse('http://186.158.152.141:4000/api/pohapp/autor/put/' +
            autor.idautor.toString()),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: autor.toJson());

    var data = json.decode(response.body);
    print(data);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
