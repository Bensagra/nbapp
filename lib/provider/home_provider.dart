import 'package:flutter/material.dart';
import 'package:nuevo_projecto/colores.dart';
import 'package:nuevo_projecto/provider/resume.dart';
import 'package:nuevo_projecto/repository.dart';
import '../models/team.dart';
import '../models/partido.dart';
import 'package:nuevo_projecto/agregarLogoYColor.dart';

class HomeProvider with ChangeNotifier {
  // --------Variables------------
  final List<Team> _teams = [];
  List<Team> get teams => _teams;
  final List<Partido> _listaPartidosDesdeApiCompleta = [];
  List<Partido> get partidos => _listaPartidosDesdeApiCompleta;
  Color coloresTabla = Colors.white;
  List<Partido> get partidosProximos => _listaPartidosDesdeApiCompleta
      .where((element) => element.status != 'Final')
      .toList();
  List<Partido> get partidosEnVivo => _listaPartidosDesdeApiCompleta
      .where((element) =>
          element.status.contains('Qtr') )
      .toList();
  String conferencia = '';
  bool statusDownload = false;
  DateTime calendarSelectedDay = DateTime.now();
  List<Partido> partidosAMostrar = [];
  Team? teamSelected;
  final Repository repository = Repository();
  List<Team> oeste = [];
  List<Team> este = [];
  // --------Variables------------
  coloresPorPosicion(int index) {
    if (index <= 5) {
      return Color.fromARGB(232, 199, 5, 28);
    }
    if (index > 5 && index <= 9) {
      return Color.fromARGB(255, 149, 6, 30);
    }
    if (index > 9) {
      return Color.fromARGB(255, 128, 5, 5);
    }
  }
// --------bajarApi------------

