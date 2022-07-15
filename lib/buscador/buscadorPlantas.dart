// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:pohanhanapp/model/planta_model.dart';
import 'package:pohanhanapp/provider/AppProvider.dart';
import 'package:pohanhanapp/service_implement/planta_controller.dart';
import 'package:provider/provider.dart';

class BuscadorPlantas extends StatefulWidget {
  const BuscadorPlantas({Key? key}) : super(key: key);

  @override
  State<BuscadorPlantas> createState() => _BuscadorPlantasState();
}

class _BuscadorPlantasState extends State<BuscadorPlantas> {
  bool isLoading = false;
  String nombre="";

  Future getPlantas(String nombre) async {
    return await PlantaImplement().like(nombre);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Buscar planta",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green[600],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Material(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.brown.withOpacity(0.4),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: ListTile(
                  title: TextField(
                    decoration: const InputDecoration(
                      hintText: "Introdusca nombre",
                      border: InputBorder.none,
                    ),
                    onChanged: (text) {
                      
                      setState(() {
                        //getPlantas(text);
                        nombre=text;
                      });

                    },
                  ),
                ),
              ),
            ),
          ),
          FutureBuilder(
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                    child: Text("..Escriba nombre de la planta.."));
              } else if (snapshot.data.length == 0) {
                return const Center(
                    child: Text("..Planta no encontrada, favor agregar.."));
              } else {
                return ListView.builder(
                  shrinkWrap:true , 
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: Image.asset(
                      "asset/hoja4.png",
                      height: 30,
                    ),
                    title: InkWell(
                      child: RichText(
                        text: TextSpan(
                          text: snapshot.data[index]['nombre'] ?? "",
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    trailing: InkWell(
                      child: const Icon(
                        Icons.add,
                        color: Colors.brown,
                      ),
                      onTap: () {
                        PlantaModel plantaModel = PlantaModel(
                            idplanta: snapshot.data[index]['idplanta'],
                            nombre: snapshot.data[index]['nombre'],
                            descripcion: snapshot.data[index]['descripcion'],
                            estado: snapshot.data[index]['estado'],
                            img: snapshot.data[index]['img']);
                        
                        appProvider.setPlantaModel(plantaModel);

                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              }
            },
            future: getPlantas(nombre),
          ),

        ],
      ),
    );
  }
}
