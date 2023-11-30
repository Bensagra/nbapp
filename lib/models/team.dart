import 'package:flutter/material.dart';

class Team {
  final int id;
  final String abbreviation;
  final String city;
  final String conference;
  final String division;
  final String fullName;
  final String name;

  String? logo;
  Color? color;
  String fondo = '';
  int victorias;
  int derrotas;

  Team({
    required this.id,
    required this.abbreviation,
    required this.city,
    required this.conference,
    required this.division,
    required this.fullName,
    required this.name,
    this.logo,
    this.color,
    this.fondo = '',
    this.victorias = 0,
    this.derrotas = 0,
  });

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      id: map['id'] ?? 0,
      abbreviation: map['abbreviation'] ?? '',
      city: map['city'] ?? '',
      conference: map['conference'] ?? '',
      division: map['division'] ?? '',
      fullName: map['full_name'] ?? '',
      name: map['name'] ?? '',
      logo: '',
      color: Colors.white,
      fondo: '',
    );
  }
}