  void pegarApi(int idGame) async {
    int index =
        partidosAMostrar.indexWhere((element) => element.idGame == idGame);
    try {
      var partidoEnVivo = await repository.getGames(idGame: idGame);
      partidosAMostrar.removeAt(index);
      partidosAMostrar.insert(index, Partido.fromMap(partidoEnVivo));

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void addAllTeamsFromApi() async {
    try {
      List teamsTemp = await repository.getAllTeams();
      for (var team in teamsTemp) {
        addTeam(Team.fromMap(team));
      }
      agregarLogoColorYFondo(_teams);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getResultsFromApi() async {
    statusDownload = true;
    notifyListeners();
    int lastPage = 0;
    try {
      var response = await repository.getGames(perPage: 100);
      lastPage = response['meta']['total_pages'];
    } catch (e) {
      print(e);
    }

    for (var varName = lastPage; varName >= lastPage - 30; varName--) {
      try {
        var response = await repository.getGames(page: varName, perPage: 100);
        List partidos = response['data'];
        for (var partido in partidos) {
          addpartido(Partido.fromMap(partido));
        }
        partidosPorDia(DateTime.now());
      } catch (e) {
        print(e);
      }
    }
    for (var partido in partidos) {
      if (partido.season == 2023 || partido.season == 2024) {
        if (partido.status == 'Final') {
          Team teamLocal =
              teams.firstWhere((element) => element.id == partido.idLocal);
          Team teamVisitante =
              teams.firstWhere((element) => element.id == partido.idVisitante);
          if (partido.marcadorLocal > partido.marcadorVisitante) {
            teamLocal.victorias = teamLocal.victorias + 1;
            teamVisitante.derrotas = teamVisitante.derrotas + 1;
          }
          if (partido.marcadorLocal < partido.marcadorVisitante) {
            teamLocal.derrotas = teamLocal.derrotas + 1;
            teamVisitante.victorias = teamVisitante.victorias + 1;
          }
        }
      }
    }
    print(teams[1].victorias);
    print(teams[1].derrotas);
    statusDownload = false;
    notifyListeners();
  }

// --------BajarApi------------
// --------Partidos------------

  void dividirEquiposEnConferencia() {
    List teamsTemp = [];
    teamsTemp.addAll(teams);
    oeste.clear();
    este.clear();
    teamsTemp.sort(
      (a, b) => b.victorias.compareTo(a.victorias),
    );
    for (var team in teamsTemp
        .where((element) => element.conference == conferencia)
        .toList()) {
      if (conferencia == 'West') {
        oeste.add(team);
      }
      if (conferencia == 'East') {
        este.add(team);
      }
    }
  }

  bool showTabla = false;

  void partidosPorDia(DateTime dia) {
    showTabla = false;
    boolPartidoEnVivo = false;
    calendarSelectedDay = dia;
    List<Partido> temp = [];
    DateTime horario;
String day = '';
    for (Partido partido in _listaPartidosDesdeApiCompleta) {
      String fecha = partido.fechaPartido.substring(0, 10);
      switch (partido.fechaPartido.split(":")[0].trimRight().trimLeft()[10]) {
        case "00": 
          day = {int.parse(fecha.split('-')[2]) + 1}.toString();
          break;
           case "01": 
          day = {int.parse(fecha.split('-')[2]) + 1}.toString();
          break;
           case "02": 
          day = {int.parse(fecha.split('-')[2]) + 1}.toString();
          break;
          default:
          day = fecha.split('-')[2];
          
      }
      
      String year = fecha.split('-')[0];
      String month = fecha.split('-')[1];
          DateTime fechaArreglada =
          DateTime(int.parse(year), int.parse(month), int.parse(day));
      
      

      

      if (fechaArreglada.year == dia.year &&
          fechaArreglada.month == dia.month &&
          fechaArreglada.day == dia.day) {
        temp.add(partido);
      }
    }
    partidosAMostrar.clear();
    temp.sort(
      (a, b) => a
          .ordenarPartidosPorHorario()
          .toString()
          .compareTo(b.ordenarPartidosPorHorario().toString()),
    );

    partidosAMostrar.addAll(temp);
    temp.clear();
    temp.addAll(partidosAMostrar.where((element) => element.status == 'Final'));
    partidosAMostrar.removeWhere((element) => element.status == 'Final');
    partidosAMostrar.addAll(temp);

    calendarSelectedDay = dia;
    notifyListeners();
  }

  void buscarPartidosEnVivo() {
    boolPartidoEnVivo = true;
    partidosAMostrar.clear();
    partidosAMostrar.addAll(partidosEnVivo);
    showTabla = false;

    notifyListeners();
  }

  final ScrollController scrollController = ScrollController();

  void buscarPartidosPorEquipo() async {
    final List<Partido> temp = _listaPartidosDesdeApiCompleta
        .where((element) =>
            element.idLocal == teamSelected!.id ||
            element.idVisitante == teamSelected!.id)
        .toList();

    temp.sort((a, b) {
      return a.fechaPartido.compareTo(b.fechaPartido);
    });
    List<Partido> tempProximos = [];
    List<Partido> tempAnteriores = [];
    List<Partido> partidoEnVivo = [];
    tempProximos.addAll(temp.where((element) =>
        element.status != 'Final' ||
        element.status.contains('Qtr')));
    tempAnteriores.addAll(temp.where((element) => element.status == 'Final'));
    partidoEnVivo.addAll(temp.where((element) =>
       element.status.contains('Qtr')));

    temp.clear();
    temp.addAll(partidoEnVivo);
    temp.addAll(tempAnteriores);
    temp.addAll(tempProximos);
    int tempIndex = 0;
    // for (var var_name = 0; var_name < temp.length; var_name++) {
    //   if (temp[var_name].fecha.year == DateTime.now().year &&
    //       temp[var_name].fecha.month == DateTime.now().month &&
    //       temp[var_name].fecha.day <= DateTime.now().day) {
    //     tempIndex = var_name;
    //   }
    // }

    tempIndex = temp.indexWhere((element) => element == partidoEnVivo);
    if (tempIndex == null) {}
    tempIndex = temp.indexWhere((element) => element == tempProximos[0]);
    partidosAMostrar.clear();
    partidosAMostrar.addAll(temp);
    await Future.delayed(Duration(milliseconds: 200));
    scrollController.jumpTo(140 * (tempIndex.toDouble() - 1));
    notifyListeners();
  }

  buscarEquipoPorID(int id) {
    return _teams.firstWhere((element) => element.id == id).logo;
  }

  buscarpartido() {
    for (var partido in _listaPartidosDesdeApiCompleta) {
      return partido.fechaPartido;
    }
  }

// ---------AgreganCosas--------------
  HomeProvider.alIniciar() {
    addAllTeamsFromApi();
    getResultsFromApi();
  }

  void selectTeam(Team team) {
    teamSelected = team;
    notifyListeners();
  }

  void addTeam(Team team) {
    _teams.add(team);
    notifyListeners();
  }

  void addpartido(Partido partido) {
    _listaPartidosDesdeApiCompleta.add(partido);
  }

  String fondo() {
    if (teamSelected != null && teamSelected!.fondo != '') {
      return '${teamSelected!.abbreviation}Fondo.jpg';
    } else {
      return 'Fondo_blanco.jpg';
    }
  }

  bool boolPartidoEnVivo = false;

  onTap(int idGame) {
    
    pegarApi(idGame);
    
  }

  List<Team> conferenciaAMostrar = [];
  // ---------AgreganCosas--------------

  void armarTabla(String conf) {
    conferencia = conf;
    dividirEquiposEnConferencia();
    conferenciaAMostrar.clear();
    if (conf == 'East') {
      conferenciaAMostrar.addAll(este);
    } else {
      conferenciaAMostrar.addAll(oeste);
    }
    showTabla = true;
    notifyListeners();
  }

  ocultarTabla() {
    showTabla = false;
    notifyListeners();
  }

  void onTapTeam(Team team) {
    ocultarTabla();
    selectTeam(team);
    buscarPartidosPorEquipo();
    boolPartidoEnVivo = false;
  }
}
