import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'colores.dart';
import 'models/team.dart';

class TablaDePosiciones extends StatelessWidget {
  const TablaDePosiciones(
      {super.key,
      required this.conferenciaAMostrar,
      required this.coloresPorPosicion});
  final List<Team> conferenciaAMostrar;
  final Function(int) coloresPorPosicion;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            color: Colores.azulLogo,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Container(
                //   alignment: Alignment.center,
                //   width: size.width * .2,
                //   child: Text('Posicion'),
                // ),
                // Container(
                //   width: size.width * .1,
                //   child: Text('Logo'),
                // ),
                // Container(
                //   alignment: Alignment.center,
                //   width: size.width * .3,
                //   child: Text('Nombre'),
                // ),
                Container(
                  alignment: Alignment.centerRight,
                  width: size.width * .2,
                  child: const Text(
                    'Victorias',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Noto Sans Japanese',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: size.width * .2,
                  margin: const EdgeInsets.only(
                    left: 0,
                    right: 0,
                  ),
                  child: const Text(
                    'Derrotas',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Noto Sans Japanese',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          for (var index = 0; index < conferenciaAMostrar.length; index++)
            Container(
              decoration: BoxDecoration(
                  color: coloresPorPosicion(index),
                  border: Border.all(color: Colores.azulLogo, width: 0.01)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * .2,
                    alignment: Alignment.center,
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Noto Sans Japanese',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    height: 25,
                    margin: const EdgeInsets.only(top: 2.10, bottom: 2.10),
                    width: size.width * .1,
                    alignment: Alignment.center,
                    child: Image.asset(
                      'lib/assets/${conferenciaAMostrar[index].logo!}',
                    ),
                  ),
                  SizedBox(
                    width: size.width * .3,
                    child: Text(
                      conferenciaAMostrar[index].name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Noto Sans Japanese',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      width: size.width * .15,
                      child: Text(
                        conferenciaAMostrar[index].victorias.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Noto Sans Japanese',
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                  Container(
                      alignment: Alignment.center,
                      width: size.width * .15,
                      child: Text(
                        conferenciaAMostrar[index].derrotas.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Noto Sans Japanese',
                          fontWeight: FontWeight.w600,
                        ),
                      ))
                ],
              ),
            )
        ],
      )),
    );
  }
}
