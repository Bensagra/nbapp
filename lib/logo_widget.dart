import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  Logo({
    super.key,
    required this.imagen,
    required this.color,
    required this.nombre,
    required this.onTap,
  });
  String imagen = '';
  Color color;
  VoidCallback onTap;
  String nombre;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(70),
          color: color.withOpacity(0.5),
        ),
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.only(left: 5, top: 5),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Image.asset('lib/assets/$imagen'),
        ),
      ),
    );
  }
}
