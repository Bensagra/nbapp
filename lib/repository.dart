import 'package:dio/dio.dart';

class Repository {
  final String xRapidAPIKey =
      '46bc56ee97mshf91220d3a67eea8p15873djsna60f84912c19';
  final String xRapidAPIHost = 'free-nba.p.rapidapi.com';

  Future<Map<String, dynamic>> getGames(
      {int? idGame, int? perPage, int? page}) async {
    try {
      String link = '';
      if (idGame != null) {
        link = 'https://free-nba.p.rapidapi.com/games/$idGame';
      } else {
        link = 'https://free-nba.p.rapidapi.com/games';
      }
      var response = await Dio().get(link,
          queryParameters: {
            'page': page,
            'per_page': perPage,
          },
          options: Options(
            headers: {
              'X-RapidAPI-Key': xRapidAPIKey,
              'X-RapidAPI-Host': xRapidAPIHost,
            },
          ));
      return response.data;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<dynamic>> getAllTeams() async {
    try {
      var response = await Dio().get('https://free-nba.p.rapidapi.com/teams',
          options: Options(
            headers: {
              'X-RapidAPI-Key': xRapidAPIKey,
              'X-RapidAPI-Host': xRapidAPIHost,
            },
          ));

      return response.data['data'];
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
