// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:pohanhanapp/model/planta_model.dart';
import 'package:pohanhanapp/service/planta_service.dart';
import 'package:pohanhanapp/service_implement/planta_controller.dart';


enum Status { uninitialized, authenticated, authenticating, unauthenticated }

class AppProvider with ChangeNotifier {
  PlantaService plantaService = PlantaImplement();
  Status status = Status.uninitialized;
  late PlantaModel plantaModel;
  //late UsuarioModel usuarioLoggin ;

  AppProvider.initialize(){
    print("App Inicializada");
  }

  setPlantaModel(PlantaModel planta) {
    plantaModel = planta;
  }

  PlantaModel getPlantaModel() {
    return plantaModel;
  }

}
