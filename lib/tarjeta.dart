import 'package:flutter/material.dart';
import 'package:nuevo_projecto/provider/resume.dart';

class Tarjeta extends StatelessWidget {
  const Tarjeta({
    super.key,
    required this.marcadorLocal,
    required this.marcadorVisitante,
    required this.fechaPartido,
    required this.status,
    required this.logoLocal,
    required this.onTap,
    required this.logoVisitante,
    required this.fechayHora,
  });
  final String logoLocal;
  final String marcadorLocal;
  final String marcadorVisitante;
  final String fechaPartido;
  final String status;
  final String logoVisitante;
  final VoidCallback onTap;
  final DateTime fechayHora;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){if (status != "Final") {
        onTap();
      }else {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Resume()));
      }},
      child: Material(
        elevation: 10,
        child: Container(
            height: 120,
            width: size.width - 20,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                )),
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                  width: size.width,
                  child: Text(
                    fechaPartido,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      logo(logoLocal),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(marcadorLocal,
                              style: const TextStyle(
                                  fontSize: 35,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          const Text('-',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 35,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          Text(marcadorVisitante,
                              style: const TextStyle(
                                  fontSize: 35,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      logo(logoVisitante),
                    ]),
                SizedBox(
                  child: Text(
                    status != "Final" && status != "1qrt" && status != "2qrt" && status != "3qrt" && status != "4qrt" ? 
                    hora(status)  : status,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget logo(String logo) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Image.asset(
        'lib/assets/$logo',
      ),
    );
  }
}
 
String hora(String status) {
  if (status.contains('Qtr')) {
    return status;
  }else
 if (status.split("T")[1].split(":")[0] == "00") {
   return "21:00";
 }
  else if (status.split("T")[1].split(":")[0] == "01") {
   return "22:00";
 }
  else if (status.split("T")[1].split(":")[0] == "02") {
   return "23:00";
 }else if (status.split("T")[1].split(":")[0] == "03") {
   return "00:00";
 }else{
  
   return {int.parse(status.split("T")[1].split(":")[0]) - 3}.toString().padRight(3, ":").padRight(5, status.split(":")[2].trimRight()[1]);
  
}}