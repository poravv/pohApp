// ignore_for_file: file_names

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:pohapp/buscador/buscadorPlantas.dart';
import 'package:pohapp/commons/alerta.dart';
import 'package:pohapp/model/autor_model.dart';
import 'package:pohapp/model/planta_model.dart';
import 'package:pohapp/provider/AppProvider.dart';
import 'package:pohapp/service_implement/autor_controller.dart';
import 'package:pohapp/service_implement/planta_controller.dart';
import 'package:provider/provider.dart';

class AddPoha extends StatefulWidget {
  const AddPoha({Key? key}) : super(key: key);

  @override
  State<AddPoha> createState() => _AddPohaState();
}

class _AddPohaState extends State<AddPoha> with SingleTickerProviderStateMixin {
  TextEditingController _recomendacion = TextEditingController();
  TextEditingController _prepacacion = TextEditingController();
  TextEditingController _nombre = TextEditingController();
  TextEditingController _apellido = TextEditingController();
  TextEditingController _ciudad = TextEditingController();
  TextEditingController _pais = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isLoading = false;
  late PlantaModel plantaSeleccionada;
  List<PlantaModel> lstPlantas = [];
  List<PlantaModel> listaPlantas = [];
  bool te = false;
  bool mate = false;
  bool terere = false;
  DateTime nacimiento= DateTime.now();

  final particleOptions = ParticleOptions(
    image: Image.asset("asset/hoja2.png"),
    baseColor: Colors.red,
    spawnOpacity: 0.0,
    opacityChangeRate: 0.25,
    minOpacity: 0.1,
    maxOpacity: 0.4,
    spawnMinSpeed: 20.0,
    spawnMaxSpeed: 70.0,
    spawnMinRadius: 20.0,
    spawnMaxRadius: 30.0,
    particleCount: 9,
  );

  getPlantas() async {
    listaPlantas = await PlantaImplement().listar();
  }

