// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:pohapp/model/planta_model.dart';
import 'package:pohapp/service/planta_service.dart';
import 'package:pohapp/service_implement/planta_controller.dart';
import 'package:pohapp/view/login/google.dart';


enum Status { uninitialized, authenticated, authenticating, unauthenticated }

class AppProvider with ChangeNotifier {
  PlantaService plantaService = PlantaImplement();
  Status status = Status.uninitialized;
  late PlantaModel plantaModel;
  LoginGoogle loginGoogle = LoginGoogle();

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
