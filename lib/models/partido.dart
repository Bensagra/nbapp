import 'package:flutter/material.dart';


class Partido {
  final int marcadorLocal;
  final int marcadorVisitante;
  final String fechaPartido;
  final String status;
  final int idGame;
  final int idLocal;
  final int idVisitante;
  final int season;
  TimeOfDay horarioPartido = TimeOfDay(hour: 00, minute: 00);
  final DateTime fechayHora;

  String get fecha {
    if (status == '1st Qtr' ||
        status == '2nd Qtr' ||
        status == '3rd Qtr' ||
        status == '4th Qtr' ) {
      return status;
    }
    if (status.split("T")[1].split(":")[0] == "03") {
   int year = int.parse(fechaPartido.split('-')[0]);
    int month = int.parse(fechaPartido.split('-')[1]);
    int day = int.parse(fechaPartido.split('-')[2].trimRight()[14])+1;
    return DateTime(year, month, day, ) .toString();
 }
//   else if (status.split("T")[1].split(":")[0] == "01") {
//     int year = int.parse(fechaPartido.split('-')[0]);
//     int month = int.parse(fechaPartido.split('-')[1]);
//     int day = int.parse(fechaPartido.split('-')[2].trimRight()[14])+1;
//     return DateTime(year, month, day, );
//  }
//   else if (status.split("T")[1].split(":")[0] == "02") {
//     int year = int.parse(fechaPartido.split('-')[0]);
//     int month = int.parse(fechaPartido.split('-')[1]);
//     int day = int.parse(fechaPartido.split('-')[2].trimRight()[14])+1;
//     return DateTime(year, month, day, );
//  }else if (status.split("T")[1].split(":")[0] == "03") {
//     int year = int.parse(fechaPartido.split('-')[0]);
//     int month = int.parse(fechaPartido.split('-')[1]);
//     int day = int.parse(fechaPartido.split('-')[2].trimRight()[14])+1;
//     return DateTime(year, month, day, );
 else{ int year = int.parse(fechaPartido.split('-')[0]);
    int month = int.parse(fechaPartido.split('-')[1]);
    int day = int.parse(fechaPartido.split('-')[2].trimRight()[14]);
    return DateTime(year, month, day, ).toString();


    
    
    
    
  }}

  Partido({
    required this.marcadorLocal,
    required this.marcadorVisitante,
    required this.fechaPartido,
    required this.season,
    required this.status,
    required this.idGame,
    required this.idLocal,
    required this.idVisitante,
    required this.fechayHora,

  });

  factory Partido.fromMap(Map<String, dynamic> map) {
    return Partido(
      idLocal: map['home_team']['id'] ?? 0,
      idGame: map['id'] ?? 0,
      fechaPartido: map['date'] ?? '',
      season: map['season'] ?? 0,
      idVisitante: map['visitor_team']['id'] ?? 0,
      marcadorLocal: map['home_team_score'] ?? 0,
      marcadorVisitante: map['visitor_team_score'] ?? 0,
      status: map['status'] ?? '',
      fechayHora: DateTime.parse(map['date'] ?? ''),
    );
  }

  ordenarPartidosPorHorario() {
    if (status != '1st Qtr' &&
        status != '2nd Qtr' &&
        status != '3rd Qtr' &&
        status != '4th Qtr' &&
        status != 'Final') {
      horarioPartido = TimeOfDay(
        hour: int.parse(status.replaceRange(0, 11, "").split(':')[0] ),
        minute: int.parse(status.split(':')[1]),
      );
      return horarioPartido;
    } else {
      return status;
    }
  }
}