  @override
  void initState() {
    plantaSeleccionada = PlantaModel(
        descripcion: "", estado: "", idplanta: 0, nombre: "", img: "");
    getPlantas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Agregar Pohã ñana",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green[600],
      ),
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(options: particleOptions),
        vsync: this,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.brown.withOpacity(0.5),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(children: const [
                                  Text('Plantas medicinales'),
                                ]),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(plantaSeleccionada.nombre)),
                                    Expanded(
                                      child: IconButton(
                                          onPressed: () {
                                            /*showSearch(
                                                    context: context,
                                                    delegate: DataSearchPlanta())

                                                .then((value) {
                                              setState(() {
                                                plantaSeleccionada = appProvider
                                                    .getPlantaModel();
                                              });
                                            });*/
                                            Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            const BuscadorPlantas()))
                                                .then((value) {
                                              setState(() {
                                                plantaSeleccionada = appProvider
                                                    .getPlantaModel();
                                              });
                                            });
                                          },
                                          icon: const Icon(Icons.search)),
                                    ),
                                    Expanded(
                                      child: IconButton(
                                          onPressed: () {
                                            bool validInsert = true;
                                            for (int i = 0;
                                                i < lstPlantas.length;
                                                i++) {
                                              if (lstPlantas[i].nombre ==
                                                  plantaSeleccionada.nombre) {
                                                validInsert = false;
                                              }
                                            }

                                            setState(() {
                                              if (plantaSeleccionada.nombre !=
                                                  "") {
                                                if (validInsert == true) {
                                                  lstPlantas.add(appProvider
                                                      .getPlantaModel());
                                                } else {
                                                  mensajeEmergente(
                                                      "Planta ya agregada",
                                                      context);
                                                }
                                              } else {
                                                mensajeEmergente(
                                                    "Seleccione planta medicinal",
                                                    context);
                                              }
                                              plantaSeleccionada = PlantaModel(
                                                  descripcion: "",
                                                  estado: "",
                                                  idplanta: 0,
                                                  nombre: "",
                                                  img: "");
                                              appProvider.plantaModel =
                                                  plantaSeleccionada;
                                            });
                                          },
                                          icon: const Icon(Icons.add)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: lstPlantas.isNotEmpty
                            ? Container(
                                //height: 150,
                                decoration: const BoxDecoration(
                                    //border:Border.all(color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.horizontal()),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: lstPlantas.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Card(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15),
                                                        child: Text(lstPlantas[
                                                                        index]
                                                                    .nombre !=
                                                                ""
                                                            ? lstPlantas[index]
                                                                .nombre
                                                            : "Nombre"),
                                                      ),
                                                    ),
                                                    Column(
                                                      children: [
                                                        SizedBox(
                                                          //color: Colors.red,
                                                          child: IconButton(
                                                            icon: const Icon(
                                                                Icons.delete),
                                                            onPressed: () {
                                                              setState(() {
                                                                lstPlantas.remove(
                                                                    lstPlantas[
                                                                        index]);
                                                              });
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              )
                            : const Center(
                                child: Text("No se ha cargado Plantas"),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.brown.withOpacity(0.5),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _prepacacion,
                                decoration: const InputDecoration(
                                  hintText: "Preparacion",
                                  border: InputBorder.none,
                                ),
                                //validator: (value) {},
                              ),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.brown.withOpacity(0.5),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _recomendacion,
                                decoration: const InputDecoration(
                                  hintText: "Recomendación",
                                  border: InputBorder.none,
                                ),
                                //validator: (value) {},
                              ),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Expanded(
                                child: Text(
                              "Te",
                            )),
                            Expanded(
                              child: Checkbox(
                                checkColor: Colors.white,
                                //fillColor: MaterialStateProperty.resolveWith(getColor),
                                value: te,
                                onChanged: (bool? value) {
                                  setState(() {
                                    te = value!;
                                  });
                                },
                              ),
                            ),
                            const Expanded(
                              child: Text(
                                "Mate",
                              ),
                            ),
                            Expanded(
                              child: Checkbox(
                                checkColor: Colors.white,
                                value: mate,
                                onChanged: (bool? value) {
                                  setState(() {
                                    mate = value!;
                                  });
                                },
                              ),
                            ),
                            const Expanded(
                              child: Text(
                                "Terere",
                              ),
                            ),
                            Expanded(
                              child: Checkbox(
                                checkColor: Colors.white,
                                value: terere,
                                onChanged: (bool? value) {
                                  setState(() {
                                    terere = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("Datos de Autor "),
                                Text(
                                  "(Opcional)",
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.red),
                                ),
                              ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.brown.withOpacity(0.5),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _nombre,
                                decoration: const InputDecoration(
                                  hintText: "Nombre",
                                  border: InputBorder.none,
                                ),
                                //validator: (value) {},
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.brown.withOpacity(0.5),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _apellido,
                                decoration: const InputDecoration(
                                  hintText: "Apellido",
                                  border: InputBorder.none,
                                ),
                                //validator: (value) {},
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.brown.withOpacity(0.5),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                      nacimiento 
                                          .toString()
                                          .substring(0, 10),
                                      style: const TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15)),
                                ),
                                SizedBox(
                                  height: 40,
                                  width: 150,
                                  // ignore: deprecated_member_use
                                  child: RaisedButton(
                                    color: Colors.green,
                                    child: const Center(
                                        child: Text(
                                      "Fecha de Nacimiento",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                    onPressed: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate:
                                            nacimiento,
                                        firstDate: DateTime(1960),
                                        lastDate: DateTime(2222),
                                      ).then((date) {
                                        setState(() {
                                          nacimiento = date!;
                                        });
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.brown.withOpacity(0.5),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _ciudad,
                                decoration: const InputDecoration(
                                  hintText: "Ciudad",
                                  border: InputBorder.none,
                                ),
                                //validator: (value) {},
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.brown.withOpacity(0.5),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _pais,
                                decoration: const InputDecoration(
                                  hintText: "Pais",
                                  border: InputBorder.none,
                                ),
                                //validator: (value) {},
                              ),
                            ),
                          ),
                        ),
                      ),
                      //-------------------------------------------------------------
                      const Divider(),
                      // ignore: deprecated_member_use
                      FlatButton(
                        color: Colors.brown,
                        textColor: Colors.white,
                        child: const Text("Agregar"),
                        onPressed: () {
                          try {
                            if (_prepacacion.text != "" &&
                                _recomendacion.text != "") {
                              
                              AutorModel autorModel = AutorModel(idautor: 0, nombre: _nombre.text, 
                              apellido: _apellido.text , nacimiento: nacimiento , ciudad: _ciudad.text, pais: _pais.text);

                              AutorImplement().agregar(autorModel).then((value) {
                                autorModel=value;
                              });

                              _prepacacion = TextEditingController();
                              _recomendacion = TextEditingController();
                              _nombre = TextEditingController();
                              _apellido = TextEditingController();
                              _ciudad = TextEditingController();
                              _pais = TextEditingController();
                              mensajeEmergente("Registro almacenado", context);
                            } else {
                              mensajeEmergente(
                                  "Complete preparacion y recomendacion",
                                  context);
                            }
                          } catch (e) {
                            mensajeEmergente("Error en el registro", context);
                          }
                        },
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
