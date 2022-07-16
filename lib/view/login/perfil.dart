// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:pohapp/provider/AppProvider.dart';
import 'package:provider/provider.dart';


class Perfil extends StatefulWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {

  @override
  Widget build(BuildContext context) {
    
    var appProvider = Provider.of<AppProvider>(context);

    return Container(
      alignment: Alignment.center,
      color: Colors.blueGrey.shade900,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Sesion Iniciada',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 8),
          CircleAvatar(
            maxRadius: 25,
            backgroundImage: NetworkImage(appProvider.loginGoogle.user.photoURL),
          ),
          const SizedBox(height: 8),
          Text(
            'Name: ' + appProvider.loginGoogle.user.displayName,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'Email: ' + appProvider.loginGoogle.user.email,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              
            },
            child: const Text('Cerrar sesion'),
          )
        ],
      ),
    );
  }
}