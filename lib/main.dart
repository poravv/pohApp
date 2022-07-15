import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pohapp/home.dart';
import 'package:pohapp/provider/AppProvider.dart';
import 'package:pohapp/view/login/google.dart';
import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides{
  //comentar para llevar a ambiente productivo
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider.initialize()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.blue[600]),
        home: const Main(),
      ),
    ),
  );
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PohApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Barra(),
    );
  }
}

class Barra extends StatefulWidget {
  const Barra({Key? key}) : super(key: key);

  @override
  State<Barra> createState() => _BarraState();
}

class _BarraState extends State<Barra> {
  // ignore: unused_field
  int _indiceSeleccionado = 0;
  PageController pageController = PageController();
  LoginGoogle loginGoogle =LoginGoogle();
  voidPaginas(int index) {
    setState(() {
      _indiceSeleccionado = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Poha ÑanApp",style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.green[600],
        ),
        body: PageView(
          controller: pageController,
          children: [
            const Home(),
            Container(
              color: Colors.green,
            ),
            Container(
              color: Colors.amber,
            )
          ],
        ),
        floatingActionButton: InkWell(
            child: Image.asset(
          "asset/hoja4.png",
          height: 70,
        ),
        onTap: (){
          //Navigator.push(context,MaterialPageRoute(builder: (_) => const AddPoha()));
          loginGoogle.handleSignIn();

        },),
        //floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.brown[400],
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Mecicinales',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Ajustes',
            ),
          ],
          currentIndex: _indiceSeleccionado,
          selectedItemColor: Colors.lightGreenAccent,
          selectedIconTheme:
              const IconThemeData(color: Colors.lightGreenAccent, size: 45),
          onTap: voidPaginas,
        ));
  }
}
