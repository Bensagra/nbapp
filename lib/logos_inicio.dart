import 'package:flutter/material.dart';

class Logos extends StatelessWidget {
  Logos({
    super.key,
    required this.imagen,
    required this.color,
  });
  String imagen = '';
  Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(70),
            color: color.withOpacity(0.5),
          ),
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.only(left: 5, top: 5),
          child: Image.asset(imagen)),
    );
  }
}
