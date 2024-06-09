import 'package:escucha_tu_historia/config/backend_values/app_config.dart';
import 'package:escucha_tu_historia/models/routes.dart';
import 'package:http/http.dart';

class RoutesService {
  final String _url = AppConfig.BASE_URL;
  final String _apiKey = AppConfig.API_KEY;

  Future<List<Routes>> getAllRoutes() async {
    try {
      Response response =
          await get(Uri.parse('$_url/routes/all'), headers: {
        'api_key': _apiKey,
      });

      return routesFromJson(response.body);
    } catch (e) {
      print(e);
      return [];
    }
  }
}
