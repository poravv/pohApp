import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ignore: unused_field
  int _indiceSeleccionado = 0;
  PageController pageController = PageController();

  voidPaginas(int index) {
    setState(() {
      _indiceSeleccionado = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: const[
        SizedBox(
          height: 100,
          child: Center(
            child: Text(
              "Te damos la cordial Bienvenida",
              style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
                "Poha ÑanApp nace con la intencion de educar e informar acerca de las propiedades de las plantas y sus combinaciones para distintos tipos de dolencias.",
                textAlign: TextAlign.center,
              ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
                "Aqui podras hallar información, recetas de los remedios caceros, y a su vez ir nutriendo nuestra base de conocimientos ancestrales con tu propio aporte",
                textAlign: TextAlign.center,
              ),
        )
      ]),
    );
  }
}
