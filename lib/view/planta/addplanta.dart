// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pohanhanapp/commons/alerta.dart';
import 'package:pohanhanapp/model/planta_model.dart';
import 'package:pohanhanapp/provider/AppProvider.dart';
import 'package:provider/provider.dart';

class AddPlanta extends StatefulWidget {
  const AddPlanta({Key? key}) : super(key: key);

  @override
  State<AddPlanta> createState() => _AddPlantaState();
}

class _AddPlantaState extends State<AddPlanta> {
  TextEditingController _nombre = TextEditingController();
  TextEditingController _descripcion = TextEditingController();
  String imageString = "";
  late File imageFile;
  String imageData = "";

  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Nueva Planta",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green[600],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("..Cargar imagen.."),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      // ignore: deprecated_member_use
                      child: OutlineButton(
                        borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.8), width: 1.0),
                        onPressed: () async {
                          final ImagePicker _picker = ImagePicker();
                          // ignore: deprecated_member_use
                          PickedFile? _archivo = await _picker.getImage(
                              source: ImageSource.gallery);
                          setState(() {
                            imageString = _archivo!.path;
                            imageFile = File(_archivo.path);
                          });
                          //imageData = base64Encode(imageFile.readAsBytesSync()).toString();
                          imageData =
                              base64.encode(imageFile.readAsBytesSync());
                        },
                        child: (imageString == "")
                            ? const Padding(
                                padding:
                                    EdgeInsets.fromLTRB(14.0, 50.0, 14.0, 50.0),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.grey,
                                ),
                              )
                            : Image.file(
                                File(imageString),
                                width: 250,
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.brown.withOpacity(0.4),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ListTile(
                            title: TextFormField(
                              controller: _nombre,
                              decoration: const InputDecoration(
                                hintText: "Nombre de planta",
                                border: InputBorder.none,
                              ),
                              //validator: (value) {},
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.brown.withOpacity(0.4),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ListTile(
                            title: TextFormField(
                              controller: _descripcion,
                              decoration: const InputDecoration(
                                hintText: "Breve descripción",
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
                        print("Longitud es: ");
                        print(imageData.length);

                        if (_nombre.text != "") {
                          if (_descripcion.text != "") {
                            PlantaModel plantaModel = PlantaModel(
                                idplanta: 0,
                                nombre: _nombre.text,
                                descripcion: _descripcion.text,
                                estado: "AC",
                                img: imageData);
                            appProvider.plantaService
                                .agregar(plantaModel)
                                .then((value) {
                              if (value == true) {
                                setState(() {
                                  _descripcion =
                                      TextEditingController(text: "");
                                  _nombre = TextEditingController(text: "");
                                });
                                //changeScreenReplacement(context, const Main());
                                
                                Navigator.pop(context);

                                mensajeEmergente(
                                    "Registro almacenado", context);
                              } else {
                                mensajeEmergente(
                                    "Error en la insercion", context);
                              }
                            });
                          } else {
                            mensajeEmergente("Complete descripcion", context);
                          }
                        } else {
                          mensajeEmergente("Complete nombre", context);
                        }
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
