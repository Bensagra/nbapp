import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:nuevo_projecto/colores.dart';
import 'package:nuevo_projecto/logo_widget.dart';
import 'package:nuevo_projecto/models/team.dart';
import 'package:nuevo_projecto/provider/boton.dart';
import 'package:nuevo_projecto/provider/home_provider.dart';
import 'package:nuevo_projecto/tabla_de_posiciones_widget.dart';
import 'package:nuevo_projecto/tarjeta.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'models/partido.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    final Size size = MediaQuery.of(context).size;

    DateTime _selectedDay = DateTime.now();
    DateTime _focusedDay = DateTime.now();
    String conferencia = '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Row(
          children: [const Text(
                  'NBA',
                  style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w900,
                      fontSize: 23),
                ),            
            SizedBox(height: 65, width: 40,child: 
             
                IconButton(
                  onPressed: null,
                  icon: Image.asset('lib/assets/Logo_Nba.png'),
                  style: const ButtonStyle(
                alignment: Alignment.centerLeft,
                      
                  )
                  
                ),
                  
            ),
          ],
        ),
      ),
      body: homeProvider.statusDownload
          ? Container(
              height: size.height,
              width: size.width,
              color: Colores.azulLogo,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset('lib/assets/basquet.json',
                      width: size.width * .8),
                  SizedBox(
                    width: size.width,
                    height: 150,
                    child: Lottie.asset('lib/assets/nba.json'),
                  ),
                ],
              ),
            )
          : Stack(
              children: [
               Container(color: Colores.azulLogo,),
                Column(
                  children: [
                    SizedBox(
                      height: 65,
                      width: size.width,
                      child: homeProvider.teams.isEmpty
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Colores.azulLogo,
                              ),
                            )
                          : ListView.builder(
                              itemBuilder: (context, index) {
                                Team tempTeam = homeProvider.teams[index];
                                return Logo(
                                    nombre: tempTeam.abbreviation,
                                    onTap: () =>
                                        homeProvider.onTapTeam(tempTeam),
                                    imagen: tempTeam.logo!,
                                    color: tempTeam.color!);
                              },
                              itemCount: homeProvider.teams.length,
                              scrollDirection: Axis.horizontal,
                            ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (!homeProvider.showTabla)
                      Container(
                        color: Colors.white70.withOpacity(0.8),
                        child: TableCalendar(
                          firstDay: DateTime.utc(2010, 10, 16),
                          lastDay: DateTime.utc(2030, 3, 14),
                          focusedDay: _focusedDay,
                          calendarStyle: CalendarStyle(
                              tableBorder: TableBorder.all(width: 1),
                              selectedDecoration: BoxDecoration(
                                  color: Colores.azulLogo,
                                  shape: BoxShape.circle)),
                          calendarFormat: CalendarFormat.week,
                          onDaySelected: (selectedDay, focusedDay) {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                            homeProvider.partidosPorDia(selectedDay);
                          },
                        ),
                      ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Boton(
                                nombre: 'Partidos en vivo',
                                alPresionar: () {
                                  homeProvider.teamSelected = null;
                                  homeProvider.fondo();
                                  homeProvider.ocultarTabla();
                                  homeProvider.buscarPartidosEnVivo();
                                }),
                            Boton(
                                nombre: 'Partidos de hoy',
                                alPresionar: () {
                                  homeProvider.teamSelected = null;
                                  homeProvider.fondo();
                                  homeProvider.partidosPorDia(DateTime.now());
                                  homeProvider.ocultarTabla();
                                }),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Boton(
                                nombre: 'Conferencia Este',
                                alPresionar: () {
                                  homeProvider.armarTabla('East');
                                  homeProvider.teamSelected = null;
                                  homeProvider.fondo();
                                }),
                            Boton(
                                nombre: 'Conferencia Oeste',
                                alPresionar: () {
                                  homeProvider.armarTabla('West');
                                  homeProvider.teamSelected = null;
                                  homeProvider.fondo();
                                })
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: homeProvider.showTabla
                          ? TablaDePosiciones(
                              conferenciaAMostrar:
                                  homeProvider.conferenciaAMostrar,
                              coloresPorPosicion:
                                  homeProvider.coloresPorPosicion,
                            )
                          : homeProvider.partidosAMostrar.isEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height: size.height * 0.3,
                                        child: Lottie.asset(
                                          'lib/assets/volcada.json',
                                        )),
                                    Text(
                                      'No se han encontrado partidos',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colores.azulLogo,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ],
                                )
                              : SingleChildScrollView(
                                  controller: homeProvider.scrollController,
                                  child: Column(
                                    children: [
                                      for (Partido partido
                                          in homeProvider.partidosAMostrar)
                                        Column(
                                          children: [
                                            Tarjeta(
                                              onTap: () => homeProvider
                                                  .onTap(partido.idGame),
                                              logoLocal: homeProvider
                                                  .buscarEquipoPorID(
                                                      partido.idLocal),
                                              logoVisitante: homeProvider
                                                  .buscarEquipoPorID(
                                                      partido.idVisitante),
                                              fechaPartido: partido.fechaPartido
                                                  .substring(0, 10),
                                              marcadorLocal: partido
                                                  .marcadorLocal
                                                  .toString(),
                                              marcadorVisitante: partido
                                                  .marcadorVisitante
                                                  .toString(),
                                              status: partido.status,
                                              fechayHora:  partido.fechayHora,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
