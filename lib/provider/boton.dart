import 'package:flutter/material.dart';
import 'package:nuevo_projecto/colores.dart';

class Boton extends StatelessWidget {
  const Boton({super.key, required this.nombre, required this.alPresionar});
  final String nombre;
  final Function alPresionar;
  @override
  Widget build(BuildContext context) {
    return Material(elevation: 25,color: Colors.transparent,
      child: GestureDetector(
          onTap: () => alPresionar(),
          child: Container(
            width: 120,
            height: 40,
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(color: const Color.fromARGB(255, 20, 93, 153),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  nombre,
                  style: const TextStyle(
                    color: Colors.white,
                   
                  ),
                )
              ],
            ),
          )),
    );
  }
}
