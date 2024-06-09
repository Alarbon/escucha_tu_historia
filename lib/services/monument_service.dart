import 'package:escucha_tu_historia/config/backend_values/app_config.dart';
import 'package:escucha_tu_historia/models/monument.dart';
import 'package:escucha_tu_historia/models/monument_reduced.dart';
import 'package:escucha_tu_historia/responses/monument_reduced_response.dart';
import 'package:escucha_tu_historia/responses/monument_response.dart';
import 'package:escucha_tu_historia/share_preferences/preferences.dart';
import 'package:http/http.dart';

class MonumentService {
  final String _url = AppConfig.BASE_URL;
  final String _apiKey = AppConfig.API_KEY;

  Future<List<MonumentReduced>> getMonumentsReduced() async {
    try {
      Response response = await get(
          Uri.parse('$_url/monuments/reduced?lang=${Preferences.language}'),
          headers: {
            'api_key': _apiKey,
          });
      return monumentReducedResponseFromJson(response.body).monuments ?? [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<Monument> getMonument(int id) async {
    try {
      Response response = await get(
          Uri.parse('$_url/monuments/monument/$id/${Preferences.language}'),
          headers: {
            'api_key': _apiKey,
          });

      return monumentFromJson(response.body);
    } catch (e) {
      print(e);
      return Monument();
    }
  }

  Future<List<Monument>> getAllMonuments() async {
    try {
      Response response = await get(
          Uri.parse('$_url/monuments?lang=${Preferences.language}'),
          headers: {
            'api_key': _apiKey,
          });
      return monumentResponseFromJson(response.body).monuments ?? [];
    } catch (e) {
      print(e);
      return [];
    }
  }
}
