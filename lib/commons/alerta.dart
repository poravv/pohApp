
// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mensajeEmergente(String mensaje, context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Alerta'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(mensaje),
                const Divider(),
                Image.asset("asset/hoja5.png",height: 30,)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }