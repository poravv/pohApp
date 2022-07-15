import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pohapp/commons/alerta.dart';
import 'package:pohapp/model/planta_model.dart';
import 'package:pohapp/provider/AppProvider.dart';
import 'package:pohapp/service_implement/planta_controller.dart';
import 'package:pohapp/view/planta/addplanta.dart';
import 'package:provider/provider.dart';

class LstPlanta extends StatefulWidget {
  const LstPlanta({Key? key}) : super(key: key);

  @override
  _LstPlantaState createState() => _LstPlantaState();
}

class _LstPlantaState extends State<LstPlanta> {
  List<PlantaModel> lista = [];
  bool loading = true;

  getPlanta() async {
    lista = await PlantaImplement().listar();
    setState(() {
      loading = false;
    });
  }

  showImage(var image) {
    const asciiDecoder = AsciiDecoder();
    final asciiValues = image;
    var result = asciiDecoder.convert(asciiValues);
    //print(result);
    return Image.memory(base64Decode(result),height: 150,);
  }

  @override
  void initState() {
    

    getPlanta();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        backgroundColor: Colors.black,
        title: const Text("Plantas"),
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: () {
              Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const AddPlanta()))
                  .then((value) => getPlanta());
            },
            child: const Text(
              "Nuevo",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blue,
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue[100],
            child: Row(
              children: const [
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Descripcion"),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Estado"),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Eliminar"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                //scrollDirection: Axis.vertical,
                itemCount: lista.length,
                itemBuilder: (BuildContext context, int index) {
                  // ignore: unnecessary_null_comparison
                  if (lista == null) {
                    return const Center(
                      child: Text("No se han cargado Plantaes"),
                    );
                  } else {
                    return InkWell(
                      child: Card(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(lista[index].descripcion.isEmpty
                                        ? "Descripcion"
                                        : lista[index].descripcion),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(lista[index].estado == "AC"
                                        ? "Activo"
                                        : "Inactivo"),
                                  ),
                                ),

                                //Image.memory(),
                                //lista[index].img
                                //Image.memory(Uint8List.fromList(lista[index].img['data'].cast<int>())),
                                //Image.memory(Uint8List.fromList((lista[index].img).contentAsBytes() )),
                                //Image.memory(Uint8List.fromList(listaInt)),
                                //Image.memory(base64Decode(showImage(lista[index].img['data'].toString() ))),
                                //Image.memory(Uint8List.fromList(base64Decode(showImage(lista[index].img['data'].toString() )) )),
                                //Image.memory(base64Decode(lista[index].img['data'].toString())),
                                //Image.memory(base64Decode(result),height: 150,),
                                showImage(lista[index].img['data'].cast<int>()),

                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        appProvider.plantaService
                                            .eliminar(lista[index])
                                            .then((value) {
                                          if (value == true) {
                                            getPlanta();
                                            //Fluttertoast.showToast(msg: "Registro eliminado");
                                            mensajeEmergente(
                                                "Registro eliminado", context);
                                          } else {
                                            //Fluttertoast.showToast(msg: "Error en la elimnacion");
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        /*Navigator.of(context)
                            .push( MaterialPageRoute(
                                builder: (context) =>
                                     EditPlanta(lista[index])))
                            .then((value) => getPlanta());*/
                      },
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
